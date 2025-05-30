package com.estupiso.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Estudiante extends Actor {

    @ManyToOne(optional = true, fetch = FetchType.LAZY)
    @JoinColumn(name = "vivienda_id", nullable = true)
    @JsonBackReference
    private Vivienda vivienda;

    // Usar JsonIgnore para evitar conflictos
    @OneToMany(mappedBy = "estudiante", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonIgnore
    private List<SolicitudVivienda> solicitudes = new ArrayList<>();
}