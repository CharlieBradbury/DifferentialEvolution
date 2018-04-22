function DE(funcObj, numSpecies, populationSize, problemSize, Inf, Sup, F, CR, selectionType,crossover, maxIterations, maxEvaluations)
    evalCant = 0;
    %Initialize each species
    for s = 1 : numSpecies
        X(s,:,:) = generatePopulation(populationSize, problemSize, Inf, Sup);
        XF(s,:) = zeros(populationSize, 1);
        %Evaluate all individuals in a species
        for k = 1 : populationSize
            evalCant = evalCant + 1;
            XF(s,k) = funcObj(X(s,k,:))
        end
    end
    
    % Obtain minimum
    globalMin = min(min(XF));
    cantNoChange = 0;
    i = 1;
    
    %Stop when it has reach a fixed amount of evaluation of the fitness
    while evalCant <= maxEvaluations && cantNoChange < maxIterations
        %For each species
        for s = 1 : numSpecies
            %for each individual in the population
            for j = 1 : populationSize
                %Trial or random selection of individuals
                %agarrar tres index random de la matriz
                newSpecies = selectRandom(X(s,:,:),3)

                %Apply directional mutation 
                if strcmp(selectionType,'random')
                    V = X(s,newSpecies(1),:) + F * (X(s,newSpecies(2),:) - X(s,newSpecies(3),:))
                    for k = 1 : problemSize
                        if V(k) > Sup(k)
                            V(k) = Sup(k);
                        elseif V(k) < Inf(k)
                            V(k) = Inf(k);
                        end
                    end 
                elseif strcmp(selectionType,'trial')
                    %select the best newSpecies
                    [~,bestIndex] = min(XF(s,newSpecies))
                    V = X(s,newSpecies(bestIndex),:) + F * (X(s,newSpecies(2),:) - X(s,newSpecies(3),:))
                end
                %Apply to trial vector the crossover to produce a child
                n = floor(rand()*problemSize+1);

                if strcmp(crossover,'bin')
                    disp("Ya entre");
                    %Binomial crossover
                    for k = 1:problemSize
                        randX = rand();
                        if randX <= CR || k == n
                            S(k) = V(k)
                        else
                             S(k) = X(s,j,k) 
                        end
                    end
                elseif  strcmp(crossover,'exp')
                    %Exponential crossover
                    L = 1;
                    S = X(s,j,:);
                    randX = rand();
                    % Do while clown fiesta
                    S(k) = V(k);
                    k = mod(k+1,problemSize);
                    L = L + 1;
                    while randX <= CR && L ~= problemSize
                        S(k) = V(k);
                        k = mod(k+1,problemSize);
                        L = L + 1;
                    end
                end

                % if the child individual is better than the current one then
                if funcObj(S) < XF(s,j)
                    NG(j,:) = S;
                    NGF(j) = funcObj(S);
                else
                    NG(j,:)  = X(s,j,:);
                    NGF(j) = XF(s,j);
                end
                evalCant = evalCant + 1;
            end
            X(s,:,:) = NG
            XF(s,:) = NGF
        end
        % Evaluate each individual's fitness value, and put the result in the Y matrix.
        %Y(j,:)=funcObj(X(j,:));
        % Select the lowest fitness value
        minFit(i) = min(min(XF))
        avgFit(i) = mean(min(XF))
        stdFit(i) = std(min(XF))
        
        if (globalMin == minFit(i))
            cantNoChange = cantNoChange + 1;
        else
            globalMin = minFit(i);
            cantNoChange = 0;
        end
        
        if (cantNoChange >= maxIterations || evalCant >= maxEvaluations)
            % plot the picture of iteration
            figure(2);
            plot(1:i,minFit,1:i,avgFit,1:i,stdFit);
            legend({'Best', 'Average', 'Standard Deviation'});
            xlabel('Iteration');
            ylabel('Fitness');
            title(sprintf('Iteration=%d, Fitness=%9.9f',i,minFit(i)));
            grid on;
            hold on;
        end
        i = i + 1;
    end
end

