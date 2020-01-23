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

% pV = puntuacionVehiculos;
% cV = cajasVehiculos;

tamanyoPunt = abs(length(puntuacionVehiculos));

indice = find(puntuacionVehiculos >= 5);

pV = puntuacionVehiculos(indice);
cV = cajasVehiculos(indice,:);

% I = insertObjectAnnotation(I,'rectangle',cV,pV); % Insertamos loos contenedores con los valores 

% figure
% imshow(I)
% title('Detección de vehiculos y detección de puntuación')
%% -------------------------------------------------------------------------------------------------
% Deteccion personas
[cajasPersonas,puntuacionPersonas] = detect(detectorPeople,I);

if not (isempty(cajasPersonas))
%     I = insertObjectAnnotation(I,'rectangle',cajasPersonas,puntuacionPersonas);
end

% figure
% imshow(I)
% title('Detección de vehiculos y personas con su puntuación')
%% -------------------------------------------------------------------------------------------------
% Poner en gray scale y operaciones binarias

I = rgb2gray(I);
I = imbinarize(I, 'adaptive','Sensitivity',0.4);
I = imfill(I,'holes');
SE = strel('rectangle',[5,4]);
I = imdilate(I,SE);
figure
imshow(I)