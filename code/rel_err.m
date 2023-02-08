function [err] = rel_err(x, z)
% funkcja oblicza błąd względny, gdzie z to dokładne rozwiązanie, a x to
% rozwiązanie otrzymane z pomocą numerycznego przybliżenia
err = norm(x-z, 1)/norm(z);