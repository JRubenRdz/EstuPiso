package com.estupiso.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MunicipioDto {
    private int id;
    private int codMunicipio;
    private int dc;
    private String nombre;
    private int provinciaId;
    private String provinciaNombre;
}
