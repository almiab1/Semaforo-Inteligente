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

% pV = puntuacionVehiculos;
% cV = cajasVehiculos;

tamanyoPunt = abs(length(puntuacionVehiculos));

indice = find(puntuacionVehiculos >= 5);

pV = puntuacionVehiculos(indice);
cV = cajasVehiculos(indice,:);

% I = insertObjectAnnotation(I,'rectangle',cV,pV); % Insertamos loos contenedores con los valores 

% figure
% imshow(I)
% title('Detecci�n de vehiculos y detecci�n de puntuaci�n')
%% -------------------------------------------------------------------------------------------------
% Deteccion personas
[cajasPersonas,puntuacionPersonas] = detect(detectorPeople,I);

if not (isempty(cajasPersonas))
%     I = insertObjectAnnotation(I,'rectangle',cajasPersonas,puntuacionPersonas);
end

% figure
% imshow(I)
% title('Detecci�n de vehiculos y personas con su puntuaci�n')
%% -------------------------------------------------------------------------------------------------
% Poner en gray scale y operaciones binarias

I = rgb2gray(I);
I = imbinarize(I, 'adaptive','Sensitivity',0.4);
I = imfill(I,'holes');
SE = strel('rectangle',[5,4]);
I = imdilate(I,SE);
figure
imshow(I)