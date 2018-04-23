function output = script()
    prompt = 'Función objetivo (introducirla como string): ';
    funcObj = input(prompt)
    %funcObj = inline(str);
    display(funcObj);
    
    prompt = 'Cantidad de especies a manejar: ';
    numSpecies = input(prompt)
    
    prompt = 'Tama�o de poblacion por individuo: ';
    populationSize = input(prompt)

    prompt = 'Cantidad de variables por individuo: ';
    problemSize = input(prompt)
    
    prompt = 'Tipo de cooperación (random o trial): ';
    cooperationType = input(prompt)
    
    prompt = 'Tipo de selección (random o trial): ';
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

    prompt = 'Máximo número de evaluaciones para función objetivo: ';
    maxEvaluations = input(prompt)
 
    prompt = 'Número máximo de iteraciones evaluación sin mejora: ';
    maxIterationsNoChange = input(prompt)
    
    prompt = 'Número máximo de iteraciones: ';
    maxIterations = input(prompt)

%Call the algorithm
output = CCEA(funcObj, numSpecies, populationSize, problemSize, VInf, VSup, F, CR, cooperationType, selectionType,crossover, maxIterations, maxIterationsNoChange, maxEvaluations);
end
