package com.estupiso.service;

import com.estupiso.model.Anunciante;
import com.estupiso.model.Roles;
import com.estupiso.model.Vivienda;
import com.estupiso.model.SolicitudVivienda;
import com.estupiso.model.FotoVivienda;
import com.estupiso.repository.AnuncianteRepository;
import com.estupiso.repository.ViviendaRepository;
import com.estupiso.repository.SolicitudViviendaRepository;
import com.estupiso.repository.FotoViviendaRepository;
import com.estupiso.security.JWTUtils;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class AnuncianteService {    @Autowired
    private AnuncianteRepository anuncianteRepository;

    @Autowired
    private ViviendaRepository viviendaRepository;

    @Autowired
    private SolicitudViviendaRepository solicitudViviendaRepository;

    @Autowired
    private FotoViviendaRepository fotoViviendaRepository;

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
    }    @Transactional
    public boolean deleteAnunciante() {
        Anunciante anunciante = (Anunciante) jwtUtils.userLogin();
        if (anunciante != null) {
            return deleteAnuncianteWithCascade(anunciante);
        }
        return false;
    }

    /**
     * Elimina un anunciante y sus viviendas en cascada, pero solo si las viviendas no tienen residentes
     * @param anunciante El anunciante a eliminar
     * @return true si se eliminó correctamente, false si no se pudo eliminar
     * @throws RuntimeException si alguna vivienda tiene residentes
     */
    @Transactional
    public boolean deleteAnuncianteWithCascade(Anunciante anunciante) {
        // 1. Verificar que ninguna vivienda del anunciante tenga residentes
        List<Vivienda> viviendasConResidentes = anunciante.getViviendas().stream()
                .filter(vivienda -> vivienda.getResidentes() != null && !vivienda.getResidentes().isEmpty())
                .toList();
        
        if (!viviendasConResidentes.isEmpty()) {
            throw new RuntimeException("No se puede eliminar el anunciante porque tiene viviendas con residentes. " +
                    "Primero debe eliminar a todos los residentes de sus viviendas.");
        }
    
        
        // 2. Obtener todas las viviendas del anunciante para procesamiento en cascada
        List<Vivienda> viviendas = anunciante.getViviendas();
        
        // 3. Para cada vivienda, eliminar en este orden:
        for (Vivienda vivienda : viviendas) {
            // 3a. Eliminar todas las solicitudes relacionadas con esta vivienda
            List<SolicitudVivienda> solicitudes = solicitudViviendaRepository.findByViviendaId(vivienda.getId());
            if (!solicitudes.isEmpty()) {
                solicitudViviendaRepository.deleteAll(solicitudes);
            }
            
            // 3b. Eliminar todas las fotos de la vivienda
            List<FotoVivienda> fotos = vivienda.getFotos();

            if (fotos != null && !fotos.isEmpty()) {
                fotoViviendaRepository.deleteAll(fotos);
            }
        }
        
        // 4. Eliminar todas las viviendas del anunciante
        if (!viviendas.isEmpty()) {
            viviendaRepository.deleteAll(viviendas);
        }
        
        // 5. Finalmente, eliminar el anunciante
        anuncianteRepository.delete(anunciante);
        return true;
    }
}
