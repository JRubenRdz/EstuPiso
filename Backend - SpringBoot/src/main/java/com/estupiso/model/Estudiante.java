package com.estupiso.model;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Estudiante extends Actor {

    @ManyToOne(optional = true, fetch = FetchType.LAZY)
    @JoinColumn(name = "vivienda_id", nullable = true)
    private Vivienda vivienda;

}
