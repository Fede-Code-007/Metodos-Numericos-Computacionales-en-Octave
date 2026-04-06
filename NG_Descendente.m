clc;
clear;

n = input('Ingrese la cantidad de puntos: ');

while n <= 1 || mod(n,1) ~= 0
    disp('La cantidad de puntos debe ser un entero mayor a 1.');
    n = input('Ingrese la cantidad de puntos: ');
end

x0 = input('Ingrese x inicial: ');

h = input('Ingrese la distancia entre los puntos: ');

while h <= 0
    disp('La distancia entre puntos debe ser positiva.');
    h = input('Ingrese la distancia entre los puntos: ');
end

x = zeros(1,n);
y = zeros(n,n);

for i = 1:n
    x(i) = x0 + (i-1)*h;
end

disp('Ingrese los valores de y');
for i = 1:n
    y(i,1) = input(['y(', num2str(x(i),'%.2f'), ') = ']);
end

% Calculo de diferencias regresivas
for j = 2:n
    for i = n:-1:j
        y(i,j) = y(i,j-1) - y(i-1,j-1);
    end
end

% Mostramos tabla de diferencias regresivas
disp('Tabla de diferencias regresivas');

fprintf('%8s', 'x');
fprintf('%12s', 'y');
for j = 2:n
    fprintf('%12s', ['Delta^', num2str(j-1),'y',]);
end
fprintf('\n');

for i = 1:n
    fprintf('%8.2f', x(i));

    for j = 1:n
        if j <= i
            fprintf('%12.8f', y(i,j));
        else
            fprintf('%12s', ' ');
        end
    end

    fprintf('\n');
end

% Ingreso de valor a interpolar

xp = input('Ingrese el valor a interpolar: ');

while xp < x(1) || xp > x(n)
    disp(['Valor fuera del rango.']);
    xp = input('Ingrese el valor a interpolar: ');
end

% Ng Descendente

u = (xp - x(n)) / h;

yp = y(n,1);
fact = 1;
u_product = 1;

for k = 1:n-1
    u_product = u_product * (u + (k-1));
    fact = fact * k;

    yp = yp + ((y(n,k+1))/fact) * u_product;
end

fprintf('El valor interpolado es: %.8f\n', yp);
