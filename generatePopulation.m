function X = generatePopulation(PopulationSize, ProblemSize,Inf,Sup)
    %Por random 
    for i = 1:PopulationSize
        for j = 1:ProblemSize
            X(i,j) = Inf(j) + rand()*(Sup(j) - Inf(j));
        end
    end
end