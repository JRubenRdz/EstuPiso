package com.estupiso.service;

import com.estupiso.dto.CrearSolicitudDto;
import com.estupiso.dto.SolicitudViviendaDto;
import com.estupiso.model.*;
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

    // Crear solicitud
    public SolicitudViviendaDto crearSolicitud(Integer estudianteId, CrearSolicitudDto dto) {
        // Verificar que no existe solicitud pendiente
        Optional<SolicitudVivienda> existente = solicitudRepository
                .findByEstudianteIdAndViviendaIdAndEstado(estudianteId, dto.getViviendaId(), EstadoSolicitud.PENDIENTE);

        if (existente.isPresent()) {
            throw new RuntimeException("Ya tienes una solicitud pendiente para esta vivienda");
        }

        Estudiante estudiante = estudianteRepository.findById(estudianteId)
                .orElseThrow(() -> new RuntimeException("Estudiante no encontrado"));

        Vivienda vivienda = viviendaRepository.findById(dto.getViviendaId())
                .orElseThrow(() -> new RuntimeException("Vivienda no encontrada"));

        SolicitudVivienda solicitud = new SolicitudVivienda();
        solicitud.setEstudiante(estudiante);
        solicitud.setVivienda(vivienda);
        solicitud.setMensaje(dto.getMensaje());
        solicitud.setEstado(EstadoSolicitud.PENDIENTE);
        solicitud.setFechaSolicitud(LocalDateTime.now());

        SolicitudVivienda guardada = solicitudRepository.save(solicitud);
        return convertirADto(guardada);
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
        return solicitudRepository.findByAnuncianteIdOrderByFechaSolicitudDesc(anuncianteId)
                .stream()
                .map(this::convertirADto)
                .collect(Collectors.toList());
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
}