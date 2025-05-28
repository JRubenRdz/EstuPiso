package com.estupiso.service;

import com.estupiso.model.Actor;
import com.estupiso.model.Anunciante;
import com.estupiso.model.Estudiante;
import com.estupiso.model.Roles;
import com.estupiso.repository.AnuncianteRepository;
import com.estupiso.security.JWTUtils;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class AnuncianteService {

    @Autowired
    private AnuncianteRepository anuncianteRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JWTUtils jwtUtils;

    @Transactional
    public Anunciante save(Anunciante anunciante) {
        return anuncianteRepository.save(anunciante);
    }

    @Transactional
    public Anunciante createAnunciante(Anunciante anunciante) {

        Optional<Anunciante> anuncianteO = anuncianteRepository.findByUsuario(anunciante.getUsuario());
        if (anuncianteO.isPresent()) {
            return null;
        }

        anunciante.setViviendas(new ArrayList<>());
        anunciante.setRol(Roles.ANUNCIANTE);

        anunciante.setContraseña(passwordEncoder.encode(anunciante.getContraseña()));
        return anuncianteRepository.save(anunciante);
    }

    @Transactional
    public Anunciante updateAnunciante(Anunciante anuncianteU) {
        Anunciante anunciante = (Anunciante) jwtUtils.userLogin();
        if (anunciante != null) {
            anunciante.setContraseña(passwordEncoder.encode(anuncianteU.getContraseña()));
            anunciante.setRol(Roles.ANUNCIANTE);
            anunciante.getViviendas().clear();
            anunciante.getViviendas().addAll(anuncianteU.getViviendas());
            anunciante.setEmail(anuncianteU.getEmail());
            anunciante.setNombre(anuncianteU.getNombre());
            anunciante.setTelefono(anuncianteU.getTelefono());
            anunciante.setFotoPerfil(anuncianteU.getFotoPerfil());
            anunciante.setUsuario(anuncianteU.getUsuario());
            return anuncianteRepository.save(anunciante);
        }
        return null;
    }

    public List<Anunciante> findAllAnunciantes() {
        return anuncianteRepository.findAll();
    }

    public Optional<Anunciante> findById(int id) {
        return anuncianteRepository.findById(id);
    }

    public Optional<Anunciante> findByUsuario(String usuario) {
        return anuncianteRepository.findByUsuario(usuario);
    }

    @Transactional
    public boolean deleteAnunciante() {
        Anunciante anunciante = (Anunciante) jwtUtils.userLogin();
        if (anunciante != null) {
            anuncianteRepository.delete(anunciante);
            return true;
        }
        return false;
    }
}
