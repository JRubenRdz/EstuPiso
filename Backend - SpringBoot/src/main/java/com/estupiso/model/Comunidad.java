package com.estupiso.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.util.List;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class Comunidad extends DomainEntity{

    @NotNull
    private String nombre;

    @OneToMany(mappedBy = "comunidad", cascade = CascadeType.ALL)
    private List<Provincia> provincias;
}
