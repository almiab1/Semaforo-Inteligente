%% -------------------------------------------------------------------------------------------------
%
% Projecto Practicas TDI
% Asignatura: Tratamiento de Imagen: Visión Artificial
% Autores: Alejandro Mira Abad y Brian Calabuig Chafer
% Descripción: Detección de vehiculos y personas para cambiar el estado de un semáforo
%
%% -------------------------------------------------------------------------------------------------
% Funcion procesar imagen
function output = procesarImagen(imagenBase)
    
    I = imagenBase; % Cargamos la imagen
    I = rgb2gray(I); % Pasamos a escala de grises la imagen
    detectorVehicle = vehicleDetectorACF('front-rear-view'); % Cargamos el detector de vehiculos
    detectorPeople = peopleDetectorACF('inria-100x41'); % Cargamos el detector de personas
    
    % Deteccion vehiculos
    [cajasVehiculos,puntuacionVehiculos] = detect(detectorVehicle,I); % Activamos el detector

    indice = find(puntuacionVehiculos >= 5);

    pV = puntuacionVehiculos(indice);
    cV = cajasVehiculos(indice,:);
    
    I = insertObjectAnnotation(I,'rectangle',cV,pV); % Insertamos loos contenedores con los valores
        
    % Deteccion personas
    [cajasPersonas,puntuacionPersonas] = detect(detectorPeople,I);
    if not (isempty(cajasPersonas))
        I = insertObjectAnnotation(I,'rectangle',cajasPersonas,puntuacionPersonas);
    end
    
    figure,imshow(I);
    
    numCoches = size(cV);
    numPersonas = size(cajasPersonas);
    
    % Outputs
    output = [numCoches(1); numPersonas(1)];
end

