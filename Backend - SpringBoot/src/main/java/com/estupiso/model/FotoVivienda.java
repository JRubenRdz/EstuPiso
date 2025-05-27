package com.estupiso.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.validator.constraints.URL;

@Entity
@Data
public class FotoVivienda extends DomainEntity {

    @URL
    private String imagen;

    @ManyToOne(cascade = CascadeType.REMOVE)
    @JoinColumn(name = "vivienda_id", nullable = false)
    @JsonBackReference
    private Vivienda vivienda;

}
