clc;
clear;

% Ingreso de valores iniciales

funcion = input('Ingrese la funcion f(x,y): ','s');
f = str2func(['@(x,y) ' funcion]);
x0 = input('Ingrese x0: ');
y0 = input('Ingrese y0: ');
h = input('Ingrese el valor de h: ');
fprintf('\nIngrese el intervalo a resolver:\n');
fprintf ('\nx inicial: %.4f\n', x0);
xf = input('x final: ');

n = round((xf - x0)/h);

x = zeros(1,n+1);
y = zeros(1,n+1);

x(1) = x0;
y(1) = y0;

% Método de kutta segundo orden:

for i = 2:n+1
    x(i) = x(i-1)+h;
    k1 = h*f(x(i-1),y(i-1));
    k2 = h*f(x(i-1)+h,y(i-1)+k1);
    y(i) = y(i-1)+(k1+k2)/2;
end

fprintf('\n\nValores de la función obtenidos con el método de Kutta de Segundo Orden:\n');
fprintf('\n   x        y\n');
fprintf('-------------------\n');

for i = 1:n+1
    fprintf('%.4f   %.6f\n', x(i), y(i));
end
