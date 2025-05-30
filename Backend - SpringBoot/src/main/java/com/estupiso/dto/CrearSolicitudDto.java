package com.estupiso.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class CrearSolicitudDto {
    @NotNull(message = "El ID de la vivienda es obligatorio")
    private Integer viviendaId;
    
    @NotNull(message = "El ID del anunciante es obligatorio")
    private Integer anuncianteId; // AÑADIR este campo
    
    private String mensaje;

    // Constructors
    public CrearSolicitudDto() {}

    public CrearSolicitudDto(Integer viviendaId, Integer anuncianteId, String mensaje) {
        this.viviendaId = viviendaId;
        this.anuncianteId = anuncianteId;
        this.mensaje = mensaje;
    }

    // Getters y Setters
    public Integer getViviendaId() {
        return viviendaId;
    }

    public void setViviendaId(Integer viviendaId) {
        this.viviendaId = viviendaId;
    }

    public Integer getAnuncianteId() {
        return anuncianteId;
    }

    public void setAnuncianteId(Integer anuncianteId) {
        this.anuncianteId = anuncianteId;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }
}