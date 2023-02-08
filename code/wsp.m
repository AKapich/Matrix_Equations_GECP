function [w] = wsp(A, B, x)
% funkcja oblicza współczynnik poprawności
w = norm(B - mtimes(A, x), 1)/(norm(A,1)*norm(x,1));