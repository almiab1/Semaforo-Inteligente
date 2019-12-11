%% -------------------------------------------------------------------------------------------------
%
% Projecto Practicas TDI
% Asignatura: Tratamiento de Imagen: Visión Artificial
% Autores: Alejandro Mira Abad y Brian Calabuig Chafer
% Descripción: Detección de vehiculos y personas para cambiar el estado de un semáforo
%
%% -------------------------------------------------------------------------------------------------
% Configuración inicial de 
clc
clear
close all

I = imread('imagPasoCebra2.jpg'); % Cargamos la imagen
detectorVehicle = vehicleDetectorACF('front-rear-view'); % Cargamos el detector de vehiculos
detectorPeople = peopleDetectorACF('inria-100x41'); % Cargamos el detector de personas
%% -------------------------------------------------------------------------------------------------
% Deteccion vehiculos
[cajasVehiculos,puntuacionVehiculos] = detect(detectorVehicle,I); % Activamos el detector

p0 = puntuacionVehiculos;
c0 = cajasVehiculos;

tamanyoPunt = abs(length(puntuacionVehiculos))-1;

for i = 1:tamanyoPunt
    if ( puntuacionVehiculos(i) > 6.00)
        c0(i,:) = [];
        p0(i) = [];
    end
end

I = insertObjectAnnotation(I,'rectangle',c0,p0); % Insertamos loos contenedores con los valores 

figure
imshow(I)
title('Detección de vehiculos y detección de puntuación')
%% -------------------------------------------------------------------------------------------------
% Deteccion personas
[cajasPersonas,puntuacionPersonas] = detect(detectorPeople,I);
if not (isempty(cajasPersonas))
I = insertObjectAnnotation(I,'rectangle',cajasPersonas,puntuacionPersonas);
end
figure
imshow(I)
title('Detección de vehiculos y personas con su puntuación')


