package com.estupiso.service;

import com.estupiso.dto.ViviendaDto;
import com.estupiso.model.*;
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
import java.util.Objects;
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

    /*
    public List<Vivienda> findByAnunciante(int id) {
        Optional<Anunciante> anunciante = anuncianteService.findById(id);
        if (anunciante.isPresent()) {
            return anunciante.get().getViviendas();
        }
        return null;
    }
    */


    public List<Vivienda> findAllViviendasByAnunciante() {
        Anunciante userLogin = (Anunciante) jwtUtils.userLogin();
        if (userLogin != null) {
           Optional<List<Vivienda>> viviendasO = viviendaRepository.findAllByAnuncianteId(userLogin.getId());
            return viviendasO.orElse(null);
        }
        return null;
    }

    public List<Vivienda> findAllViviendas() {
        return viviendaRepository.findAll();
    }

    public ViviendaDto findById(int id) {
        Optional<Vivienda> v = viviendaRepository.findById(id);
        ViviendaDto vDto = new ViviendaDto();
        if (v.isPresent()) {
            vDto.setId(v.get().getId());
            vDto.setTipoVivienda(v.get().getTipoVivienda());
            vDto.setCalle(v.get().getCalle());
            vDto.setPrecioMensual(v.get().getPrecioMensual());
            vDto.setNumero(v.get().getNumero());
            vDto.setComunidad(v.get().getComunidad());
            vDto.setProvincia(v.get().getProvincia());
            vDto.setMunicipio(v.get().getMunicipio());
            vDto.setDescripcion(v.get().getDescripcion());
            vDto.setNumeroHabitaciones(v.get().getNumeroHabitaciones());
            vDto.setAnuncianteEmail(v.get().getAnunciante().getEmail());
            vDto.setNombre(v.get().getNombre());
            vDto.setFotos(v.get().getFotos());
            vDto.setAnuncianteId(v.get().getAnunciante().getId());
            vDto.setAnuncianteNombre(v.get().getAnunciante().getNombre());
            vDto.setFotos(v.get().getFotos());
            vDto.setUltimaEdicion(v.get().getUltimaEdicion());
            vDto.setFechaPublicacion(v.get().getFechaPublicacion());
            vDto.setResidentes(v.get().getResidentes());
            vDto.setAnuncianteTelefono(v.get().getAnunciante().getTelefono());
            return vDto;
        }
        return null;
    }    public Page<Vivienda> buscarViviendas(String comunidad, String provincia, String municipio,
                                               String nombre, TiposVivienda tipoVivienda, Double precioMin, Double precioMax,
                                               Integer habitaciones, boolean soloDisponibles, String direccion,
                                               int pagina, int tamañoPagina) {
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
                .and(tipoVivienda != null ? ViviendaSpecification.conTipoVivienda(tipoVivienda) : null)
                .and(precioMin != null ? ViviendaSpecification.conPrecioMinimo(precioMin) : null)
                .and(precioMax != null ? ViviendaSpecification.conPrecioMaximo(precioMax) : null)
                .and(habitaciones != null ? ViviendaSpecification.conHabitacionesMinimas(habitaciones) : null)
                .and(direccion != null ? ViviendaSpecification.conDireccion(direccion) : null);
        Pageable pageable = PageRequest.of(pagina, tamañoPagina);

        return viviendaRepository.findAll(spec, pageable);
    }

    @Transactional
    public Vivienda createVivienda(Vivienda vivienda) {
        Anunciante anuncianteLogin = (Anunciante) jwtUtils.userLogin();
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
            Anunciante anuncianteLogin = (Anunciante) jwtUtils.userLogin();
            if (anuncianteLogin != null && Objects.equals(viviendaU.getAnunciante().getId(), anuncianteLogin.getId())) {
                Vivienda viviendaExistente = viviendaO.get();
                
                // Actualizar campos básicos
                viviendaExistente.setUltimaEdicion(LocalDateTime.now());
                viviendaExistente.setTipoVivienda(viviendaU.getTipoVivienda());
                viviendaExistente.setCalle(viviendaU.getCalle());
                viviendaExistente.setPrecioMensual(viviendaU.getPrecioMensual());
                viviendaExistente.setNumero(viviendaU.getNumero());
                viviendaExistente.setComunidad(viviendaU.getComunidad());
                viviendaExistente.setProvincia(viviendaU.getProvincia());
                viviendaExistente.setMunicipio(viviendaU.getMunicipio());
                viviendaExistente.setDescripcion(viviendaU.getDescripcion());
                viviendaExistente.setNumeroHabitaciones(viviendaU.getNumeroHabitaciones());
                viviendaExistente.setNombre(viviendaU.getNombre());
                
                // Gestión de fotos usando métodos helper
                if (viviendaU.getFotos() != null) {
                    // Usar el método helper para limpiar fotos
                    viviendaExistente.clearFotos();
                    
                    // Añadir las nuevas fotos usando el método helper
                    for (FotoVivienda nuevaFoto : viviendaU.getFotos()) {
                        if (nuevaFoto.getImagen() != null && !nuevaFoto.getImagen().isEmpty()) {
                            FotoVivienda foto = new FotoVivienda();
                            foto.setImagen(nuevaFoto.getImagen());
                            viviendaExistente.addFoto(foto);
                        }
                    }
                }
                
                return viviendaRepository.save(viviendaExistente);
            }
        }
        return null;
    }

    @Transactional
    public Vivienda añadirResidente(int idVivienda, int idResidente) {
        Optional<Vivienda> viviendaO = viviendaRepository.findById(idVivienda);
        Optional<Estudiante> estudianteO = estudianteRepository.findById(idResidente);
        if (estudianteO.isPresent() && viviendaO.isPresent()) {
            Anunciante anuncianteLogin = (Anunciante) jwtUtils.userLogin();
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
            Anunciante anuncianteLogin = (Anunciante) jwtUtils.userLogin();
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