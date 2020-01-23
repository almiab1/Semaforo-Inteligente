%% -------------------------------------------------------------------------------------------------
%
% Projecto Practicas TDI
% Asignatura: Tratamiento de Imagen: Visión Artificial
% Autores: Alejandro Mira Abad y Brian Calabuig Chafer
% Descripción: Detección de vehiculos y personas para cambiar el estado de un semáforo
%
%% -------------------------------------------------------------------------------------------------
% Funcion cargar imagen
function imgParametros = procesarImg(imgenBase)
    
    I = imread(imgenBase); % Cargamos la imagen
    detectorVehicle = vehicleDetectorACF('front-rear-view'); % Cargamos el detector de vehiculos
    detectorPeople = peopleDetectorACF('inria-100x41'); % Cargamos el detector de personas
    
    % Deteccion vehiculos
    [cajasVehiculos,puntuacionVehiculos] = detect(detectorVehicle,I); % Activamos el detector

    tamanyoPunt = abs(length(puntuacionVehiculos));

    indice = find(puntuacionVehiculos >= 5);

    pV = puntuacionVehiculos(indice);
    numCoches = cajasVehiculos(indice,:);
    
    % Deteccion personas
    [cajasPersonas,puntuacionPersonas] = detect(detectorPeople,I);
    
    imgParametros = [size(numCoches),size(cajasPersonas),1];
end