function Y = selectRandom(X, numIndex)
     disp(X)
     indices = randperm(size(X,2))
     Y = indices(1:numIndex);
end