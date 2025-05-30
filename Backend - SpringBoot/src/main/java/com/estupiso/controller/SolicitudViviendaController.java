package com.estupiso.controller;

import com.estupiso.dto.CrearSolicitudDto;
import com.estupiso.dto.SolicitudViviendaDto;
import com.estupiso.model.EstadoSolicitud;
import com.estupiso.service.SolicitudViviendaService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/solicitudes")
@CrossOrigin(origins = "*")
public class SolicitudViviendaController {

    @Autowired
    private SolicitudViviendaService solicitudService;

    // Crear solicitud (estudiante)
    @PostMapping("/crear/{estudianteId}")
    public ResponseEntity<SolicitudViviendaDto> crearSolicitud(
            @PathVariable Integer estudianteId,
            @Valid @RequestBody CrearSolicitudDto dto) {

        SolicitudViviendaDto solicitud = solicitudService.crearSolicitud(estudianteId, dto);
        return ResponseEntity.ok(solicitud);
    }

    // Obtener solicitudes del estudiante
    @GetMapping("/estudiante/{estudianteId}")
    public ResponseEntity<List<SolicitudViviendaDto>> obtenerSolicitudesEstudiante(@PathVariable Integer estudianteId) {
        List<SolicitudViviendaDto> solicitudes = solicitudService.obtenerSolicitudesEstudiante(estudianteId);
        return ResponseEntity.ok(solicitudes);
    }

    // Obtener solicitudes para el anunciante
    @GetMapping("/anunciante/{anuncianteId}")
    public ResponseEntity<List<SolicitudViviendaDto>> obtenerSolicitudesAnunciante(@PathVariable Integer anuncianteId) {
        List<SolicitudViviendaDto> solicitudes = solicitudService.obtenerSolicitudesAnunciante(anuncianteId);
        return ResponseEntity.ok(solicitudes);
    }

    // Aceptar solicitud
    @PutMapping("/{solicitudId}/aceptar/{anuncianteId}")
    public ResponseEntity<SolicitudViviendaDto> aceptarSolicitud(
            @PathVariable Integer solicitudId,
            @PathVariable Integer anuncianteId,
            @RequestBody(required = false) Map<String, String> respuesta) {

        String mensaje = respuesta != null ? respuesta.get("respuesta") : null;
        SolicitudViviendaDto solicitud = solicitudService.responderSolicitud(
                solicitudId, anuncianteId, EstadoSolicitud.ACEPTADA, mensaje);
        return ResponseEntity.ok(solicitud);
    }

    // Rechazar solicitud
    @PutMapping("/{solicitudId}/rechazar/{anuncianteId}")
    public ResponseEntity<SolicitudViviendaDto> rechazarSolicitud(
            @PathVariable Integer solicitudId,
            @PathVariable Integer anuncianteId,
            @RequestBody(required = false) Map<String, String> respuesta) {

        String mensaje = respuesta != null ? respuesta.get("respuesta") : null;
        SolicitudViviendaDto solicitud = solicitudService.responderSolicitud(
                solicitudId, anuncianteId, EstadoSolicitud.RECHAZADA, mensaje);
        return ResponseEntity.ok(solicitud);
    }

    // Cancelar solicitud (estudiante)
    @PutMapping("/{solicitudId}/cancelar/{estudianteId}")
    public ResponseEntity<Void> cancelarSolicitud(
            @PathVariable Integer solicitudId,
            @PathVariable Integer estudianteId) {

        solicitudService.cancelarSolicitud(solicitudId, estudianteId);
        return ResponseEntity.ok().build();
    }

    // Verificar si existe solicitud pendiente
    @GetMapping("/verificar/{estudianteId}/{viviendaId}")
    public ResponseEntity<Boolean> verificarSolicitudPendiente(
            @PathVariable Integer estudianteId,
            @PathVariable Integer viviendaId) {

        boolean tieneSolicitudPendiente = solicitudService.verificarSolicitudPendiente(estudianteId, viviendaId);
        return ResponseEntity.ok(tieneSolicitudPendiente);
    }

    // AÑADIR endpoint para obtener ocupación actual
    @GetMapping("/ocupacion/{viviendaId}")
    public ResponseEntity<Integer> obtenerOcupacionActual(@PathVariable Integer viviendaId) {
        try {
            int ocupacion = solicitudService.obtenerOcupacionActual(viviendaId);
            return ResponseEntity.ok(ocupacion);
        } catch (Exception e) {
            return ResponseEntity.ok(0); // Devolver 0 si hay error
        }
    }

    // MEJORAR endpoint de verificar pertenencia
    @GetMapping("/pertenece/{estudianteId}/{viviendaId}")
    public ResponseEntity<Boolean> verificarPertenenciaVivienda(
            @PathVariable Integer estudianteId,
            @PathVariable Integer viviendaId) {

        try {
            boolean pertenece = solicitudService.verificarPertenenciaVivienda(estudianteId, viviendaId);
            return ResponseEntity.ok(pertenece);
        } catch (Exception e) {
            return ResponseEntity.ok(false); // Devolver false si hay error
        }
    }

    // Eliminar estudiante de vivienda (solo anunciante propietario)
    @DeleteMapping("/eliminar-estudiante/{estudianteId}/{viviendaId}/{anuncianteId}")
    public ResponseEntity<String> eliminarEstudianteDeVivienda(
            @PathVariable Integer estudianteId,
            @PathVariable Integer viviendaId,
            @PathVariable Integer anuncianteId) {

        try {
            solicitudService.eliminarEstudianteDeVivienda(estudianteId, viviendaId, anuncianteId);
            return ResponseEntity.ok("Estudiante eliminado de la vivienda correctamente");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }
}