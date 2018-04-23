% output = DE(funcObj, numSpecies, populationSize, problemSize, Inf, Sup, F, CR, cooperationType, selectionType,crossover, maxIterations, maxIterationsNoChange, maxEvaluations)
% funcObj - Fitness function handle
% numSpecies - Number of species created
% populationSize - Number of individuals in a species' population
% problemSize - Number of features in an individual
% Inf - Array containing inferior limits of each feature
% Sup - Array containing superior limits of each feature
% F - Differential weight
% CR - Crossover rate
% cooperationType - Cooperation type: 'random' or 'trial'
% selectionType - Selection type: 'random' or 'trial'
% crossover - Crossover type: 'bin' or 'exp'
% maxIterations: Max iterations of the algorithm
% maxIterationsNoChange: Max iterations without improving best solution
% maxEvaluations: Max number of fitness function evaluations
function output = CCEA(funcObj, numSpecies, populationSize, problemSize, Inf, Sup, F, CR, cooperationType, selectionType,crossover, maxIterations, maxIterationsNoChange, maxEvaluations)
    evalCant = 0;
    %Initialize each species
    for s = 1 : numSpecies
        X(s,:,:) = generatePopulation(populationSize, problemSize, Inf, Sup);
        XF(s,:) = zeros(populationSize, 1);
        %Evaluate all individuals in a species
        for k = 1 : populationSize
            evalCant = evalCant + 1;
            XF(s,k) = funcObj(X(s,k,:));
        end
    end
    
    % Obtain cooperation values for each species
    for s = 1 : numSpecies
        if strcmp(selectionType,'random')
            minIndexes = selectRandom(X(s,:,:),1);
            speciesMin(s) = XF(s,minIndexes);
        elseif strcmp(selectionType,'trial')
            minIndexes = selectRandom(X(s,:,:),2);
            speciesMin(s) = max(XF(s,minIndexes));
        end
        bestSpecies(s) = speciesMin(s);
    end
    % Select the lowest fitness value
    minFit(1) = min(speciesMin);
    avgFit(1) = mean(speciesMin);
    stdFit(1) = std(speciesMin);
    % Obtain best solution from cooperation values
    globalMin(1) = min(speciesMin);
    cantNoChange = 0;
    i = 2;
    
    %Stop when it has reach a fixed amount of evaluation of the fitness
    while i - 1 <= maxIterations && evalCant < maxEvaluations && cantNoChange < maxIterationsNoChange
        %For each species
        for s = 1 : numSpecies
            %for each individual in the population
            for j = 1 : populationSize
                %Trial or random selection of individuals
                %agarrar tres index random de la matriz
                newSpecies = selectRandom(X(s,:,:),3);

                %Apply directional mutation 
                if strcmp(selectionType,'random')
                    V = X(s,newSpecies(1),:) + F * (X(s,newSpecies(2),:) - X(s,newSpecies(3),:));
                    for k = 1 : problemSize
                        if V(k) > Sup(k)
                            V(k) = Sup(k);
                        elseif V(k) < Inf(k)
                            V(k) = Inf(k);
                        end
                    end 
                elseif strcmp(selectionType,'trial')
                    %select the best newSpecies
                    [~,bestIndex] = min(XF(s,newSpecies));
                    V = X(s,newSpecies(bestIndex),:) + F * (X(s,newSpecies(2),:) - X(s,newSpecies(3),:));
                end
                %Apply to trial vector the crossover to produce a child
                n = floor(rand()*problemSize+1);

                if strcmp(crossover,'bin')
                    %Binomial crossover
                    for k = 1:problemSize
                        randX = rand();
                        if randX <= CR || k == n
                            S(k) = V(k);
                        else
                             S(k) = X(s,j,k);
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
            X(s,:,:) = NG;
            XF(s,:) = NGF;
            
            % Obtain cooperation values for species
            if strcmp(selectionType,'random')
                minIndexes = selectRandom(X(s,:,:),1);
                speciesMin(s) = XF(s,minIndexes);
            elseif strcmp(selectionType,'trial')
                minIndexes = selectRandom(X(s,:,:),2);
                speciesMin(s) = max(XF(s,minIndexes));
            end
            
            if speciesMin(s) < bestSpecies(s)
                bestSpecies(s) = speciesMin(s);
            end
        end
        
        % Select the lowest fitness value
        minFit(i) = min(speciesMin);
        avgFit(i) = mean(speciesMin);
        stdFit(i) = std(speciesMin);
        
        if (globalMin(i-1) <= minFit(i))
            globalMin(i) = globalMin(i-1);
            cantNoChange = cantNoChange + 1;
        else
            globalMin(i) = minFit(i);
            cantNoChange = 0;
        end
        
        if (i > maxIterations || cantNoChange >= maxIterationsNoChange || evalCant >= maxEvaluations)
            % plot the picture of iteration
            figure(2);
            plot(1:i-1,minFit(2:i),1:i-1,avgFit(2:i),1:i-1,stdFit(2:i));
            legend({'Best', 'Average', 'Standard Deviation'});
            xlabel('Iteration');
            ylabel('Fitness');
            title(sprintf('Iteration=%d, Fitness=%9.9f',i-1,minFit(i)));
            grid on;
            hold on;
        end
        i = i + 1;
    end
    
    details = transpose(vertcat(0:length(minFit)-1,minFit,avgFit,stdFit,globalMin));
    
    output = struct;
    output(1).Students = {'Jorge Andrés González Borboa','Oscar Daniel González Sosa','Barbara Valdez Mireles'};
    output(1).IDs = {'A01280927','A00816447','A01175920'};
    output(1).best_fitness = globalMin(end);
    output(1).best_fitness_per_fitness = bestSpecies;
    output(1).details = array2table(details,'VariableNames',{'Iteration', 'BestPerIteration', 'AvgPerIteration', 'StdPerIteration', 'BestSolution'});
    output(1).min_iterations = length(minFit) - 1 - cantNoChange;
end

