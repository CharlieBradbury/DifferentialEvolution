function output = script()
    prompt = 'Funci�n objetivo (introducirla como string): ';
    funcObj = input(prompt)
    
    prompt = 'Cantidad de especies a manejar: ';
    numSpecies = input(prompt)
    
    prompt = 'Tama�o de poblaci�n por individuo: ';
    populationSize = input(prompt)

    prompt = 'Cantidad de variables por individuo: ';
    problemSize = input(prompt)
    
    prompt = 'Tipo de cooperaci�n (random o trial): ';
    cooperationType = input(prompt)
    
    prompt = 'Tipo de selecci�n (random o trial): ';
    selectionType = input(prompt)
    
    prompt = 'Tipo de crossover (bin or exp): ';
    crossover = input(prompt)
 
    prompt = 'Peso diferencial: ';
    F = input(prompt)
 
    prompt = 'Vector Limite Inferior: ';
    VInf = input(prompt)
 
    prompt = 'Vector Limite Superior: ';
    VSup = input(prompt)
    
    prompt = 'Tasa de cruza: ';
    CR = input(prompt)

    prompt = 'M�ximo n�mero de evaluaciones para funci�n objetivo: ';
    maxEvaluations = input(prompt)
 
    prompt = 'N�mero m�ximo de iteraciones evaluaci�n sin mejora: ';
    maxIterationsNoChange = input(prompt)
    
    prompt = 'N�mero m�ximo de iteraciones: ';
    maxIterations = input(prompt)

%Call the algorithm
output = CCEA(funcObj, numSpecies, populationSize, problemSize, VInf, VSup, F, CR, cooperationType, selectionType,crossover, maxIterations, maxIterationsNoChange, maxEvaluations);
end
