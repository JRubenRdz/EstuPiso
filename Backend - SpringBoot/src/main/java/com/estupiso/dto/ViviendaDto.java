package com.estupiso.dto;

import com.estupiso.model.FotoVivienda;
import com.estupiso.model.TiposVivienda;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ViviendaDto {
    private Integer id;
    private String nombre;
    private String comunidad;
    private String provincia;
    private String municipio; // CAMBIADO: Ahora es String
    private String calle;
    private String numero;
    private String descripcion;
    private int precioMensual;
    private TiposVivienda tipoVivienda;
    private int numeroHabitaciones;
    private LocalDateTime fechaPublicacion;
    private LocalDateTime ultimaEdicion;
    
    // Información del anunciante
    private Integer anuncianteId;
    private String anuncianteNombre;
    private String anuncianteEmail;
    private String anuncianteTelefono;
    private AnuncianteDto anunciante;
    
    // Residentes
    private List<EstudianteDto> residentes;
    
    // Fotos
    private List<FotoVivienda> fotos;
}