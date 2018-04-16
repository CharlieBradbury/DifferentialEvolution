function script()
prompt = 'Función objetivo introducirla como string: ';
str = input(prompt)
funcObj = inline(str);
display(funcObj);

prompt = 'Cantidad de variables: ';
problemSize = input(prompt)

prompt = 'Peso diferencial: ';
F = input(prompt)

prompt = 'Vector Limite Inferior: ';
VInf = input(prompt)

prompt = 'Vector Limite Superior: ';
VSup = input(prompt)

prompt = 'Tasa de cruza: ';
CR = input(prompt)

prompt = 'Máximo número de evaluaciones para función objetivo: ';
maxEvaluations = input(prompt)

prompt = 'Número máximo de iteraciones evaluación sin mejora: ';
maxIterations = input(prompt)

populationSize = 50;
selectionType = 'random';
crossover = 'bin';

%Call the algorithm
DE(funcObj, populationSize, problemSize, VInf, VSup, F, CR, selectionType,crossover, maxIterations, maxEvaluations)
end
