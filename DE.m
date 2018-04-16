function DE(funcObj, populationSize, problemSize, Inf, Sup, F, CR, selectionType,crossover, maxIterations, maxEvaluations)
    X = generatePopulation(populationSize, problemSize, Inf, Sup);
    
    %Stop when it has reach a fixed amount of evaluation of the fitness
    for i = 1:maxEvaluations
        %for each individual in the population
        for j= 1:populationSize
            %Trial or random selection of individuals
            %agarrar tres index random de la matriz
            newSpecies = selectRandom(X);
            
            %Apply directional mutation 
            if selectionType == 'random'
                V = newSpecies(1) + F*(newSpecies(2) - newSpecies(3))
                
            elseif selectionType == 'trial'
                %select the best newSpecies
                V = newSpecies(1) + F*(newSpecies(2) - newSpecies(3))
                 
            %Apply to trial vector the crossover to produce a child
            n =floor(rand()*problemSize+1);

            if strcmp(crossover,'bin')
                %Binomial crossover
                for k = 1:problemSize
                    randX = rand();
                    if randX <= CR || j == n
                        S(j,k) = V(j,k)
                    else
                         S(j,k) = X(j,k) 
                    end
                end
            elseif  strcmp(crossover,'exp')
                %Exponential crossover
                L = 1;
                Q(j) = X(j);
                randX = rand();
                while randX > CR || L == problemSize
                    S(j,k) = V(j,k);
                    k = mod(k+1,problemSize);
                    L = L + 1;
                end
            end
            
            % if the child individual is better than the current one then
            if funcObj(S(j,:)) < funcObj(X(j,:))
                NextGen = S(j,:);
            else
                NextGen = X(j,:);
            end
             X(j,:)=NextGen;
            end
        % Evaluate each individual's fitness value, and put the result in the Y matrix.
        %Y(j,:)=funcObj(X(j,:));
        end
        % Select the lowest fitness value
        %minMatrix = min(Y);
        %[value,index] = find(Y==minMatrix);
        
         % plot the picture of iteration
            figure(2);
            plot(i,0,'r.');
            xlabel('Iteration');
            ylabel('Fitness');
			title(sprintf('Iteration=%d, Fitness=%9.9f',i,0));
            grid on;
            hold on;
        
    end
end

