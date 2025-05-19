package com.estupiso.controller;

import com.estupiso.model.Comunidad;
import com.estupiso.model.Municipio;
import com.estupiso.model.Provincia;
import com.estupiso.service.ComunidadService;
import com.estupiso.service.MunicipioService;
import com.estupiso.service.ProvinciaService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@Tag(name = "Anunciante", description = "Endpoints para la consulta de comunidades, provincias y municipios")
public class UbicacionController {

    @Autowired
    private ComunidadService comunidadService;

    @Autowired
    private ProvinciaService provinciaService;

    @Autowired
    private MunicipioService municipioService;

    @GetMapping("/comunidades")
    @Operation(summary = "Listar todos las comunidades")
    public ResponseEntity<List<Comunidad>> findAllComunidades() {
        return ResponseEntity.ok(comunidadService.findAll());
    }

    @GetMapping("/provincias")
    @Operation(summary = "Listar todas las provincias")
    public ResponseEntity<List<Provincia>> findAllProvincias() {
        return ResponseEntity.ok(provinciaService.findAll());
    }

    @GetMapping("/municipios")
    @Operation(summary = "Listar todos los municipios")
    public ResponseEntity<List<Municipio>> findAllMunicipios() {
        return ResponseEntity.ok(municipioService.findAll());
    }

}
