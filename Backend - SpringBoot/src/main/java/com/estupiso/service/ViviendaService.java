package com.estupiso.service;

import com.estupiso.model.Anunciante;
import com.estupiso.model.Estudiante;
import com.estupiso.model.Vivienda;
import com.estupiso.repository.EstudianteRepository;
import com.estupiso.repository.ViviendaRepository;
import com.estupiso.security.JWTUtils;
import com.estupiso.specification.ViviendaSpecification;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
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

    public List<Vivienda> findByAnunciante(int id) {
        Optional<Anunciante> anunciante = anuncianteService.findById(id);
        if (anunciante.isPresent()) {
            return anunciante.get().getViviendas();
        }
        return null;
    }

    public List<Vivienda> findAllViviendas() {
        return viviendaRepository.findAll();
    }

    public Optional<Vivienda> findById(int id) {
        return viviendaRepository.findById(id);
    }

    public Page<Vivienda> buscarViviendas(String comunidad, String provincia, String municipio,
                                          String nombre, boolean soloDisponibles, String direccion, int pagina, int tamañoPagina) {
        Specification<Vivienda> spec = Specification.where(null);
        if (comunidad != null) {
            spec = spec.and(ViviendaSpecification.conComunidad(comunidad));
            if (provincia != null) {
                spec = spec.and(ViviendaSpecification.conProvincia(provincia));
                if (municipio != null) {
                    spec = spec.and(ViviendaSpecification.conMunicipio(municipio));
                }
            }
        }
        spec = spec
                .and(soloDisponibles ? ViviendaSpecification.disponible() : null)
                .and(nombre != null ? ViviendaSpecification.conNombre(nombre) : null)
                .and(direccion != null ? ViviendaSpecification.conDireccion(direccion) : null);
        Pageable pageable = PageRequest.of(pagina, tamañoPagina);

        return viviendaRepository.findAll(spec, pageable);
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
                viviendaO.get().setPrecioMensual(viviendaU.getPrecioMensual());
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

    @Transactional
    public boolean deleteVivienda(int idVivienda) {
        Optional<Vivienda> viviendaO = viviendaRepository.findById(idVivienda);
        if (viviendaO.isPresent()) {
            Anunciante anuncianteLogin = jwtUtils.userLogin();
            if (anuncianteLogin != null && anuncianteLogin.getViviendas().contains(viviendaO.get())) {
                viviendaRepository.deleteById(idVivienda);
                return true;
            }
        }
        return false;
    }

}
