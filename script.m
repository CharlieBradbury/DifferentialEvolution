function output = script()
    prompt = 'Funci贸n objetivo (introducirla como string): ';
    funcObj = input(prompt)
    %funcObj = inline(str);
    display(funcObj);
    
    prompt = 'Cantidad de especies a manejar: ';
    numSpecies = input(prompt)
    
    prompt = 'Tama駉 de poblacion por individuo: ';
    populationSize = input(prompt)

    prompt = 'Cantidad de variables por individuo: ';
    problemSize = input(prompt)
    
    prompt = 'Tipo de cooperaci贸n (random o trial): ';
    cooperationType = input(prompt)
    
    prompt = 'Tipo de selecci贸n (random o trial): ';
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

    prompt = 'M谩ximo n煤mero de evaluaciones para funci贸n objetivo: ';
    maxEvaluations = input(prompt)
 
    prompt = 'N煤mero m谩ximo de iteraciones evaluaci贸n sin mejora: ';
    maxIterationsNoChange = input(prompt)
    
    prompt = 'N煤mero m谩ximo de iteraciones: ';
    maxIterations = input(prompt)

%Call the algorithm
output = CCEA(funcObj, numSpecies, populationSize, problemSize, VInf, VSup, F, CR, cooperationType, selectionType,crossover, maxIterations, maxIterationsNoChange, maxEvaluations);
end
