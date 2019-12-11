%% -------------------------------------------------------------------------------------------------
%
% Projecto Practicas TDI
% Asignatura: Tratamiento de Imagen: Visi�n Artificial
% Autores: Alejandro Mira Abad y Brian Calabuig Chafer
% Descripci�n: Detecci�n de vehiculos y personas para cambiar el estado de un sem�foro
%
%% -------------------------------------------------------------------------------------------------
% Configuraci�n inicial de 
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
title('Detecci�n de vehiculos y detecci�n de puntuaci�n')
%% -------------------------------------------------------------------------------------------------
% Deteccion personas
[cajasPersonas,puntuacionPersonas] = detect(detectorPeople,I);
if not (isempty(cajasPersonas))
I = insertObjectAnnotation(I,'rectangle',cajasPersonas,puntuacionPersonas);
end
figure
imshow(I)
title('Detecci�n de vehiculos y personas con su puntuaci�n')


