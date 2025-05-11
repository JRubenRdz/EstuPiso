package com.estupiso.service;

import com.estupiso.model.Comunidad;
import com.estupiso.repository.ComunidadRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ComunidadService {

    @Autowired
    private ComunidadRepository comunidadRepository;

    public List<Comunidad> findAll() {
        return comunidadRepository.findAll();
    }

    public Optional<Comunidad> findById(Integer id) {
        return comunidadRepository.findById(id);
    }

    public Optional<Comunidad> findByNombre(String nombre) {
        return comunidadRepository.findByNombre(nombre);
    }
}
