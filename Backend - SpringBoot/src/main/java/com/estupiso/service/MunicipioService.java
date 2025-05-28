package com.estupiso.service;

import com.estupiso.dto.MunicipioDto;
import com.estupiso.model.Municipio;
import com.estupiso.repository.MunicipioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class MunicipioService {

    @Autowired
    private MunicipioRepository municipioRepository;

    public List<Municipio> findAll() {
        return municipioRepository.findAll();
    }

    public Optional<Municipio> findById(Integer id) {
        return municipioRepository.findById(id);
    }

    public List<MunicipioDto> findByProvinciaId(Integer provinciaId) {
        // LA CHAPUZA MÁS GRANDE DEL MUNDO - pero funciona
        try {
            List<Municipio> todosMunicipios = municipioRepository.findAll();
            List<MunicipioDto> resultado = new ArrayList<>();
            
            for (Municipio municipio : todosMunicipios) {
                try {
                    if (municipio != null && municipio.getProvincia() != null) {
                        // Convertir todo a String y comparar
                        String provinciaIdStr = String.valueOf(municipio.getProvincia().getId());
                        String targetIdStr = String.valueOf(provinciaId);
                        
                        if (provinciaIdStr.equals(targetIdStr)) {
                            MunicipioDto dto = new MunicipioDto();
                            dto.setId(municipio.getId());
                            dto.setCodMunicipio(municipio.getCodMunicipio());
                            dto.setDc(municipio.getDc());
                            dto.setNombre(municipio.getNombre());
                            dto.setProvinciaId(municipio.getProvincia().getId());
                            dto.setProvinciaNombre(municipio.getProvincia().getNombre());
                            resultado.add(dto);
                        }
                    }
                } catch (Exception e) {
                    // Si falla un municipio, continúa con el siguiente
                    System.err.println("Error procesando municipio: " + e.getMessage());
                }
            }
            
            return resultado;
            
        } catch (Exception e) {
            // Si todo falla, devolver lista vacía
            System.err.println("Error completo en findByProvinciaId: " + e.getMessage());
            return new ArrayList<>();
        }
    }
}