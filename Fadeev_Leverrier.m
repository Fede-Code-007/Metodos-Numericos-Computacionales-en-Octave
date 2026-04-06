clc;
clear;

% =========================
% INGRESO DE DATOS
% =========================

n = input('Ingrese el numero de ecuaciones: ');

while n <= 0 || mod(n,1) ~= 0
    disp('El número de ecuaciones debe ser un entero positivo.');
    n = input('Ingrese el numero de ecuaciones: ');
end

A = zeros(n,n);

fprintf('\nIngrese la matriz A:\n');
for i = 1:n
    for j = 1:n
        A(i,j) = input(['A(', num2str(i), ',', num2str(j), ') = ']);
    end
end

% =========================
% METODO DE FADDEEV-LEVERIER
% =========================

I = eye(n);
B = A;
bi = zeros(1, n);


for k = 1:n
    ck = trace(B) / k;
    bi(k) = ck;
    B = A * (B - ck * I);
end

%%Calculamos los coeficientes del polinomio caracteristico:
coef_poly = ((-1)^n) *[1, -bi];

%%Mostramos por pantalla
fprintf('\nPolinomio caracteristico:\n');

if coef_poly(1) >= 0
  fprintf('λ^%d ',n);
else
  fprintf('-λ^%d ',n);
endif
for i = 2:n+1
    if coef_poly(i) >= 0
        fprintf('+ %.4f λ^%d ', coef_poly(i), (n+1)-i);
    else
        fprintf('- %.4f λ^%d ', abs(coef_poly(i)), (n+1)-i);
    end
end

%%Calculamos y mostramos los autovalores y eigevectores asociados:

fprintf('\n\nAutovalores y eigevectores asociados:\n');

autovalores = roots(coef_poly); %%Obtiene raices automaticamente.

for k = 1:length(autovalores)

    lambda = autovalores(k);

    fprintf('\nAutovalor %d: λ = %.4f\n', k, lambda);

    M = A - lambda * I;

    V = null(M); %%Resuelve matrices nulas.

    fprintf('Autovector asociado:\n');
    for i = 1:length(V)
      fprintf('x%d = %.4f\n', i, V(i));
    endfor
end
