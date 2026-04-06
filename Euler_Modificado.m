clc;
clear;

% Ingreso de valores iniciales

funcion = input('Ingrese la funcion f(x,y): ','s');
f = str2func(['@(x,y) ' funcion]);
x0 = input('Ingrese x0: ');
y0 = input('Ingrese y0: ');
h = input('Ingrese el valor de h: ');
tol = input('Ingrese el error minimo permitido (ej: 0.001): ');
fprintf('\nIngrese el intervalo a resolver:\n');
fprintf ('\nx inicial: %.4f\n', x0);
xf = input('x final: ');

n = round((xf - x0)/h);

x = zeros(1,n+1);
y = zeros(1,n+1);
errors = zeros(1,n+1);

x(1) = x0;
y(1) = y0;
errors(1) = 0;

% Método de euler modificado:

for i = 2:n+1

    x(i) = x(i-1) + h;

    P = y(i-1) + h * f(x(i-1), y(i-1));

    C = y(i-1) + (h/2) * ( f(x(i-1), y(i-1)) + f(x(i), P) );

    while abs(C - P) >= tol
        P = C;
        C = y(i-1) + (h/2) * ( f(x(i-1), y(i-1)) + f(x(i), P) );
    endwhile

    errors(i) = abs(C-P);
    y(i) = C;
end

fprintf('\n\nValores de la función obtenidos con el método de Euler Modificado:\n');
fprintf('\n   x        y           error\n');
fprintf('--------------------------------\n');

for i = 1:n+1
    fprintf('%.4f   %.8f  %.8f\n', x(i), y(i), errors(i));
end
