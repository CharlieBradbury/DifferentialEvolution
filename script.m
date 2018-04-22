function script()
% prompt = 'Función objetivo introducirla como string: ';
% str = input(prompt)
% funcObj = inline(str);
% display(funcObj);

% prompt = 'Cantidad de variables: ';
% problemSize = input(prompt)
% 
% prompt = 'Peso diferencial: ';
% F = input(prompt)
% 
% prompt = 'Vector Limite Inferior: ';
% VInf = input(prompt)
% 
% prompt = 'Vector Limite Superior: ';
% VSup = input(prompt)
% 
% prompt = 'Tasa de cruza: ';
% CR = input(prompt)
% 
% prompt = 'Máximo número de evaluaciones para función objetivo: ';
% maxEvaluations = input(prompt)
% 
% prompt = 'Número máximo de iteraciones evaluación sin mejora: ';
% maxIterations = input(prompt)

funcObj = @funcionObjetivo;
problemSize = 2;
F = 0.7;
VInf = [27.5 27.5];
VSup = [100 100];
CR = 0.7;
maxEvaluations = 30;
maxIterations = 2;

populationSize = 5;
selectionType = 'random';
crossover = 'bin';

%Call the algorithm
DE(funcObj, problemSize, populationSize, problemSize, VInf, VSup, F, CR, selectionType,crossover, maxIterations, maxEvaluations)
end
