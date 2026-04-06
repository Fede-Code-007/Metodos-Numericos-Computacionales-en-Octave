clc;
clear;
close all;

%% Ingresamos función y calculamos derivadas.

funcion = input('Ingrese la funcion en x (ej: x.^3 - x - 2): ','s');
f = str2func(['@(x) ' funcion]);
df = @(x) (f(x+1e-6) - f(x-1e-6))/(2e-6);
d2f = @(x) (f(x+1e-6) - 2*f(x) + f(x-1e-6))/(1e-6)^2;

%% Seleccionamos el intervalo donde analizaremos la función.

xmin = input('Ingrese el limite inferior: ');
xmax = input('Ingrese el limite superior: ');

while xmin >= xmax
    fprintf('\nEl limite inferior debe ser menor que el superior.\n');
    xmin = input('Ingrese el limite inferior: ');
    xmax = input('Ingrese el limite superior: ');
end

paso = input('Ingrese el paso para el tanteo: ');

while paso <= 0 || paso > (xmax - xmin)
    fprintf('\nEl paso debe ser positivo y menor que la diferencia xmax-xmin.\n');
    paso = input('Ingrese el paso para el tanteo: ');
end

%% Mostramos la gráfica de la función en el intervalo seleccionado.

fprintf("\nMostrando grafica de la funcion...\n");

xgraf = linspace(xmin, xmax, 500);
ygraf = f(xgraf);

figure
plot(xgraf, ygraf, 'b', 'LineWidth', 2)
hold on
yline(0,'k--')
grid on
title("Grafica de la funcion")
xlabel("x")
ylabel("f(x)")

pause(1)


%% Aplicamos el método de tanteos en el intervalo seleccionado para hallar todos los posibles subintervalos donde puede haber una raiz.

x = xmin:paso:xmax;
fx = f(x);
tabla = [x(:) fx(:)];

fprintf("\nAplicando método de tanteos...\n");
fprintf("\nTabla de valores\n");
fprintf("      x              f(x)\n");

for i = 1:size(tabla,1)

    fprintf("%12.8f   %12.8f\n", tabla(i,1), tabla(i,2));

end

fprintf("\nIntervalos donde puede haber una raiz:\n");

contador = 0;
intervalos = [];
raices_directas = [];

for i = 1:length(x)-1

    if tabla(i,2) == 0
        raices_directas = [raices_directas; tabla(i,1)];
    endif

    if tabla(i,2)*tabla(i+1,2) < 0

        contador = contador + 1;

        a = tabla(i,1);
        b = tabla(i+1,1);

        intervalos = [intervalos; a b];

        fprintf("%d) (%.6f ; %.6f)\n", contador, a, b);

    endif

end

if contador == 0
    fprintf("\nNo se encontraron intervalos donde se verifique que f(a)*f(b) < 0.\n");

    if ~isempty(raices_directas)
        fprintf("\nRaices encontradas directamente con método de tanteos:\n");
        for i = 1:length(raices_directas)
            fprintf("x = %.8f\n", raices_directas(i));
        end
    endif

    return
elseif ~isempty(raices_directas)
        fprintf("\nRaices encontradas directamente con método de tanteos:\n");
        for i = 1:length(raices_directas)
            fprintf("x = %.8f\n", raices_directas(i));
        end
endif


%% Seleccionamos uno de los subintervalos donde puede haber una raiz.

opcion = input('Seleccione el intervalo que desea usar: ');

while opcion < 1 || opcion > size(intervalos,1)
    fprintf('\nOpcion invalida. Ingrese un numero correspondiente a la lista de intervalos.\n');
    opcion = input('Seleccione el intervalo que desea usar: ');
end

%% Solicitamos error minimo tolerado y número maximo de repeticiones del método.

tol = input('Ingrese el error minimo permitido (ej: 0.001): ');

while tol <= 0
    fprintf('\nLa tolerancia debe ser positiva.\n');
    tol = input('Ingrese el error minimo permitido (ej: 0.001): ');
end

maxIter = input('Ingrese el numero maximo de iteraciones: ');

while maxIter <= 0 || mod(maxIter,1) ~= 0
    fprintf('\nEl numero maximo de iteraciones debe ser un entero positivo.\n');
    maxIter = input('Ingrese el numero maximo de iteraciones: ');
end


%% METODO NEWTON RAPHSON

a = intervalos(opcion,1);
b = intervalos(opcion,2);

%% Verificamos condición de convergencia:

condiciones_newton = true;

x_vals = linspace(a, b, 100);

df_vals = df(x_vals);

if (f(a)*f(b) >= 0)
    condiciones_newton = false;
    fprintf("\nNo fue posible usar el método de Newton porque no se cumple f(a)*f(b)<0 en el intervalo elegido.\n");
elseif (any(abs(df_vals) < 1e-8))
    condiciones_newton = false;
    fprintf("\nNo fue posible usar el método de Newton porque no se cumple f'(x)> 0 para todo x en el intervalo elegido.\n");
elseif (f(a) * d2f(a) > 0)
    x0 = a;
elseif (f(b) * d2f(b) > 0)
    x0 = b;
else
    condiciones_newton = false;
    fprintf("\nNo fue posible usar el método de Newton porque no se encontro f(x0)*d2f(x0)>0 en el intervalo elegido.\n");
endif

%% Si se cumplen condicion de convergencia ejecutamos el método:
if (condiciones_newton)

  fprintf("\nMetodo Newton-Raphson\n");

  fprintf("Valor inicial x0 = %.6f\n", x0);

  fprintf("Iter        xn           f(xn)         Error\n");

  for i = 1:maxIter

      x1 = x0 - f(x0)/df(x0);

      error = abs(x1 - x0);

      fprintf("%2d   %12.8f   %12.8f   %12.8f\n", i, x1, f(x1), error);

      if error < tol
          break
      endif

      x0 = x1;

  end

  fprintf("\nRaiz aproximada (Newton-Raphson) = %.8f\n", x1);
endif
