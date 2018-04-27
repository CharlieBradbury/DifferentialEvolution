function output = script()
%     prompt = 'Función objetivo (introducirla como string): ';
%     funcObj = input(prompt)
%     
%     prompt = 'Tamaño de población por individuo: ';
%     populationSize = input(prompt)
% 
%     prompt = 'Cantidad de variables del problema a minimizar: ';
%     problemSize = input(prompt)
%     
%     prompt = 'Tipo de cooperación (random o trial): ';
%     cooperationType = input(prompt)
%     
%     prompt = 'Tipo de selección (random o trial): ';
%     selectionType = input(prompt)
%  
%     prompt = 'Peso diferencial: ';
%     F = input(prompt)
%  
%     prompt = 'Vector Limite Inferior: ';
%     VInf = input(prompt)
%  
%     prompt = 'Vector Limite Superior: ';
%     VSup = input(prompt)
%     
%     prompt = 'Tasa de cruza: ';
%     CR = input(prompt)
% 
%     prompt = 'Máximo número de evaluaciones para función objetivo: ';
%     maxEvaluations = input(prompt)
%  
%     prompt = 'Número máximo de iteraciones evaluación sin mejora: ';
%     maxIterationsNoChange = input(prompt)
%     
%     prompt = 'Número máximo de iteraciones: ';
%     maxIterations = input(prompt)
% 
% output = CCEA(funcObj, populationSize, problemSize, VInf, VSup, F, CR, cooperationType, selectionType, maxIterations, maxIterationsNoChange, maxEvaluations);
funcObj = @funcionObjetivo;
output = CCEA(funcObj, 50, 10, [-150 -150 -150 -150 -150 -150 -150 -150 -150 -150], [150 150 150 150 150 150 150 150 150 150], 0.7, 0.7, 'trial', 'random', 10, 3, 5000);
end
