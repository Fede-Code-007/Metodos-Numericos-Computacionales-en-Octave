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
b = zeros(n,1);

fprintf('\nIngrese la matriz A:\n');
for i = 1:n
    for j = 1:n
        A(i,j) = input(['A(', num2str(i), ',', num2str(j), ') = ']);
    end
end

fprintf('\nIngrese el vector b:\n');
for i = 1:n
    b(i) = input(['b(', num2str(i), ') = ']);
end

% =========================
% DESCOMPOSICIÓN MATRIZ LU
% =========================

U = A;
L = eye(n);

for i = 1:n-1

    %Aseguramos que el pivot sea distinto de 0.
    if U(i,i) == 0
        disp('No se puede realizar LU (pivote cero)');
        return;
    end

    %Volvemos 0 los elementos bajo el pivot.
    for j = i+1:n
        m = U(j,i) / U(i,i); %Bucamos el múltiplo con el cual anular las filas.

        L(j,i) = m; %Guardamos en L.

        U(j,:) = U(j,:) - m * U(i,:); %Anulamos las filas.
    end
end

% =========================
% RESOLVER Ly = b
% =========================

y = zeros(n,1);

%Como teniamos que L la posicion(1,1) valia 1, ya sabemos el valor de la primera incognita.
y(1) = b(1);

for i = 2:n %Vamos de la segunda fila a la última.
    suma = 0;
    for j = 1:i-1
        suma = suma + L(i,j)*y(j); %Sumamos el valor de las incognitas que conocemos multiplicadas por sus respectivos coeficientes.
    end
    y(i) = b(i) - suma;  %Restamos dicho valor de a b para obtener el valor de las incognitas posteriores.
end

% =========================
% RESOLVER Ux = y
% =========================

x = zeros(n,1);

x(n) = y(n)/U(n,n); %Ya sabemos de antemano el valor de la última incognita.

% Sustitución hacia atrás
for i = n-1:-1:1
    suma = 0;

    for j = i+1:n
        suma = suma + U(i,j)*x(j); %Sumamos el valor de las incognitas que ya conocemos por los coeficientes.
    end

    if U(i,i) == 0; %No se podria despejar la incognita por estar dividiendo por 0.
          disp('No se ha podido resolver el sistema con descomposición LU porque existe solucion unica o no existe solución.');
        return;
    end

    x(i) = (y(i) - suma) / U(i,i);  %Obtenemos el valor de la incognita.
end

% =========================
% RESULTADOS
% =========================

fprintf('\nMatriz L:\n');
disp(L);

fprintf('\nMatriz U:\n');
disp(U);

fprintf('\nSolucion del sistema:\n');
for i = 1:n
    fprintf('x%d = %.6f\n', i, x(i));
end
