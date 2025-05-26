package com.estupiso.service;

import com.estupiso.dto.ProvinciaDto;
import com.estupiso.model.Comunidad;
import com.estupiso.model.Provincia;
import com.estupiso.repository.ProvinciaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ProvinciaService {

    @Autowired
    private ProvinciaRepository provinciaRepository;

    @Autowired
    private ComunidadService comunidadService;

    public Optional<Provincia> findByNombre(String nombre) {
        return provinciaRepository.findByNombre(nombre);
    }

    public List<Provincia> findAll() {
        return provinciaRepository.findAll();
    }

    public List<ProvinciaDto> findAllSinMunicipios() {
        List<Provincia> provincias = provinciaRepository.findAll();
        return provincias.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    public Optional<Provincia> findById(int id) {
        return provinciaRepository.findById(id);
    }

    public List<Provincia> findByComunidad(Comunidad comunidad) {
        return provinciaRepository.findByComunidad(comunidad);
    }

    public List<ProvinciaDto> findByComunidadId(int comunidadId) {
        Optional<Comunidad> comunidad = comunidadService.findById(comunidadId);
        if (comunidad.isPresent()) {
            List<Provincia> provincias = provinciaRepository.findByComunidad(comunidad.get());
            return provincias.stream()
                    .map(this::convertToDto)
                    .collect(Collectors.toList());
        }
        return List.of();
    }

    private ProvinciaDto convertToDto(Provincia provincia) {
        ProvinciaDto dto = new ProvinciaDto();
        dto.setId(provincia.getId());
        dto.setNombre(provincia.getNombre());
        dto.setComunidadId(provincia.getComunidad().getId());
        dto.setComunidadNombre(provincia.getComunidad().getNombre());
        return dto;
    }
}
