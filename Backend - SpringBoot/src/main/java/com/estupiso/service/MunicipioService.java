package com.estupiso.service;

import com.estupiso.model.Municipio;
import com.estupiso.model.Provincia;
import com.estupiso.repository.MunicipioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MunicipioService {

    @Autowired
    private MunicipioRepository municipioRepository;

    public List<Municipio> findAll() {
        return municipioRepository.findAll();
    }

    public Optional<Municipio> findById(int id) {
        return municipioRepository.findById(id);
    }

    public Optional<Municipio> findByNombre(String nombre) {
        return municipioRepository.findByNombre(nombre);
    }

    public List<Municipio> findByProvincia (Provincia provincia) {
        return municipioRepository.findByProvincia(provincia);
    }

}
