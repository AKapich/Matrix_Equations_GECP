function [X] = GECP(A, B)
% funkcja rozwiązująca równanie macierzowe AX = B metodą eliminacji
% Gaussa z pełnym wyborem elementu głównego (GECP)

% upewnić się że macierz A jest nxn
if size(A, 1) ~= size(A, 2)
    warning("Macierz A nie jest kwadratowa!")
end

if size(A, 2) ~= size(B, 1)
    warning("Macierze A i B mają niepasujące wymiary!")
end


X = zeros(size(A, 1), size(B, 2)); % macierz wynikowa ma tyle wierszy 
% ile macierz A oraz tyle kolumn ile macierz B

p = 1:size(A, 2); % wektor zapamiętujący kolejność niewiadomych
%%alterations = 0; % ile razy zamiana wierszy lub kolumn


joint_matrix = [A B]; % macierz A|b
% przeprowadzamy eliminację Gaussa
for k = 1:(size(A, 2)-1)
    % każdy krok należy poprzedzić wyborem elementu głównego
    [max_row, max_col] = findMaxSubmatrix(joint_matrix(1:size(A,1),1:size(A,2)), k);
    if (max_row ~= k)
        %%alterations = alterations + 1;
        joint_matrix([k max_row],:) = joint_matrix([max_row k],:);
    end
    if (max_col ~= k)
        %%alterations = alterations + 1;
        joint_matrix(:,[k max_col]) = joint_matrix(:,[max_col k]);
        p(:,[k max_col]) = p(:,[max_col k]);
    end

    % zerujemy elementy pod elementem a_kk
    for i = k+1:size(joint_matrix,1)
        l = joint_matrix(i, k)/joint_matrix(k,k);
            joint_matrix(i,:) = joint_matrix(i,:)-l*joint_matrix(k,:);
    end
end

   
% obliczenie X
for m = 1:size(B,2)
    n = size(joint_matrix, 1);
    % mamy obecnie macierz trójkątną z kolumną wyrazów wolnych A|b
    % od razu możemy obliczyć ostatni x, x_n
    X(n, m) = joint_matrix(n, n+m)/joint_matrix(n,n);
    % obliczamy kolejno x_k
    for k = n-1:-1:1
        sum = 0;
        for j = k+1:n
            sum = sum + joint_matrix(k, j)*X(j, m);
        end
        X(k, m) = (joint_matrix(k, n+m) - sum)/joint_matrix(k,k);
    end

    % właściwa kolejność
    X(p',m)=X(1:size(X,1), m);
end
