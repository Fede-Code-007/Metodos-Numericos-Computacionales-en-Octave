clc;
clear;

% Ingreso de valores iniciales:

funcion = input('Ingrese la funcion diferencial f(x,y): ','s');

f = str2func(['@(x,y) ' funcion]);

fprintf('\nIngrese el intervalo a resolver:\n');
x0 = input('x inicial: ');
xf = input('x final: ');
h = input('Ingrese el valor de h: ');

x = x0:h:xf;
n = length(x);

if n < 4
    error('Se necesitan al menos 4 puntos para aplicar Milne');
    return
end

y = zeros(1,n);

fprintf('\nIngrese los primeros 4 valores de y:\n');
for i = 1:4
    y(i) = input(sprintf('f(%.2f): ', x(i)));
end

% Método de Milne:

for i = 5:n
    P = y(i-4)+(4/3)*h*(2*f(x(i-1),y(i-1))-f(x(i-2),y(i-2))+2*f(x(i-3),y(i-3)));
    C = y(i-2)+(h/3)*(f(x(i-2),y(i-2))+4*f(x(i-1),y(i-1))+f(x(i),P));
    y(i) = C;
end

fprintf('\n\nValores de la función obtenidos con el método de Milne:\n');
fprintf('\n   x        y\n');
fprintf('-------------------\n');

for i = 1:n
    fprintf('%.4f   %.6f\n', x(i), y(i));
end
