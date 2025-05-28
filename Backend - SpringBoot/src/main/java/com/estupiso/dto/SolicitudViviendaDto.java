package com.estupiso.dto;

import com.estupiso.model.EstadoSolicitud;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class SolicitudViviendaDto {
    private Integer id;
    private Integer estudianteId;
    private String estudianteNombre;
    private String estudianteEmail;
    private Integer viviendaId;
    private String viviendaTitulo;
    private String viviendaCalle;
    private String viviendaNumero;
    private EstadoSolicitud estado;
    private LocalDateTime fechaSolicitud;
    private LocalDateTime fechaRespuesta;
    private String mensaje;
    private String respuestaAnunciante;
}