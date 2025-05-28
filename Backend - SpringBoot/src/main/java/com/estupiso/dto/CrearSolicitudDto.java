
package com.estupiso.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class CrearSolicitudDto {
    @NotNull
    private Integer viviendaId;

    private String mensaje;
}