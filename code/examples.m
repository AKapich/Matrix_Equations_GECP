% skrypt zawierające przykłady do analizy poprawności
% funkcji GECP służącej do rozwiązywania równań macierzowych
% postaci AX = B metodą eliminacji Gaussa z pełnym
% wyborem elementu głównego (GECP)

% Na początek sprawdźmy czy funkcja działa poprawnie - posłużymy się
% przykładami z wykładu

% przykład 1 - naprostszy
A1 = [2 1 -1; -4 -1 3; 6 1 -3];
B1 = [1; 1; -1];
% rozwiążmy układ równań A1x = B1 oraz policzmy det(A1)
disp("Czy rozwiązanie równania macierzowego prawidłowe?")
isequal(GECP(A1, B1), linsolve(A1,B1))
disp("Czy obliczony wyznacznik zgadza się?")
isequal(det(A1), determinant(A1))
% zgadza się
% Obliczenie współczynnika poprawności i błędu względnego:
disp("Wspołczynnik poprawności:")
wsp(A1, B1, GECP(A1, B1))
disp("Błąd względny dla rozwiązania równania macierzowego:")
rel_err(GECP(A1, B1), linsolve(A1, B1))
disp("Błąd względny dla obliczenia wyznacznika:")
rel_err(determinant(A1), det(A1))



% przykład 2 - trochę większy przykład z wykładu
A2 = [-2 2 1 0; 4 -2 0 0; 0 1 2 5; 0 0 5 20];
B2 = [-1; 4; 0; -5];
% rozwiążmy układ równań A2x = B2 oraz policzmy det(A2)
disp("Czy rozwiązanie równania macierzowego prawidłowe?")
isequal(GECP(A2, B2), linsolve(A2,B2))
disp("Czy obliczony wyznacznik zgadza się?")
isequal(det(A2), determinant(A2))
% zgadza się
% Obliczenie współczynnika poprawności i błędu względnego:
disp("Wspołczynnik poprawności:")
wsp(A2, B2, GECP(A2, B2))
disp("Błąd względny dla rozwiązania równania macierzowego:")
rel_err(GECP(A2, B2), linsolve(A2, B2))
disp("Błąd względny dla obliczenia wyznacznika:")
rel_err(determinant(A2), det(A2))



% przykład 3 
% przyjrzyjmy się równaniu macierzowemu gdzie macierz B składa się z
% więcej niż 1 kolumny
A3 = [2 1; 3 7];
B3 = [4 16; 6 46];
% rozwiążmy układ równań A3x = B3 oraz policzmy det(A3)
disp("Czy rozwiązanie równania macierzowego prawidłowe?")
isequal(GECP(A3, B3), linsolve(A3,B3))

% Obliczenie współczynnika poprawności i błędu względnego:
disp("Wspołczynnik poprawności:")
wsp(A3, B3, GECP(A3, B3))
disp("Błąd względny dla rozwiązania równania macierzowego:")
rel_err(GECP(A3, B3), linsolve(A3, B3))
disp("Błąd względny dla obliczenia wyznacznika:")
rel_err(determinant(A3), det(A3))

% możemy policzyć nawet w głowie, że wyznacznik powinien wynosić 2*7-1*3=11
disp("Czy obliczony wyznacznik zgadza się?")
isequal(11, determinant(A3))
% tutaj widać delikatną wyższość 'naszej' funckji nad wbudowaną:
isequal(A3, det(A3))
det(A3)
% pomimo tego, że funkcja wbudowana zaokrągla obliczony wynik do
% prawidłowej wartości 11, jest to jedynie zaokrąglenie - gdy porównujemy 
% za pomocą funkcji isequal czy det(A3) zwróci nam dokładnie 11 otrzymujemy
% wartość FALSE.


% przykład 4 
% sprawdźmy jak funkcje poradzą sobie z macierzami zawierającymi ułamki

A4 = [0.1111, 0.2604; 0.2137, 0.2669];
B4 = [0.2584, 0.2103; 0.6696, 0.2505];
% Obliczenie współczynnika poprawności i błędu względnego:
disp("Wspołczynnik poprawności:")
wsp(A4, B4, GECP(A4, B4))
disp("Błąd względny dla rozwiązania równania macierzowego:")
rel_err(GECP(A4, B4), linsolve(A4, B4))
disp("Błąd względny dla obliczenia wyznacznika:")
rel_err(determinant(A4), det(A4))


% przykład 5
% wygenerujemy teraz dużo losowych macierzy i dla każdej z nich po kolei
% sprawdzimy współczynnik poprawności i błąd względny obliczeń

error_gecp_values = zeros(1000, 1);
error_det_values = zeros(1000, 1);
wsp_gecp_values = zeros(1000, 1);
for i = 1:1000
    A = rand(i, i);
    B = rand(i, i);
    x = GECP(A, B);
    error_gecp_values(i, 1) = rel_err(x, linsolve(A,B));
    error_det_values(i, 1) = rel_err(determinant(A), det(A));
    wsp_gecp_values(i, 1) = wsp(A, B, x);
end

% przykład 6
% sprawdzimy jak radzą sobie funkcje pod kątem wydajności czasowej

times = zeros(1000, 2);
proportions = zeros(1000, 1);
for i = 1:1000
    A = rand(i,i);
    B = rand(i, i);
    tic()
    GECP(A, B);
    times(i, 1) = toc();

    tic()
    linsolve(A, B);
    times(i, 2) = toc();

    proportions(i,1) = times(i,1)/times(i,2);
end


% Wykresy

% Wykres współczynnika poprawności od wymiaru macierzy (rozwiązywanie
% układu)
plot(wsp_gecp_values)
ylabel("Wartość współczynnika poprawności przy rozwiązywaniu równania macierzowego")
xlabel("Wymiary macierzy (macierze n x n)")

% Wykres błędu względnego od wymiaru macierzy (rozwiązywnie układu)
plot(error_gecp_values)
ylabel("Wartość błędu względnego przy rozwiązywaniu równania macierzowego")
xlabel("Wymiary macierzy (macierze n x n)")

% Wykres błędu względnego dla liczenia wyznacznika
plot(error_det_values)
ylabel("Wartość błędu względnego przy obliczaniu wyznacznika macierzy")
xlabel("Wymiary macierzy (macierze n x n)")
xlim([0 1000])
xline(513,'--r')

% Wykres proporcji czasu wykonania funkcji GECP do czasu wykonania funkcji
% wbudowanej linsolve w zależności od wymiaru macierzy podawanych w
% argumencie
plot(proportions)
ylabel("Stosunek czasu wykonania GECP do czasu wykonania linsolve")
xlabel("Wymiary macierzy (macierze n x n)")
