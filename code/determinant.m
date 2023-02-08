function [det] = determinant(A)
% funkcja obliczająca wyznacznik macierzy A z użyciem metody eliminacji
% Gaussa z pełnym wyborem elementu głównego (GECP)

% upewnić się że macierz A jest nxn
if size(A, 1) ~= size(A, 2)
    warning("Macierz A nie jest kwadratowa!")
end

alterations = 0; % ile razy zamiana wierszy lub kolumn

for k = 1:(size(A, 2)-1)
    % każdy krok należy poprzedzić wyborem elementu głównego
    [max_row, max_col] = findMaxSubmatrix(A(1:size(A,1),1:size(A,2)), k);
    if (max_row ~= k)
        alterations = alterations + 1;
        A([k max_row],:) = A([max_row k],:);
    end
    if (max_col ~= k)
        alterations = alterations + 1;
        A(:,[k max_col]) = A(:,[max_col k]);
    end

    % zerujemy elementy pod elementem a_kk
    for i = k+1:size(A,1)
        l = A(i, k)/A(k,k);
        A(i,:) = A(i,:)-l*A(k,:);
    end
end

% Policzenie wyznacznika
det = (-1)^alterations;
for k = 1:size(A,1)
    det = det*A(k,k);
end
