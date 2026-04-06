clc;
clear;

% Ingreso de valores iniciales

n = input('Ingrese la cantidad de puntos: ');

if mod (n-1, 3) ~= 0
  fprintf("No es posible aplicar el método porque la cantidad de intervalos no es múltiplo de 3.");
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

% Método de simpson 3/8:

E = y(1)+y(n);
M = 0;
P = 0;
A = 0;

for i = 2:n-1
    if mod(i-1, 3) == 0
        P = P + y(i);
    else
        M = M + y(i);
    end
end

A = (3*h/8)*(E + 3*M + 2*P);

fprintf('El valor aproximado de la integral es: %.8f\n', A);
