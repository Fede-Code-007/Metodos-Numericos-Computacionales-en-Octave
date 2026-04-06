clc;
clear;

% Ingreso de valores iniciales

n = input('Ingrese la cantidad de puntos: ');

if mod (n-1, 2) ~= 0
  fprintf("No es posible aplicar el método porque la cantidad de intervalos es impar.");
  return
endif

x0 = input('Ingrese x inicial: ');

h = input('Ingrese la distancia entre los puntos: ');

while h <= 0
    disp('La distancia debe ser positiva.');
    h = input('Ingrese la distancia entre los puntos: ');
end

x = zeros(1,n);
y = zeros(1,n);

for i = 1:n
    x(i) = x0 + (i-1)*h;
end

disp('Ingrese los valores de y');

for i = 1:n
    y(i) = input(['y(', num2str(x(i)), ') = ']);
end

% Método de simpson 1/3:

E = y(1) + y(n);
P = 0;
I = 0;

for i = 2:n-1
    if mod(i,2) == 0
        P = P + y(i);
    else
        I = I + y(i);
    end
end

A = (h/3)*(E + 2*P + 4*I);

fprintf('El valor aproximado de la integral es: %.8f\n', A);
