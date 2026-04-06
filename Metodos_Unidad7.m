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
euler = zeros(1,n+1);
euler_modificado = zeros(1,n+1);
kutta_segundo_orden = zeros(1,n+1);
kutta_cuarto_orden = zeros(1,n+1);
milne = zeros(1,n+1);

x(1) = x0;
euler(1) = y0;
euler_modificado(1) = y0;
kutta_segundo_orden(1) = y0;
kutta_cuarto_orden(1) = y0;

% Método de euler:

for i = 2:n+1
    x(i) = x(i-1)+h;
    euler(i) = euler(i-1)+f(x(i-1),euler(i-1))*h;
end

% Método de euler modificado:

 tol = 0.001;
 max_iter = 1000;

for i = 2:n+1

    x(i) = x(i-1) + h;

    P = euler_modificado(i-1) + h * f(x(i-1), euler_modificado(i-1));

    C = euler_modificado(i-1) + (h/2) * ( f(x(i-1), euler_modificado(i-1)) + f(x(i), P) );

    j = 0;

    while (abs(C - P) >= tol && j < max_iter)
        P = C;
        C = euler_modificado(i-1) + (h/2) * ( f(x(i-1), euler_modificado(i-1)) + f(x(i), P));
        j = j + 1;
    endwhile

    euler_modificado(i) = C;
end

% Método de kutta segundo orden:

for i = 2:n+1
    x(i) = x(i-1)+h;
    k1 = h*f(x(i-1),kutta_segundo_orden(i-1));
    k2 = h*f(x(i-1)+h,kutta_segundo_orden(i-1)+k1);
    kutta_segundo_orden(i) = kutta_segundo_orden(i-1)+(k1+k2)/2;
end

% Método de kutta cuarto orden:

for i = 2:n+1
    x(i) = x(i-1)+h;
    k1 = h*f(x(i-1),kutta_cuarto_orden(i-1));
    k2 = h*f(x(i-1)+h/2,kutta_cuarto_orden(i-1)+k1/2);
    k3 = h*f(x(i-1)+h/2,kutta_cuarto_orden(i-1)+k2/2);
    k4 = h*f(x(i-1)+h,kutta_cuarto_orden(i-1)+k3);
    kutta_cuarto_orden(i) = kutta_cuarto_orden(i-1)+(k1+2*k2+2*k3+k4)/6;
endfor

% Método de Milne:

if n > 4
  for i=1:4
    milne(i) = kutta_cuarto_orden(i);
  endfor
  for i = 5:n+1
    P = milne(i-4)+(4/3)*h*(2*f(x(i-1),milne(i-1))-f(x(i-2),milne(i-2))+2*f(x(i-3),milne(i-3)));
    C = milne(i-2)+(h/3)*(f(x(i-2),milne(i-2))+4*f(x(i-1),milne(i-1))+f(x(i),P));
    milne(i) = C;
  endfor
  fprintf('\n\nTabla comparativa de métodos:\n');
  fprintf('-------------------------------------------------------------------------------------------------\n');
  fprintf('%8s %10s %18s %10s %12s %12s\n', 'x', 'Euler', 'Euler_Modificado', 'RK2', 'RK4', 'Milne');
  fprintf('-------------------------------------------------------------------------------------------------\n');

  for i = 1:n+1
      fprintf('%8.4f %12.6f %16.6f %12.6f %12.6f %12.6f\n', x(i), euler(i), euler_modificado(i),kutta_segundo_orden(i), kutta_cuarto_orden(i), milne(i));
  end
else
  fprintf('\n\nNo fue posible aplicar Milne porque no habia puntos suficientes en el intervalo.\n');
  fprintf('\n\nTabla comparativa de métodos:\n');
  fprintf('-------------------------------------------------------------------------------------------------\n');
  fprintf('%8s %10s %18s %10s %12s \n', 'x', 'Euler', 'Euler_Modificado', 'RK2', 'RK4');
  fprintf('-------------------------------------------------------------------------------------------------\n');

  for i = 1:n+1
      fprintf('%8.4f %12.6f %16.6f %12.6f %12.6f\n', x(i), euler(i), euler_modificado(i), kutta_segundo_orden(i), kutta_cuarto_orden(i));
  end
endif





