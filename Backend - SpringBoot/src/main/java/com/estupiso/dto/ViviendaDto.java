package com.estupiso.dto;

import com.estupiso.model.Estudiante;
import com.estupiso.model.FotoVivienda;
import com.estupiso.model.TiposVivienda;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class ViviendaDto {

    private int id;
    private String nombre;
    private String comunidad;
    private String provincia;
    private String municipio;
    private String calle;
    private String numero;
    private String descripcion;
    private int precioMensual;
    private TiposVivienda tipoVivienda;
    private int numeroHabitaciones;
    private LocalDateTime fechaPublicacion;
    private LocalDateTime ultimaEdicion;
    private int anuncianteId;
    private String anuncianteNombre;
    private String anuncianteEmail;
    private String anuncianteTelefono;

    private List<FotoVivienda> fotos;
    private List<Estudiante> residentes;
}
