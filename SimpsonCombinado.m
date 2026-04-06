clc;
clear;

% Ingreso de valores iniciales

n = input('Ingrese la cantidad de puntos: ');

while n < 2 || mod(n,1) ~= 0
    disp('La cantidad de puntos debe ser un entero mayor o igual a 2.');
    n = input('Ingrese la cantidad de puntos: ');
end

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

% Método de simpson:

A1 = 0;
A2 = 0;

E = 0;
P = 0;
I = 0;

if mod(n-1,2) == 0 % Cantidad de intervalos par:

  % Usamos simpson 1/3:
  E = y(1) + y(n);

  for i = 2:n-1
    if mod(i,2) == 0
        I = I + y(i);
    else
        P = P + y(i);
    end
  end

  A1 = (h/3)*(E + 2*P + 4*I);
else  % Cantidad de intervalos impar:

  if(n-1 > 3) % Cantidad de intervalos mayor a 3:

    % Usamos simpson 1/3 para calcular la primer area:
    E = y(1) + y(n-3);

    for i = 2:n-4
      if mod(i,2) == 0
          I = I + y(i);
      else
          P = P + y(i);
      end
    end

    A1 = (h/3)*(E + 2*P + 4*I);

    % Usamos simpson 3/8 para calcular la segunda area:
    A2 = (3*h/8)*(y(n)+3*y(n-1)+3*y(n-2)+y(n-3));

  elseif (n-1==3) % Cantidad de intervalos igual a 3:

    % Usamos simpson 3/8 para calcular todo el area:

    A1 = (3*h/8)*(y(n)+3*y(n-1)+3*y(n-2)+y(n-3));

  elseif (n-1 == 1) % Cantidad de intervalos igual a 1:

    % Usamos trapecio para calcular el area:
    A1 = (h/2)*(y(1)+y(2));

  endif

endif

A = A1 + A2;

fprintf('El valor aproximado de la integral es: %.8f\n', A);
