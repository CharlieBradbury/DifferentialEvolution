% output = DE(funcObj, populationSize, problemSize, Inf, Sup, F, CR, cooperationType, selectionType, maxIterations, maxIterationsNoChange, maxEvaluations)
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
function output = CCEA(funcObj, populationSize, problemSize, Inf, Sup, F, CR, cooperationType, selectionType, maxIterations, maxIterationsNoChange, maxEvaluations)
    evalCant = 0;
    %Initialize each species
    for s = 1 : problemSize
        X(s,:) = generatePopulation(populationSize, 1, Inf(s), Sup(s));
        XF(s,:) = zeros(populationSize, 1);
    end
    %Evaluate members of each species using random cooperation
    for s = 1 : problemSize
        for k = 1 : populationSize
            coop = zeros(problemSize, 1);
            for c = 1 : problemSize
                if c == s
                    coop(c) = X(s,k);
                else
                    coopIndex = selectRandom(X(c,:),1);
                    coop(c) = X(c,coopIndex);
                end
            end
            evalCant = evalCant + 1;
            XF(s,k) = funcObj(transpose(coop));
        end
        [bestIterSpecies(s,1), index] = min(XF(s,:)); 
        bestIterSpecies(s,2) = X(s,index);
        bestPerSpecies(s) = bestIterSpecies(s,1);
    end
    
    % Select the lowest fitness value
    minFit(1) = funcObj(transpose(bestIterSpecies(:,2)));
    evalCant = evalCant + 1;
    avgFit(1) = mean2(XF);
    stdFit(1) = std2(XF);
    % Obtain best solution from cooperation values
    globalMin(1) = minFit(1);
    cantNoChange = 0;
    i = 2;
    
    %Stop when it has reach a fixed amount of evaluation of the fitness
    while i - 1 <= maxIterations && evalCant < maxEvaluations && cantNoChange < maxIterationsNoChange
        %For each species
        for s = 1 : problemSize
            %for each individual in the population
            for j = 1 : populationSize
                %Trial or random selection of individuals
                %agarrar tres index random de la matriz
                newSpecies = selectRandom(X(s,:),3);

                %Apply directional mutation 
                if strcmp(selectionType,'random')
                    V = X(s,newSpecies(1)) + F * (X(s,newSpecies(2)) - X(s,newSpecies(3)));
                elseif strcmp(selectionType,'trial')
                    %select the best newSpecies
                    [~,bestIndex] = min(XF(s,newSpecies));
                    V = X(s,newSpecies(bestIndex)) + F * (X(s,newSpecies(2)) - X(s,newSpecies(3)));
                end
                
                if V > Sup(s)
                    V = Sup(s);
                elseif V < Inf(s)
                    V = Inf(s);
                end
                
                %Apply to trial vector the crossover to produce a child
                n = floor(rand()*problemSize+1);

                %Binomial crossover
                randX = rand();
                if randX <= CR || s == n
                    S = V;
                else
                     S = X(s,j);
                end
                
                %Evaluate fitness using cooperation
                coop = zeros(problemSize, 1);
                for c = 1 : problemSize
                    if c == s
                        coop(c) = S;
                    else
                        if strcmp(cooperationType,'random')
                            coopIndex = selectRandom(X(c,:),1);
                            coop(c) = X(c,coopIndex);
                        else
                            coopIndex = selectRandom(X(c,:),2);
                            coop(c) = min(X(c,coopIndex));
                        end
                    end
                end
                evalCant = evalCant + 1;
                coopFit = funcObj(transpose(coop));

                % if the child individual is better than the current one then
                if coopFit < XF(s,j)
                    NG(s,j) = S;
                    NGF(s,j) = coopFit;
                else
                    NG(s,j)  = X(s,j);
                    NGF(s,j) = XF(s,j);
                end
            end
            [bestIterSpecies(s,1), index] = min(NGF(s,:)); 
            bestIterSpecies(s,2) = NG(s,index);
            if bestIterSpecies(s,1) < bestPerSpecies(s)
                bestPerSpecies(s) = bestIterSpecies(s,1);
            end
        end
        disp(NG);
        disp(NGF);
        disp(bestIterSpecies(:,2));
        % Update general population
        X = NG;
        XF = NGF;
        
        % Select the lowest fitness value
        minFit(i) = funcObj(transpose(bestIterSpecies(:,2)));
        evalCant = evalCant + 1;
        avgFit(i) = mean2(XF);
        stdFit(i) = std2(XF);
        
        if (globalMin(i-1) <= minFit(i))
            globalMin(i) = globalMin(i-1);
            cantNoChange = cantNoChange + 1;
        else
            globalMin(i) = minFit(i);
            disp(bestIterSpecies(:,2));
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
    output(1).best_fitness_per_species = bestPerSpecies;
    output(1).details = array2table(details,'VariableNames',{'Iteration', 'BestPerIteration', 'AvgPerIteration', 'StdPerIteration', 'BestSolution'});
    output(1).min_iterations = length(minFit) - 1 - cantNoChange;
end

