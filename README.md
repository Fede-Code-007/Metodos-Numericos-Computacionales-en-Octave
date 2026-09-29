# Métodos Numéricos en GNU Octave

Repositorio con implementaciones en **GNU Octave** de distintos métodos numéricos desarrollados durante los laboratorios de la asignatura **Métodos Computacionales** de la **Universidad Nacional del Nordeste (UNNE)**.

El objetivo del proyecto es implementar y aplicar algoritmos clásicos de **análisis numérico**, utilizados para la resolución de ecuaciones no lineales, sistemas de ecuaciones, interpolación, integración numérica, ecuaciones diferenciales y cálculo de autovalores.

## Contenido

### 📚 Cálculo de errores

* **Cálculo de errores** — `Calculo_errores.m`

### 🔎 Busqueda de raices

Implementaciones de métodos para encontrar raíces de funciones:

* **Bisección** — `Biseccion.m`
* **Newton-Raphson** — `Newton_Raphson.m`
* **Comparación del método de Newton-Raphson y Regula Falsi** — `Comparacion_Metodos_Raices.m`

### 🧮 Resolución de sistemas de ecuaciones

Métodos utilizados para resolver sistemas de ecuaciones lineales:

* **Eliminación de Gauss** — `Eliminacion_Gauss.m`
* **Descomposición LU** — `Descomposicion_LU.m`

### 🔢 Autovalores y polinomios característicos

* **Método de Fadeev-LeVerrier** — `Fadeev_Leverrier.m`

### 📈 Interpolación

Métodos para aproximar funciones a partir de un conjunto de datos:

* **Interpolación lineal** — `Interpolacion_Lineal.m`
* **Newton-Gregory ascendente** — `NG_Ascendente.m`
* **Newton-Gregory descendente** — `NG_Descendente.m`

### ∫ Integración numérica

Implementaciones de métodos de integración aproximada:

* **Regla de los trapecios** — `Trapecios.m`
* **Simpson 1/3** — `SimpsonUnTercio.m`
* **Simpson 3/8** — `SimpsonTresOctavos.m`
* **Simpson combinado** — `SimpsonCombinado.m`

### 📐 Ecuaciones diferenciales ordinarias

Métodos numéricos para aproximar soluciones de ecuaciones diferenciales ordinarias:

* **Euler** — `Euler.m`
* **Euler modificado** — `Euler_Modificado.m`
* **Runge-Kutta de segundo orden** — `Kutta_SegundoOrden.m`
* **Runge-Kutta de cuarto orden** — `Kutta_CuartoOrden.m`
* **Método de Milne** — `Milne.m`
* `Metodos_Unidad7.m` — material con todos los métodos correspondientes a esta unidad a fin de poder compararlos entre sí.

---

## Tecnologías

* **GNU Octave**
* MATLAB-compatible syntax

No se utilizan librerías externas. Las implementaciones fueron desarrolladas utilizando las funcionalidades propias de Octave.

## Estructura del repositorio

```text
.
├── Biseccion.m
├── Calculo_errores.m
├── Comparacion_Metodos_Raices.m
├── Descomposicion_LU.m
├── Eliminacion_Gauss.m
├── Euler.m
├── Euler_Modificado.m
├── Fadeev_Leverrier.m
├── Interpolacion_Lineal.m
├── Kutta_CuartoOrden.m
├── Kutta_SegundoOrden.m
├── Metodos_Unidad7.m
├── Milne.m
├── NG_Ascendente.m
├── NG_Descendente.m
├── Newton_Raphson.m
├── SimpsonCombinado.m
├── SimpsonTresOctavos.m
├── SimpsonUnTercio.m
├── Trapecios.m
└── README.md
```

## Ejecución

Para utilizar los métodos es necesario tener instalado **GNU Octave**.

Una vez clonado el repositorio, abrir Octave en el directorio del proyecto y ejecutar el archivo correspondiente.

Por ejemplo:

```octave
Biseccion
```

o:

```octave
Newton_Raphson
```

Dependiendo de la implementación, pueden ser necesarios datos de entrada definidos dentro del archivo o solicitados durante la ejecución.

## Objetivos del proyecto

Este repositorio fue desarrollado con los siguientes objetivos:

* Implementar algoritmos fundamentales de métodos numéricos.
* Comprender el funcionamiento de los distintos métodos mediante su implementación.
* Aplicar los métodos a problemas matemáticos concretos.
* Analizar y comparar resultados obtenidos mediante diferentes algoritmos.
* Familiarizarse con **GNU Octave** como herramienta de cálculo científico.

---

> 📌 **Nota:** Este repositorio tiene finalidad principalmente académica y educativa. Las implementaciones están orientadas al estudio y comprensión de los métodos numéricos, por lo que pueden requerir adaptaciones para su utilización en aplicaciones de propósito general.
