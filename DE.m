function output = DE(funcObj, populationSize, problemSize, Inf, Sup, F, CR, maxIterationsNoChange, maxEvaluations)
    evalCant = 0;
    X = generatePopulation(populationSize, problemSize, Inf, Sup);
    XF = zeros(populationSize, 1);
    for k = 1 : populationSize
        XF(k) = funcObj(X(k,:));
        evalCant = evalCant + 1;
    end
    minFit(1) = min(XF);
    avgFit(1) = mean(XF);
    stdFit(1) = std(XF);
    globalMin(1) = minFit(1);
    
    i = 2;
    
    cantNoChange = 0;
    
    %Stop when it has reach a fixed amount of evaluation of the fitness
    while evalCant < maxEvaluations && cantNoChange < maxIterationsNoChange
        %for each individual in the population
        for j= 1:populationSize
            %Trial or random selection of individuals
            %agarrar tres index random de la matriz
            newSpecies = selectRandom(X,3);
            
            %Apply directional mutation  
            V = X(newSpecies(1),:) + F * (X(newSpecies(2),:) - X(newSpecies(3)));
            for k = 1 : problemSize
                if V(k) > Sup(k)
                    V(k) = Sup(k);
                elseif V(k) < Inf(k)
                    V(k) = Inf(k);
                end
            end 
           
            %Apply to trial vector the crossover to produce a child
            n = floor(rand()*problemSize+1);

            %Binomial crossover
            for k = 1:problemSize
                randX = rand();
                if randX <= CR || k == n
                    S(k) = V(k);
                else
                     S(k) = X(j,k);
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
            evalCant = evalCant + 1;
        end
		X = NG;
        XF = NGF;
        
        minFit(i) = min(XF);
        avgFit(i) = mean(XF);
        stdFit(i) = std(XF);
        
        if (globalMin(i-1) <= minFit(i))
            globalMin(i) = globalMin(i-1);
            cantNoChange = cantNoChange + 1;
        else
            globalMin(i) = minFit(i);
            cantNoChange = 0;
        end
        
        i = i + 1;
    end
    
    details = transpose(vertcat(0:length(minFit)-1,minFit,avgFit,stdFit,globalMin));
    
    [BestFitness, index] = min(XF);
    BestSolution = X(index,:);

    output = struct('Names',{'Bárbara Berenice Valdez Mireles','Oscar Daniel González Sosa','Jorge Andrés González Borboa'},...
        'IDs',{'A01175920','A00816447', 'A01280927'},...
        'Best_Fitness_Iter',transpose(minFit),...
        'Best_Mean_Iter',transpose(avgFit),...
        'BestSolution',BestSolution,...
        'BestFitness',BestFitness,...
        'details',array2table(details,'VariableNames',{'Iteration', 'BestPerIteration', 'AvgPerIteration', 'StdPerIteration', 'BestSolution'}));
end