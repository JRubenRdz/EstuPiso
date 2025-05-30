package com.estupiso.dto;

import lombok.Data;

@Data
public class EstudianteDto {
    private Integer id;
    private String nombre;
    private String usuario;
    private String email;
    private String fotoPerfil;
    private int viviendaId;
}
