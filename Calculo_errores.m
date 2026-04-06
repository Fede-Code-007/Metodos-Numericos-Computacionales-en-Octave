
fprintf('Cálculo de errores\n\n');

% Ingreso de valores iniciales

p_real = input('Ingrese el resultado real: ');

p_calculado = input('Ingrese el resultado obtenido: ');

% Calculo de errores

ea = abs(p_real - p_calculado);
er = ea / abs (p_real);
ep = er * 100;

fprintf('\nError absoluto: %.8f\n', ea);

fprintf('Error relativo: %.8f\n', er);

fprintf('Error porcentual: %.8f porciento.\n\n', ep);


