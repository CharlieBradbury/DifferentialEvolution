function output = scriptDE()
    %Para modificar la funcion objetivo, agregarla en el archivo funcionObjetivo.m
    funcObj = @funcionObjetivo;
    %Numero de variables
    problemSize = 2;
    %Valor de peso diferencial
    F = 0.7;
    %Vector con limites inferiores por variable
    VInf = [27.5 27.5];
    %Vector con limites superiores por variable
    VSup = [100 100];
    %Tase de cruza
    CR = 0.7;
    % Criterio de paro
    maxEvaluations = 10;
    % Tamaño de poblacion
    populationSize = 5;

    %Call the algorithm
    %DE(funcObj, populationSize, problemSize, VInf, VSup, F, CR, maxIterationsNoChange, maxEvaluations);
    output = DE(funcObj, 500, 10, [-150 -150 -150 -150 -150 -150 -150 -150 -150 -150], [150 150 150 150 150 150 150 150 150 150], 0.7, 0.7, 3, 5000);
end
