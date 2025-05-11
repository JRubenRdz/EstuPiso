package com.estupiso.service;

import com.estupiso.model.Comunidad;
import com.estupiso.model.Provincia;
import com.estupiso.repository.ProvinciaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProvinciaService {

    @Autowired
    private ProvinciaRepository provinciaRepository;

    public Optional<Provincia> findByNombre(String nombre) {
        return provinciaRepository.findByNombre(nombre);
    }

    public List<Provincia> findAll() {
        return provinciaRepository.findAll();
    }

    public Optional<Provincia> findById(int id) {
        return provinciaRepository.findById(id);
    }

    public List<Provincia> findByComunidad(Comunidad comunidad) {
        return provinciaRepository.findByComunidad(comunidad);
    }

}
