package com.estupiso.controller;

import com.estupiso.dto.ComunidadDto;
import com.estupiso.dto.ProvinciaDto;
import com.estupiso.service.ComunidadService;
import com.estupiso.service.ProvinciaService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@Tag(name = "Ubicacion", description = "Endpoints para la consulta de comunidades, provincias y municipios")
public class UbicacionController {

    @Autowired
    private ComunidadService comunidadService;

    @Autowired
    private ProvinciaService provinciaService;


    @GetMapping("/comunidades")
    @Operation(summary = "Listar todas las comunidades (solo nombres)")
    public ResponseEntity<List<ComunidadDto>> findAllComunidades() {
        return ResponseEntity.ok(comunidadService.findAllSinProvincias());
    }

    @GetMapping("/provincias/comunidad/{comunidadId}")
    @Operation(summary = "Obtener provincias por comunidad")
    public ResponseEntity<List<ProvinciaDto>> findProvinciasByComunidad(@PathVariable int comunidadId) {
        return ResponseEntity.ok(provinciaService.findByComunidadId(comunidadId));
    }

}
