package com.estupiso.service;

import com.estupiso.model.Anunciante;
import com.estupiso.model.Estudiante;
import com.estupiso.model.Vivienda;
import com.estupiso.repository.EstudianteRepository;
import com.estupiso.repository.ViviendaRepository;
import com.estupiso.security.JWTUtils;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class ViviendaService {

    @Autowired
    private ViviendaRepository viviendaRepository;

    @Autowired
    private JWTUtils jwtUtils;

    @Autowired
    private AnuncianteService anuncianteService;

    @Autowired
    private EstudianteRepository estudianteRepository;

    public List<Vivienda> findByAnunciante() {
        Anunciante anunciante = jwtUtils.userLogin();
        return anunciante.getViviendas();
    }

    public List<Vivienda> findAllViviendas() {
        return viviendaRepository.findAll();
    }

    public Optional<Vivienda> findById(int id) {
        return viviendaRepository.findById(id);
    }

    @Transactional
    public Vivienda createVivienda(Vivienda vivienda) {
        Anunciante anuncianteLogin = jwtUtils.userLogin();
        if (anuncianteLogin != null) {
            vivienda.setFechaPublicacion(LocalDateTime.now());
            vivienda.setAnunciante(anuncianteLogin);
            return viviendaRepository.save(vivienda);
        }
        return null;
    }

    @Transactional
    public Vivienda updateVivienda(Vivienda viviendaU) {
        Optional<Vivienda> viviendaO = viviendaRepository.findById(viviendaU.getId());
        if (viviendaO.isPresent()) {
            Anunciante anuncianteLogin = jwtUtils.userLogin();
            if (anuncianteLogin != null && anuncianteLogin.getViviendas().contains(viviendaU)) {
                viviendaO.get().setUltimaEdicion(LocalDateTime.now());
                viviendaO.get().setTipoVivienda(viviendaU.getTipoVivienda());
                viviendaO.get().setCalle(viviendaU.getCalle());
                viviendaO.get().setNumero(viviendaU.getNumero());
                viviendaO.get().setComunidad(viviendaU.getComunidad());
                viviendaO.get().setProvincia(viviendaU.getProvincia());
                viviendaO.get().setMunicipio(viviendaU.getMunicipio());
                viviendaO.get().setDescripcion(viviendaU.getDescripcion());
                viviendaO.get().setFotos(viviendaU.getFotos());
                viviendaO.get().setNumeroHabitaciones(viviendaU.getNumeroHabitaciones());
                viviendaO.get().setNombre(viviendaU.getNombre());
                return viviendaRepository.save(viviendaO.get());
            }
        }
        return null;
    }

    @Transactional
    public Vivienda añadirResidente(int idVivienda, int idResidente) {
        Optional<Vivienda> viviendaO = viviendaRepository.findById(idVivienda);
        Optional<Estudiante> estudianteO = estudianteRepository.findById(idResidente);
        if (estudianteO.isPresent() && viviendaO.isPresent()) {
            Anunciante anuncianteLogin = jwtUtils.userLogin();
            if (anuncianteLogin != null && estudianteO.get().getVivienda() != viviendaO.get()) {
                viviendaO.get().añadirResidente(estudianteO.get());
                estudianteRepository.save(estudianteO.get());
                return viviendaRepository.save(viviendaO.get());
            }
        }
        return null;
    }

}
