package com.estupiso.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.Getter;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProvinciaDto {
    private int id;
    private String nombre;
    private int comunidadId;
    private String comunidadNombre;

}
