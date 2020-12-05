function ouput = cambioDeEstado(numAutomoviles,numPeatones, distancia)
    if numAutomoviles > numPeatones && distancia == true
        ouput = true;
    elseif numAutomoviles > numPeatones && distancia == false
        ouput = false;
    elseif numAutomoviles < numPeatones && distancia == true
        ouput = false;
    elseif numAutomoviles < numPeatones && distancia == false
        ouput = true;
    end
end

