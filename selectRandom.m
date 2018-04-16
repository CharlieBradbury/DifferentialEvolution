function Y = selectRandom(X)
     indices = randperm(size(X,1))
     Y = indices(1:3);
end