function output = script()
%     prompt = 'Funci�n objetivo (introducirla como string): ';
%     funcObj = input(prompt)
%     
%     prompt = 'Tama�o de poblaci�n por individuo: ';
%     populationSize = input(prompt)
% 
%     prompt = 'Cantidad de variables del problema a minimizar: ';
%     problemSize = input(prompt)
%     
%     prompt = 'Tipo de cooperaci�n (random o trial): ';
%     cooperationType = input(prompt)
%     
%     prompt = 'Tipo de selecci�n (random o trial): ';
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
%     prompt = 'M�ximo n�mero de evaluaciones para funci�n objetivo: ';
%     maxEvaluations = input(prompt)
%  
%     prompt = 'N�mero m�ximo de iteraciones evaluaci�n sin mejora: ';
%     maxIterationsNoChange = input(prompt)
%     
%     prompt = 'N�mero m�ximo de iteraciones: ';
%     maxIterations = input(prompt)
% 
% output = CCEA(funcObj, populationSize, problemSize, VInf, VSup, F, CR, cooperationType, selectionType, maxIterations, maxIterationsNoChange, maxEvaluations);
funcObj = @funcionObjetivo;
output = CCEA(funcObj, 50, 10, [-150 -150 -150 -150 -150 -150 -150 -150 -150 -150], [150 150 150 150 150 150 150 150 150 150], 0.7, 0.7, 'trial', 'random', 10, 3, 5000);
end
