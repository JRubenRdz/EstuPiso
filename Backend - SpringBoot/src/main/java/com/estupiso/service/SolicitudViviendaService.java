package com.estupiso.service;

import com.estupiso.dto.CrearSolicitudDto;
import com.estupiso.dto.SolicitudViviendaDto;
import com.estupiso.model.*;
import com.estupiso.repository.AnuncianteRepository;
import com.estupiso.repository.EstudianteRepository;
import com.estupiso.repository.SolicitudViviendaRepository;
import com.estupiso.repository.ViviendaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Transactional
public class SolicitudViviendaService {

    @Autowired
    private SolicitudViviendaRepository solicitudRepository;

    @Autowired
    private EstudianteRepository estudianteRepository;

    @Autowired
    private ViviendaRepository viviendaRepository;

    @Autowired
    private AnuncianteRepository anuncianteRepository;

    // Crear solicitud
    public SolicitudViviendaDto crearSolicitud(Integer estudianteId, CrearSolicitudDto dto) {
        // Verificar que el estudiante existe
        Estudiante estudiante = estudianteRepository.findById(estudianteId)
                .orElseThrow(() -> new RuntimeException("Estudiante no encontrado"));

        // Verificar que la vivienda existe
        Vivienda vivienda = viviendaRepository.findById(dto.getViviendaId())
                .orElseThrow(() -> new RuntimeException("Vivienda no encontrada"));

        // AÑADIR: Verificar que el anunciante existe
        Anunciante anunciante = anuncianteRepository.findById(dto.getAnuncianteId())
                .orElseThrow(() -> new RuntimeException("Anunciante no encontrado"));

        // AÑADIR: Verificar que el anunciante es el propietario de la vivienda
        if (!vivienda.getAnunciante().getId().equals(anunciante.getId())) {
            throw new RuntimeException("El anunciante especificado no es el propietario de esta vivienda");
        }

        // Resto de verificaciones existentes...
        if (estudiante.getVivienda() != null) {
            throw new RuntimeException("Ya tienes una vivienda asignada");
        }

        // CAMBIAR de findAllByEstudianteIdAndViviendaIdAndEstado a findByEstudianteIdAndViviendaIdAndEstado
        Optional<SolicitudVivienda> solicitudPendiente = solicitudRepository
                .findByEstudianteIdAndViviendaIdAndEstado(estudianteId, dto.getViviendaId(), EstadoSolicitud.PENDIENTE);

        if (solicitudPendiente.isPresent()) {
            throw new RuntimeException("Ya tienes una solicitud pendiente para esta vivienda");
        }

        Optional<SolicitudVivienda> solicitudAceptada = solicitudRepository
                .findByEstudianteIdAndViviendaIdAndEstado(estudianteId, dto.getViviendaId(), EstadoSolicitud.ACEPTADA);

        if (solicitudAceptada.isPresent()) {
            throw new RuntimeException("Ya tienes una solicitud aceptada para esta vivienda");
        }

        int ocupacionActual = vivienda.getResidentes().size() +
                solicitudRepository.countByViviendaIdAndEstado(vivienda.getId(), EstadoSolicitud.ACEPTADA);

        if (ocupacionActual >= vivienda.getNumeroHabitaciones()) {
            throw new RuntimeException("No hay habitaciones disponibles en esta vivienda");
        }

        // Crear la solicitud
        SolicitudVivienda solicitud = new SolicitudVivienda();
        solicitud.setEstudiante(estudiante);
        solicitud.setVivienda(vivienda);
        solicitud.setAnunciante(anunciante); // AHORA usando el anunciante pasado en el DTO
        solicitud.setEstado(EstadoSolicitud.PENDIENTE);
        solicitud.setFechaSolicitud(LocalDateTime.now());

        if (dto.getMensaje() != null && !dto.getMensaje().trim().isEmpty()) {
            solicitud.setMensaje(dto.getMensaje().trim());
        }

        SolicitudVivienda solicitudGuardada = solicitudRepository.save(solicitud);
        return convertirADto(solicitudGuardada);
    }

    // Responder solicitud (aceptar/rechazar)
    public SolicitudViviendaDto responderSolicitud(Integer solicitudId, Integer anuncianteId,
                                                   EstadoSolicitud nuevoEstado, String respuesta) {
        SolicitudVivienda solicitud = solicitudRepository.findById(solicitudId)
                .orElseThrow(() -> new RuntimeException("Solicitud no encontrada"));

        // Verificar que el anunciante es el dueño de la vivienda
        if (!solicitud.getVivienda().getAnunciante().getId().equals(anuncianteId)) {
            throw new RuntimeException("No tienes permisos para responder esta solicitud");
        }

        if (solicitud.getEstado() != EstadoSolicitud.PENDIENTE) {
            throw new RuntimeException("Esta solicitud ya ha sido respondida");
        }

        solicitud.setEstado(nuevoEstado);
        solicitud.setRespuestaAnunciante(respuesta);
        solicitud.setFechaRespuesta(LocalDateTime.now());

        SolicitudVivienda actualizada = solicitudRepository.save(solicitud);
        return convertirADto(actualizada);
    }

    // Obtener solicitudes del estudiante
    public List<SolicitudViviendaDto> obtenerSolicitudesEstudiante(Integer estudianteId) {
        return solicitudRepository.findByEstudianteIdOrderByFechaSolicitudDesc(estudianteId)
                .stream()
                .map(this::convertirADto)
                .collect(Collectors.toList());
    }

    // Obtener solicitudes para el anunciante
    public List<SolicitudViviendaDto> obtenerSolicitudesAnunciante(Integer anuncianteId) {
        Optional<Anunciante> anuncianteO = anuncianteRepository.findById(anuncianteId);

        return anuncianteO.map(anunciante -> solicitudRepository.findByAnuncianteOrderByFechaSolicitudDesc(anunciante)
                .stream()
                .map(this::convertirADto)
                .collect(Collectors.toList())).orElse(null);
    }

    // Cancelar solicitud (por parte del estudiante)
    public void cancelarSolicitud(Integer solicitudId, Integer estudianteId) {
        SolicitudVivienda solicitud = solicitudRepository.findById(solicitudId)
                .orElseThrow(() -> new RuntimeException("Solicitud no encontrada"));

        if (!solicitud.getEstudiante().getId().equals(estudianteId)) {
            throw new RuntimeException("No puedes cancelar esta solicitud");
        }

        if (solicitud.getEstado() != EstadoSolicitud.PENDIENTE) {
            throw new RuntimeException("Solo se pueden cancelar solicitudes pendientes");
        }

        solicitud.setEstado(EstadoSolicitud.CANCELADA);
        solicitudRepository.save(solicitud);
    }

    // Verificar si existe solicitud pendiente
    public boolean verificarSolicitudPendiente(Integer estudianteId, Integer viviendaId) {
        Optional<SolicitudVivienda> solicitudPendiente = solicitudRepository
                .findByEstudianteIdAndViviendaIdAndEstado(estudianteId, viviendaId, EstadoSolicitud.PENDIENTE);

        return solicitudPendiente.isPresent();
    }

    // Verificar si el estudiante ya pertenece a la vivienda (tiene solicitud aceptada)
    public boolean verificarPertenenciaVivienda(Integer estudianteId, Integer viviendaId) {
        // Verificar si tiene una solicitud aceptada
        Optional<SolicitudVivienda> solicitudAceptada = solicitudRepository
                .findByEstudianteIdAndViviendaIdAndEstado(estudianteId, viviendaId, EstadoSolicitud.ACEPTADA);

        if (solicitudAceptada.isPresent()) {
            return true;
        }

        // También verificar si ya está en la lista de residentes (por si se añadió manualmente)
        // Esto requeriría una consulta adicional dependiendo de tu modelo de datos

        return false;
    }

    // AÑADIR método para obtener ocupación actual
    public int obtenerOcupacionActual(Integer viviendaId) {
        List<SolicitudVivienda> solicitudesAceptadas = solicitudRepository
                .findByViviendaIdAndEstado(viviendaId, EstadoSolicitud.ACEPTADA);

        return solicitudesAceptadas.size();
    }

    // Convertir a DTO
    private SolicitudViviendaDto convertirADto(SolicitudVivienda solicitud) {
        SolicitudViviendaDto dto = new SolicitudViviendaDto();
        dto.setId(solicitud.getId());
        dto.setEstudianteId(solicitud.getEstudiante().getId());
        dto.setEstudianteNombre(solicitud.getEstudiante().getNombre());
        dto.setEstudianteEmail(solicitud.getEstudiante().getEmail());
        dto.setViviendaId(solicitud.getVivienda().getId());
        dto.setViviendaTitulo(solicitud.getVivienda().getNombre());
        dto.setViviendaCalle(solicitud.getVivienda().getCalle());
        dto.setViviendaNumero(solicitud.getVivienda().getNumero());
        dto.setEstado(solicitud.getEstado());
        dto.setFechaSolicitud(solicitud.getFechaSolicitud());
        dto.setFechaRespuesta(solicitud.getFechaRespuesta());
        dto.setMensaje(solicitud.getMensaje());
        dto.setRespuestaAnunciante(solicitud.getRespuestaAnunciante());
        return dto;
    }

    @Transactional
    public SolicitudViviendaDto aceptarSolicitud(Integer solicitudId, Integer anuncianteId, String respuesta) {
        // Buscar la solicitud
        SolicitudVivienda solicitud = solicitudRepository.findById(solicitudId)
                .orElseThrow(() -> new RuntimeException("Solicitud no encontrada"));

        // Verificar que el anunciante es el propietario
        if (!solicitud.getVivienda().getAnunciante().getId().equals(anuncianteId)) {
            throw new RuntimeException("No tienes permisos para gestionar esta solicitud");
        }

        // Verificar que la solicitud esté pendiente
        if (solicitud.getEstado() != EstadoSolicitud.PENDIENTE) {
            throw new RuntimeException("La solicitud ya ha sido procesada");
        }

        // Verificar disponibilidad de habitaciones
        Vivienda vivienda = solicitud.getVivienda();
        int ocupacionActual = vivienda.getResidentes().size() +
                solicitudRepository.countByViviendaIdAndEstado(vivienda.getId(), EstadoSolicitud.ACEPTADA);

        if (ocupacionActual >= vivienda.getNumeroHabitaciones()) {
            throw new RuntimeException("No hay habitaciones disponibles");
        }

        // CAMBIO IMPORTANTE: Aceptar la solicitud Y asignar la vivienda al estudiante
        solicitud.setEstado(EstadoSolicitud.ACEPTADA);
        solicitud.setFechaRespuesta(LocalDateTime.now());
        if (respuesta != null && !respuesta.trim().isEmpty()) {
            solicitud.setRespuestaAnunciante(respuesta.trim());
        }

        // NUEVA LÓGICA: Asignar la vivienda al estudiante en su entidad
        Estudiante estudiante = solicitud.getEstudiante();
        estudiante.setVivienda(vivienda); // ESTO ES CLAVE
        estudianteRepository.save(estudiante); // Guardar el estudiante con la vivienda asignada

        // TAMBIÉN añadir a la lista de residentes de la vivienda
        if (!vivienda.getResidentes().contains(estudiante)) {
            vivienda.getResidentes().add(estudiante);
            viviendaRepository.save(vivienda); // Guardar la vivienda con el nuevo residente
        }

        // Guardar la solicitud
        SolicitudVivienda solicitudGuardada = solicitudRepository.save(solicitud);

        // IMPORTANTE: Rechazar automáticamente otras solicitudes pendientes del mismo estudiante para la misma vivienda
        Optional<SolicitudVivienda> otraSolicitudPendiente = solicitudRepository
                .findByEstudianteIdAndViviendaIdAndEstado(estudiante.getId(), vivienda.getId(), EstadoSolicitud.PENDIENTE);

        if (otraSolicitudPendiente.isPresent() && !otraSolicitudPendiente.get().getId().equals(solicitudId)) {
            SolicitudVivienda otraSolicitud = otraSolicitudPendiente.get();
            otraSolicitud.setEstado(EstadoSolicitud.RECHAZADA);
            otraSolicitud.setFechaRespuesta(LocalDateTime.now());
            otraSolicitud.setRespuestaAnunciante("Solicitud rechazada automáticamente - ya aceptado en otra solicitud");
            solicitudRepository.save(otraSolicitud);
        }

        return convertirADto(solicitudGuardada);
    }

    // AÑADIR método al servicio:
    @Transactional
    public void eliminarEstudianteDeVivienda(Integer estudianteId, Integer viviendaId, Integer anuncianteId) {
        // Verificar que la vivienda existe
        Vivienda vivienda = viviendaRepository.findById(viviendaId)
                .orElseThrow(() -> new RuntimeException("Vivienda no encontrada"));

        // Verificar que el anunciante es el propietario
        if (!vivienda.getAnunciante().getId().equals(anuncianteId)) {
            throw new RuntimeException("No tienes permisos para eliminar estudiantes de esta vivienda");
        }

        // Verificar que el estudiante existe
        Estudiante estudiante = estudianteRepository.findById(estudianteId)
                .orElseThrow(() -> new RuntimeException("Estudiante no encontrado"));

        // Verificar que el estudiante pertenece a esta vivienda
        if (estudiante.getVivienda() == null || !estudiante.getVivienda().getId().equals(viviendaId)) {
            throw new RuntimeException("El estudiante no pertenece a esta vivienda");
        }

        // 1. Quitar la vivienda del estudiante
        estudiante.setVivienda(null);
        estudianteRepository.save(estudiante);

        // 2. Quitar el estudiante de la lista de residentes de la vivienda
        vivienda.getResidentes().remove(estudiante);
        viviendaRepository.save(vivienda);

        // 3. Marcar como cancelada cualquier solicitud aceptada que tenga
        Optional<SolicitudVivienda> solicitudAceptadaOpt = solicitudRepository
                .findByEstudianteIdAndViviendaIdAndEstado(estudianteId, viviendaId, EstadoSolicitud.ACEPTADA);

        if (solicitudAceptadaOpt.isPresent()) {
            SolicitudVivienda solicitud = solicitudAceptadaOpt.get();
            solicitud.setEstado(EstadoSolicitud.CANCELADA);
            solicitud.setFechaRespuesta(LocalDateTime.now());
            solicitud.setRespuestaAnunciante("Eliminado de la vivienda por el anunciante");
            solicitudRepository.save(solicitud);
        }

        System.out.println("Estudiante " + estudianteId + " eliminado de la vivienda " + viviendaId + " por el anunciante " + anuncianteId);
    }
}