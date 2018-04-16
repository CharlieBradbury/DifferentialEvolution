function Y = selectRandom(X)
     indices = randperm(length(X));
     indices = indices(1:3);
     Y = X(indices);
end