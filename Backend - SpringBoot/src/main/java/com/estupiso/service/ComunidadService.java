package com.estupiso.service;

import com.estupiso.dto.ComunidadDto;
import com.estupiso.model.Comunidad;
import com.estupiso.repository.ComunidadRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ComunidadService {    @Autowired
    private ComunidadRepository comunidadRepository;

    public List<Comunidad> findAll() {
        return comunidadRepository.findAll();
    }

    public List<ComunidadDto> findAllSinProvincias() {
        List<Comunidad> comunidades = comunidadRepository.findAll();
        return comunidades.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    public Optional<Comunidad> findById(int id) {
        return comunidadRepository.findById(id);
    }

    public Optional<Comunidad> findByNombre(String nombre) {
        return comunidadRepository.findByNombre(nombre);
    }

    private ComunidadDto convertToDto(Comunidad comunidad) {
        return new ComunidadDto(comunidad.getId(), comunidad.getNombre());
    }
}
