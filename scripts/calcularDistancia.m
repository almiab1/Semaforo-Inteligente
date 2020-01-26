%% -------------------------------------------------------------------------------------------------
%
% Projecto Practicas TDI
% Asignatura: Tratamiento de Imagen: Visión Artificial
% Autores: Alejandro Mira Abad y Brian Calabuig Chafer
% Descripción: Detección de vehiculos y personas para cambiar el estado de un semáforo
%
%% -------------------------------------------------------------------------------------------------
function output = calcularDistancia(imagenBase)
    I = imagenBase; % Cargamos la imagen
    detectorVehicle = vehicleDetectorACF('front-rear-view'); % Cargamos el detector de vehiculos
    detectorPeople = peopleDetectorACF('inria-100x41'); % Cargamos el detector de personas
    
    % Deteccion vehiculos
    [cajasVehiculos,puntuacionVehiculos] = detect(detectorVehicle,I); % Activamos el detector

    tamanyoPunt = abs(length(puntuacionVehiculos));
    indice = find(puntuacionVehiculos >= 5);

    pV = puntuacionVehiculos(indice);
    cV = cajasVehiculos(indice,:);
    
    I = insertObjectAnnotation(I,'rectangle',cV,pV); % Insertamos loos contenedores con los valores
        
    % Deteccion personas
    [cajasPersonas,puntuacionPersonas] = detect(detectorPeople,I);
    if not (isempty(cajasPersonas))
        I = insertObjectAnnotation(I,'rectangle',cajasPersonas,puntuacionPersonas);
    end
    I = rgb2gray(I);
    I = imbinarize(I, 'adaptive','Sensitivity',0.4);
    I = imfill(I,'holes');
    SE = strel('rectangle',[5,4]);
    I = imdilate(I,SE);
    BW = edge(I);

    [H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);
    P = houghpeaks(H, 5, 'threshold', ceil(0.3*max(H(:))));
    x = T(P(:,2));
    y = R(P(:,1));
    lines = houghlines(BW, T, R, P, 'FillGap', 5, 'MinLength', 7);

    figure
    imshow(BW), hold on

    max_len = 0;
    distanciaCoche = 10000000;
    distanciaPersona = 10000000;
    
    for k = 1: length(lines)
        xy = [lines(k).point1; lines(k).point2];
        plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'green');
        plot(xy(1,1), xy(1,2), 'x', 'LineWidth', 2, 'Color', 'yellow');
        plot(xy(2,1), xy(2,2), 'x', 'LineWidth', 2, 'Color', 'red');
        len = norm(lines(k).point1 - lines(k).point2);
        if (len > max_len)
         max_len = len;
        end
        
        for j = 1: length(cV)
            d = sqrt( (cV(j).point2 - cV(j).point1).^2 + (lines(k).point2 - lines(k).point1).^2);
            if (d < distanciaCoche)
                distanciaCoche = d;
            end
        end
        
        for l = 1: length(cajasPersonas)
            di = sqrt( (cajasPersonas(l).point2 - cajasPersonas(l).point1).^2 + (lines(k).point2 - lines(k).point1).^2);
            if (di < distanciaPersona)
                distanciaPersona = di;
            end
        end
    end
    
    % Outputs
    if (distanciaCoche > distanciaPersona)
        output = true;
    end
    if (distanciaCoche <= distanciaPersona)
        output = false;
    end
    
end