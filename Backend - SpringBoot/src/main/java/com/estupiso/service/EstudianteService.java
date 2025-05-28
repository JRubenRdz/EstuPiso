package com.estupiso.service;

import com.estupiso.model.Estudiante;
import com.estupiso.model.Roles;
import com.estupiso.repository.EstudianteRepository;
import com.estupiso.security.JWTUtils;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EstudianteService {
    @Autowired
    private EstudianteRepository estudianteRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JWTUtils jwtUtils;

    @Transactional
    public Estudiante save(Estudiante estudiante) {
        return estudianteRepository.save(estudiante);
    }

    @Transactional
    public Estudiante createEstudiante(Estudiante estudiante) {

        Optional<Estudiante> estudianteO = estudianteRepository.findByUsuario(estudiante.getUsuario());
        if (estudianteO.isPresent()) {
            return null;
        }
        estudiante.setVivienda(null);
        estudiante.setRol(Roles.ESTUDIANTE);

        estudiante.setContraseña(passwordEncoder.encode(estudiante.getContraseña()));
        return estudianteRepository.save(estudiante);
    }

    @Transactional
    public Estudiante updateEstudiante(Estudiante estudianteU) {
        Estudiante estudiante = (Estudiante) jwtUtils.userLogin();
        if (estudiante != null) {
            estudiante.setNombre(estudianteU.getNombre());
            estudiante.setUsuario(estudianteU.getUsuario());
            estudiante.setContraseña(passwordEncoder.encode(estudianteU.getContraseña()));
            estudiante.setEmail(estudianteU.getEmail());
            estudiante.setFotoPerfil(estudianteU.getFotoPerfil());
            estudiante.setRol(Roles.ESTUDIANTE);
            estudiante.setVivienda(estudianteU.getVivienda());
            return estudianteRepository.save(estudiante);
        }
        return null;
    }

    public List<Estudiante> findAllEstudiantes() {
        return estudianteRepository.findAll();
    }

    public Optional<Estudiante> findById(int id) {
        return estudianteRepository.findById(id);
    }

    public Optional<Estudiante> findByUsuario(String usuario) {
        return estudianteRepository.findByUsuario(usuario);
    }

    @Transactional
    public boolean deleteEstudiante() {
        Estudiante estudiante = (Estudiante) jwtUtils.userLogin();
        if (estudiante != null) {
            estudianteRepository.deleteById(estudiante.getId());
            return true;
        }
        return false;
    }
}
