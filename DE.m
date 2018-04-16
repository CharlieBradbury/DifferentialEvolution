function DE(funcObj, populationSize, problemSize, Inf, Sup, F, CR, selectionType,crossover, maxIterations, maxEvaluations)
    X = generatePopulation(populationSize, problemSize, Inf, Sup);
    XF = zeros(populationSize, 1);
    for i = 1 : populationSize
        XF(i) = funcObj(X(i,:))
    end
    
    %Stop when it has reach a fixed amount of evaluation of the fitness
    for i = 1:maxEvaluations
        %for each individual in the population
        for j= 1:populationSize
            %Trial or random selection of individuals
            %agarrar tres index random de la matriz
            newSpecies = selectRandom(X)
            
            %Apply directional mutation 
            if selectionType == 'random'
                V = X(newSpecies(1),:) + F * (X(newSpecies(2),:) - X(newSpecies(3)))
                for k = 1 : problemSize
                    if V(k) > Sup(k)
                        V(k) = Sup(k);
                    elseif V(k) < Inf(k)
                        V(k) = Inf(k);
                    end
                end
                
            elseif selectionType == 'trial'
                %select the best newSpecies
                V = X(newSpecies(1),:) + F * (X(newSpecies(2),:) - X(newSpecies(3)))
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
                         S(k) = X(j,k) 
                    end
                end
            elseif  strcmp(crossover,'exp')
                %Exponential crossover
                L = 1;
                S = X(j,:);
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
            if funcObj(S) < XF(j)
                NG(j,:) = S;
                NGF(j) = funcObj(S);
            else
                NG(j,:)  = X(j,:);
                NGF(j) = XF(j);
            end
        end
		X = NG
        XF = NGF
        % Evaluate each individual's fitness value, and put the result in the Y matrix.
        %Y(j,:)=funcObj(X(j,:));
        % Select the lowest fitness value
        minFit(i) = min(XF)
        
         % plot the picture of iteration
            figure(2);
            plot(1:i,minFit,'r--');
            xlabel('Iteration');
            ylabel('Fitness');
			title(sprintf('Iteration=%d, Fitness=%9.9f',i,minFit(i)));
            grid on;
            hold on;
        
    end
end

