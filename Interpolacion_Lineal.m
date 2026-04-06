clc;
clear;
close all;

%% =========================
%% INGRESO DE LA FUNCION
%% =========================

funcion = input('Ingrese la funcion en x (ej: x.^3 - x - 2): ','s');
f = str2func(['@(x) ' funcion]);

%% =========================
%% INTERVALO DE ANALISIS
%% =========================

xmin = input('Ingrese el limite inferior: ');
xmax = input('Ingrese el limite superior: ');

while xmin >= xmax
    disp('El limite inferior debe ser menor que el superior.');
    xmin = input('Ingrese el limite inferior: ');
    xmax = input('Ingrese el limite superior: ');
end

paso = input('Ingrese el paso para el tanteo: ');

while paso <= 0 || paso > (xmax - xmin)
    disp('El paso debe ser positivo y menor que la diferencia xmax-xmin.');
    paso = input('Ingrese el paso para el tanteo: ');
end

x = xmin:paso:xmax;

%% =========================
%% GRAFICA DE LA FUNCION
%% =========================


disp("Mostrando grafica de la funcion...")

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

%% =========================
%% TABLA DE TANTEOS
%% =========================

disp("Aplicando método de tanteos...")
disp(" ")
disp("Tabla de valores")

tabla = [];

for i = 1:length(x)

    fx = f(x(i));
    tabla = [tabla; x(i) fx];

end

disp("      x              f(x)")

for i = 1:length(tabla)

    fprintf("%12.8f   %12.8f\n", tabla(i,1), tabla(i,2));

end

%% =========================
%% BUSQUEDA DE INTERVALOS
%% =========================

disp(" ")
disp("Intervalos donde puede haber una raiz:")

intervalos = [];
contador = 0;
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
    disp("No se encontraron intervalos donde se verifique que f(a)*f(b) < 0.")

    if ~isempty(raices_directas)
        disp(" ")
        disp("Raices encontradas directamente con método de tanteos:")
        for i = 1:length(raices_directas)
            fprintf("x = %.8f\n", raices_directas(i));
        end
    endif

    return
elseif ~isempty(raices_directas)
        disp(" ")
        disp("Raices encontradas directamente con método de tanteos:")
        for i = 1:length(raices_directas)
            fprintf("x = %.8f\n", raices_directas(i));
        end
endif

%% =========================
%% SELECCION DEL INTERVALO
%% =========================

opcion = input('Seleccione el intervalo que desea usar: ');

while opcion < 1 || opcion > size(intervalos,1)
    disp('Opcion invalida. Ingrese un numero correspondiente a la lista de intervalos.');
    opcion = input('Seleccione el intervalo que desea usar: ');
end

a = intervalos(opcion,1);
b = intervalos(opcion,2);

%% =========================
%% CONDICION DE PARADA
%% =========================

tol = input('Ingrese el error minimo permitido (ej: 0.001): ');

while tol <= 0
    disp('La tolerancia debe ser positiva.');
    tol = input('Ingrese el error minimo permitido (ej: 0.001): ');
end

maxIter = input('Ingrese el numero maximo de iteraciones: ');

while maxIter <= 0 || mod(maxIter,1) ~= 0
    disp('El numero maximo de iteraciones debe ser un entero positivo.');
    maxIter = input('Ingrese el numero maximo de iteraciones: ');
end

%% =========================
%% METODO REGULA FALSI
%% =========================

%% verificamos condiciones:
condiciones_interpolacion = true;

if (f(a)*f(b) >= 0)
    condiciones_interpolacion = false;
    fprintf("\nNo fue posible usar interpolación lineal porque no se cumple que f(a)*f(b)<0 en el intervalo elegido.\n");
endif

%% si se cumplen condiciones ejecutamos el método:
if (condiciones_interpolacion)

  disp(" ")
  disp("Metodo Regula Falsi")

  xn_old = NaN;

  fprintf("Iter        a           b           xn          f(xn)        Error\n")

  for i = 1:maxIter

      xn = (f(b) * a - f(a) * b)/(f(b)-f(a));

      if i == 1
          error = NaN;
      else
          error = abs(xn - xn_old);
      endif

      fprintf("%2d   %10.8f  %10.8f  %10.8f  %10.8f  %10.8f\n", i, a, b, xn, f(xn), error)

      if (f(xn) == 0 || error < tol)
          break
      endif

      if f(a)*f(xn) < 0
          b = xn;
      else
          a = xn;
      endif

      xn_old = xn;

  end

  fprintf("\nRaiz aproximada = %.8f\n", xn);
endif


