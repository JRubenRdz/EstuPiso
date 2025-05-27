package com.estupiso.service;

import com.estupiso.model.Anunciante;
import com.estupiso.model.Estudiante;
import com.estupiso.model.FotoVivienda;
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
import java.util.ArrayList;

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

    @Autowired
    private FotoViviendaService fotoViviendaService;

    public List<Vivienda> findByAnunciante(int id) {
        Optional<Anunciante> anunciante = anuncianteService.findById(id);
        if (anunciante.isPresent()) {
            return anunciante.get().getViviendas();
        }
        return null;
    }

    public List<Vivienda> findAllViviendas() {
        Anunciante userLogin = jwtUtils.userLogin();
        if (userLogin != null) {
           Optional<List<Vivienda>> viviendasO = viviendaRepository.findAllByAnunciante(userLogin);
            return viviendasO.orElse(null);
        }
        return null;
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
            // Primero establecemos la fecha de publicación y el anunciante
            vivienda.setFechaPublicacion(LocalDateTime.now());
            vivienda.setAnunciante(anuncianteLogin);
            
            // Almacenar las fotos en una lista separada y limpiar la lista original
            List<FotoVivienda> fotosOriginales = null;
            if (vivienda.getFotos() != null && !vivienda.getFotos().isEmpty()) {
                fotosOriginales = List.copyOf(vivienda.getFotos());
                vivienda.getFotos().clear();
            }
            
            // Guardamos primero la vivienda sin las fotos
            Vivienda viviendaGuardada = viviendaRepository.save(vivienda);
            
            // Después añadimos y guardamos las fotos una por una
            if (fotosOriginales != null) {
                for (FotoVivienda foto : fotosOriginales) {
                    // Verificar que la foto tiene una URL válida
                    if (foto.getImagen() == null || foto.getImagen().isEmpty()) {
                        System.out.println("Advertencia: Saltando foto sin URL válida");
                        continue; // Saltar fotos sin URL
                    }
                    
                    // Establecer explícitamente la relación
                    foto.setVivienda(viviendaGuardada);
                    
                    // Guardar la foto
                    FotoVivienda fotoGuardada = fotoViviendaService.saveFotoVivienda(foto);
                    
                    // Añadir la foto guardada a la colección de la vivienda
                    if (viviendaGuardada.getFotos() == null) {
                        viviendaGuardada.setFotos(new java.util.ArrayList<>());
                    }
                    viviendaGuardada.getFotos().add(fotoGuardada);
                }
                
                // Actualizar la vivienda con las fotos añadidas
                viviendaGuardada = viviendaRepository.save(viviendaGuardada);
            }
            
            return viviendaGuardada;
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
            if (anuncianteLogin != null) {
                // Verificación directa por ID en lugar de usar contains()
                if (viviendaO.get().getAnunciante().getId() == anuncianteLogin.getId()) {
                    // Eliminar explícitamente las fotos primero
                    for (FotoVivienda foto : new ArrayList<>(viviendaO.get().getFotos())) {
                        fotoViviendaService.deleteFotoVivienda(foto.getId());
                    }
                    // Luego eliminar la vivienda
                    viviendaRepository.delete(viviendaO.get());
                    return true;
                }
            }
        }
        return false;
    }

}