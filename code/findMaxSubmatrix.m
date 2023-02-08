function [max_row, max_col] = findMaxSubmatrix(matrix, k)
% funkcja zwraca element maksymalny w podmacierzy A(k:n, k:n) 
% macierzy A (o wymiarach n x n) oraz indeksy wiersza i kolumny w
% których znajduje się element maksymalny

if size(matrix, 1) ~= size(matrix, 2)
    warning("Macierz A nie jest kwadratowa!")
end

max = abs(matrix(k,k));
max_row = k;
max_col = k;

for i = k:size(matrix, 1) % liczba wierszy
    for j = 1:size(matrix, 2) % liczba kolumn
        if abs(matrix(i,j)) > max
            max = matrix(i,j);
            max_row = i;
            max_col = j;
        end
    end
end
