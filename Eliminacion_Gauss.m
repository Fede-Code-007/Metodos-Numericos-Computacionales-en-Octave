clc;
clear;

% Ingreso de datos de entrada;

n = input('Ingrese el numero de ecuaciones: ');

while n <= 0 || mod(n,1) ~= 0
    fprintf('\nEl número de ecuaciones debe ser un entero positivo.\n');
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

M = [A b]; % Matriz aumentada.


% METODO ELIMINACIÓN GAUSS

for i = 1:n-1

    %Buscamos un pivot distinto de 0.
    pivot = i;
    while pivot <= n && M(pivot,i) == 0
        pivot = pivot + 1;
    end

    if pivot > n
        fprintf('\nNo existe solucion unica.\n');
        return;
    end

    %En caso de que el pivot no se encuentre en la primera fila, sustituimos las ecuaciones.

    if pivot ~= i
        temp = M(i,:);
        M(i,:) = M(pivot,:);
        M(pivot,:) = temp;
    end

    %Realizamos la eliminación de Gauss convirtiendo en 0 todos los elementos de bajo del pivote.
    for j = i+1:n
        m = M(j,i) / M(i,i);
        M(j,:) = M(j,:) - m * M(i,:);
    end
end


if M(n,n) == 0 %Una ecuacion se ha anulado por completo entonces el rango de la matriz es menor a n.
    fprintf('\nNo existe solucion unica.\n');
    return;
end


% Una vez hecha la eliminación de Gauss, realizamos sustitucion inversa para hallar los valores de las incognitas:


%Inicializamos el vector de resultados:
x = zeros(n,1);

%Tomamos el valor de la ultima incognita que ya se encuentra despejada.
x(n) = M(n,n+1) / M(n,n);


%Vamos de la penultima fila a la primera multiplicando y sumando los coeficientes por el valor de las incognitas que ya conocemos.
for i = n-1:-1:1
    suma = 0;
    for j = i+1:n
        suma = suma + M(i,j)*x(j);
    end
    x(i) = (M(i,n+1) - suma) / M(i,i);
end

%Finalmente mostramos el resultado del sistema.

fprintf('\nSolucion del sistema:\n');
for i = 1:n
    fprintf('x%d = %.6f\n', i, x(i));
end
