package com.estupiso.service;

import com.estupiso.dto.AnuncianteDto;
import com.estupiso.dto.EstudianteDto;
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
import java.util.stream.Collectors;

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

    @Transactional
    public ViviendaDto findById(int id) {
        // Usar la nueva consulta que carga residentes explícitamente
        Optional<Vivienda> v = viviendaRepository.findByIdWithResidentes(id);
        
        if (v.isPresent()) {
            Vivienda vivienda = v.get();
            ViviendaDto vDto = new ViviendaDto();
            
            // Mapear campos básicos
            vDto.setId(vivienda.getId());
            vDto.setTipoVivienda(vivienda.getTipoVivienda());
            vDto.setCalle(vivienda.getCalle());
            vDto.setPrecioMensual(vivienda.getPrecioMensual());
            vDto.setNumero(vivienda.getNumero());
            vDto.setComunidad(vivienda.getComunidad());
            vDto.setProvincia(vivienda.getProvincia());
            vDto.setMunicipio(vivienda.getMunicipio());
            vDto.setDescripcion(vivienda.getDescripcion());
            vDto.setNumeroHabitaciones(vivienda.getNumeroHabitaciones());
            vDto.setNombre(vivienda.getNombre());
            vDto.setFotos(vivienda.getFotos());
            vDto.setUltimaEdicion(vivienda.getUltimaEdicion());
            vDto.setFechaPublicacion(vivienda.getFechaPublicacion());
            
            // Mapear anunciante
            if (vivienda.getAnunciante() != null) {
                vDto.setAnuncianteEmail(vivienda.getAnunciante().getEmail());
                vDto.setAnuncianteId(vivienda.getAnunciante().getId());
                vDto.setAnuncianteNombre(vivienda.getAnunciante().getNombre());
                vDto.setAnuncianteTelefono(vivienda.getAnunciante().getTelefono());
            }
            
            // Mapear residentes - ahora deberían cargarse correctamente
            System.out.println("=== DEBUG RESIDENTES ===");
            System.out.println("Vivienda ID: " + vivienda.getId());
            System.out.println("Residentes cargados: " + (vivienda.getResidentes() != null ? vivienda.getResidentes().size() : "NULL"));
            
            if (vivienda.getResidentes() != null && !vivienda.getResidentes().isEmpty()) {
                List<EstudianteDto> residentesDto = vivienda.getResidentes().stream()
                        .map(this::convertirEstudianteADto)
                        .collect(Collectors.toList());
                vDto.setResidentes(residentesDto);
                System.out.println("Residentes DTO creados: " + residentesDto.size());
            } else {
                vDto.setResidentes(new ArrayList<>());
                System.out.println("Lista de residentes vacía o null");
            }
            
            return vDto;
        }
        return null;
    }

    public Page<Vivienda> buscarViviendas(String comunidad, String provincia, String municipio,
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
        vivienda.setFechaPublicacion(LocalDateTime.now());
        vivienda.setUltimaEdicion(LocalDateTime.now());
        vivienda.setAnunciante(anuncianteLogin);
        
        System.out.println("=== DEBUG CREAR VIVIENDA ===");
        System.out.println("Fotos recibidas: " + (vivienda.getFotos() != null ? vivienda.getFotos().size() : "NULL"));
        
        // Establecer relación bidireccional para las fotos
        if (vivienda.getFotos() != null && !vivienda.getFotos().isEmpty()) {
            for (FotoVivienda foto : vivienda.getFotos()) {
                if (foto.getImagen() != null && !foto.getImagen().trim().isEmpty()) {
                    foto.setVivienda(vivienda); // ← CRUCIAL: Establecer la relación
                    System.out.println("Foto configurada: " + foto.getImagen());
                }
            }
            
            // Filtrar fotos inválidas
            vivienda.getFotos().removeIf(foto -> 
                foto.getImagen() == null || foto.getImagen().trim().isEmpty());
        }
        
        Vivienda viviendaGuardada = viviendaRepository.save(vivienda);
        System.out.println("Vivienda guardada con " + 
            (viviendaGuardada.getFotos() != null ? viviendaGuardada.getFotos().size() : 0) + " fotos");
        
        return viviendaGuardada;
    }
    return null;
}

@Transactional
public Vivienda updateVivienda(Vivienda viviendaU) {
    System.out.println("=== DEBUG ENTRADA SERVICE ===");
    System.out.println("Fotos recibidas: " + (viviendaU.getFotos() != null ? viviendaU.getFotos().size() : "NULL"));
    
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
            
            // Manejar fotos correctamente
            if (viviendaU.getFotos() != null) {
                // Limpiar fotos existentes
                viviendaExistente.getFotos().clear();
                
                // Añadir nuevas fotos con la relación bidireccional correcta
                for (FotoVivienda nuevaFoto : viviendaU.getFotos()) {
                    if (nuevaFoto.getImagen() != null && !nuevaFoto.getImagen().trim().isEmpty()) {
                        // CRUCIAL: Establecer la relación bidireccional
                        nuevaFoto.setVivienda(viviendaExistente);
                        viviendaExistente.getFotos().add(nuevaFoto);
                        
                        System.out.println("Foto añadida: " + nuevaFoto.getImagen());
                    }
                }
            }
            
            Vivienda viviendaActualizada = viviendaRepository.save(viviendaExistente);
            System.out.println("Vivienda actualizada con " + 
                (viviendaActualizada.getFotos() != null ? viviendaActualizada.getFotos().size() : 0) + " fotos");
            
            return viviendaActualizada;
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
        
        if (anuncianteLogin != null) {
            Vivienda vivienda = viviendaO.get();
            Estudiante estudiante = estudianteO.get();
            
            // DEBUG: Verificar estado inicial
            System.out.println("=== DEBUG AÑADIR RESIDENTE ===");
            System.out.println("Vivienda ID: " + vivienda.getId());
            System.out.println("Estudiante ID: " + estudiante.getId());
            System.out.println("Estudiante actual vivienda: " + (estudiante.getVivienda() != null ? estudiante.getVivienda().getId() : "NULL"));
            System.out.println("Residentes actuales en vivienda: " + vivienda.getResidentes().size());
            
            // Verificar que el anunciante es el propietario de la vivienda
            if (!Objects.equals(vivienda.getAnunciante().getId(), anuncianteLogin.getId())) {
                System.out.println("ERROR: El usuario no es propietario de la vivienda");
                return null;
            }
            
            // Verificar que el estudiante no esté ya en esta vivienda
            if (estudiante.getVivienda() != null && 
                Objects.equals(estudiante.getVivienda().getId(), vivienda.getId())) {
                System.out.println("WARNING: El estudiante ya está en esta vivienda");
                return vivienda; // Ya está añadido, devolver vivienda
            }
            
            // Si el estudiante está en otra vivienda, quitarlo primero
            if (estudiante.getVivienda() != null) {
                Vivienda viviendaAnterior = estudiante.getVivienda();
                viviendaAnterior.getResidentes().remove(estudiante);
                viviendaRepository.save(viviendaAnterior);
                System.out.println("Estudiante removido de vivienda anterior: " + viviendaAnterior.getId());
            }
            
            // Establecer la relación bidireccional correctamente
            estudiante.setVivienda(vivienda);
            if (!vivienda.getResidentes().contains(estudiante)) {
                vivienda.getResidentes().add(estudiante);
            }

            estudiante.setVivienda(vivienda);

            // Guardar primero el estudiante y luego la vivienda
            estudianteRepository.save(estudiante);
            Vivienda viviendaGuardada = viviendaRepository.save(vivienda);
            
            // DEBUG: Verificar estado final
            System.out.println("Residentes después del guardado: " + viviendaGuardada.getResidentes().size());
            
            return viviendaGuardada;
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
                if (viviendaO.get().getAnunciante().getId() == anuncianteLogin.getId()) {
                    for (FotoVivienda foto : new ArrayList<>(viviendaO.get().getFotos())) {
                        fotoViviendaService.deleteFotoVivienda(foto.getId());
                    }
                    viviendaRepository.delete(viviendaO.get());
                    return true;
                }
            }
        }
        return false;
    }

    public ViviendaDto obtenerViviendaPorId(Integer id) {
        Vivienda vivienda = viviendaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Vivienda no encontrada"));
        
        ViviendaDto dto = convertirADto(vivienda);
        
        System.out.println("=== DEBUG BACKEND ===");
        System.out.println("Vivienda ID: " + vivienda.getId());
        System.out.println("Anunciante: " + vivienda.getAnunciante());
        System.out.println("Anunciante ID: " + (vivienda.getAnunciante() != null ? vivienda.getAnunciante().getId() : "NULL"));
        
        return dto;
    }

    private ViviendaDto convertirADto(Vivienda vivienda) {
        ViviendaDto dto = new ViviendaDto();
        
        dto.setId(vivienda.getId());
        dto.setTipoVivienda(vivienda.getTipoVivienda());
        dto.setCalle(vivienda.getCalle());
        dto.setPrecioMensual(vivienda.getPrecioMensual());
        dto.setNumero(vivienda.getNumero());
        dto.setComunidad(vivienda.getComunidad());
        dto.setProvincia(vivienda.getProvincia());
        dto.setMunicipio(vivienda.getMunicipio());
        dto.setDescripcion(vivienda.getDescripcion());
        dto.setNumeroHabitaciones(vivienda.getNumeroHabitaciones());
        dto.setNombre(vivienda.getNombre());
        dto.setFotos(vivienda.getFotos());
        dto.setUltimaEdicion(vivienda.getUltimaEdicion());
        dto.setFechaPublicacion(vivienda.getFechaPublicacion());
        
        if (vivienda.getResidentes() != null && !vivienda.getResidentes().isEmpty()) {
            List<EstudianteDto> residentesDto = vivienda.getResidentes().stream()
                    .map(this::convertirEstudianteADto)
                    .collect(Collectors.toList());
            dto.setResidentes(residentesDto);
        } else {
            dto.setResidentes(new ArrayList<>());
        }
        
        if (vivienda.getAnunciante() != null) {
            AnuncianteDto anuncianteDto = new AnuncianteDto();
            anuncianteDto.setId(vivienda.getAnunciante().getId());
            anuncianteDto.setNombre(vivienda.getAnunciante().getNombre());
            anuncianteDto.setEmail(vivienda.getAnunciante().getEmail());
            anuncianteDto.setTelefono(vivienda.getAnunciante().getTelefono());
            
            dto.setAnunciante(anuncianteDto);
            
            dto.setAnuncianteId(vivienda.getAnunciante().getId());
            dto.setAnuncianteNombre(vivienda.getAnunciante().getNombre());
            dto.setAnuncianteEmail(vivienda.getAnunciante().getEmail());
            dto.setAnuncianteTelefono(vivienda.getAnunciante().getTelefono());
        } else {
            System.err.println("WARNING: Vivienda " + vivienda.getId() + " no tiene anunciante asignado");
        }
        
        System.out.println("=== DEBUG RESIDENTES ===");
        System.out.println("Vivienda ID: " + vivienda.getId());
        System.out.println("Residentes en entity: " + (vivienda.getResidentes() != null ? vivienda.getResidentes().size() : "NULL"));
        System.out.println("Residentes en DTO: " + (dto.getResidentes() != null ? dto.getResidentes().size() : "NULL"));
        
        return dto;
    }

    private EstudianteDto convertirEstudianteADto(Estudiante estudiante) {
        EstudianteDto dto = new EstudianteDto();
        dto.setId(estudiante.getId());
        dto.setNombre(estudiante.getNombre());
        dto.setEmail(estudiante.getEmail());
        
        System.out.println("Convirtiendo estudiante: " + estudiante.getNombre() + " (ID: " + estudiante.getId() + ")");
        
        return dto;
    }
}