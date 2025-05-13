package com.estupiso.controller;

import com.estupiso.model.Vivienda;
import com.estupiso.service.ViviendaService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/vivienda")
@Tag(name = "Vivienda", description = "Operaciones relacionadas con la gestión de Viviendas")
public class ViviendaController {

    @Autowired
    private ViviendaService viviendaService;

    @PostMapping
    @Operation(summary = "Crear una nueva vivienda")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Vivienda creada exitosamente"),
            @ApiResponse(responseCode = "400", description = "Solicitud no válida")
    })
    public ResponseEntity<Vivienda> createVivienda(@RequestBody Vivienda vivienda) {
        Vivienda nuevaVivienda = viviendaService.createVivienda(vivienda);
        if (nuevaVivienda != null) {
            return ResponseEntity.status(HttpStatus.CREATED).body(nuevaVivienda);
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }

    @PutMapping
    @Operation(summary = "Actualizar una vivienda existente")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Vivienda actualizada exitosamente"),
            @ApiResponse(responseCode = "404", description = "Vivienda no encontrada")
    })
    public ResponseEntity<Vivienda> updateVivienda(@RequestBody Vivienda vivienda) {
        Vivienda updatedVivienda = viviendaService.updateVivienda(vivienda);
        if (updatedVivienda != null) {
            return ResponseEntity.ok(updatedVivienda);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/all")
    @Operation(summary = "Listar todas las viviendas")
    public ResponseEntity<?> findAllViviendas() {
        return ResponseEntity.ok(viviendaService.findAllViviendas());
    }

    @GetMapping("/anunciante")
    @Operation(summary = "Obtener viviendas del anunciante actual")
    public ResponseEntity<?> findByAnunciante() {
        return ResponseEntity.ok(viviendaService.findByAnunciante());
    }

    @GetMapping("/{id}")
    @Operation(summary = "Obtener una vivienda por su id")
    public ResponseEntity<Vivienda> findById(@PathVariable int id) {
        Optional<Vivienda> vivienda = viviendaService.findById(id);
        return vivienda.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/buscar")
    @Operation(summary = "Buscar viviendas con filtros")
    public ResponseEntity<Page<Vivienda>> buscarViviendas(
            @RequestParam(required = false) String comunidad,
            @RequestParam(required = false) String provincia,
            @RequestParam(required = false) String municipio,
            @RequestParam(required = false) String nombre,
            @RequestParam(defaultValue = "false") boolean soloDisponibles,
            @RequestParam(required = false) String direccion,
            @RequestParam(defaultValue = "0") int pagina,
            @RequestParam(defaultValue = "10") int tamañoPagina) {
        
        Page<Vivienda> resultados = viviendaService.buscarViviendas(
                comunidad, provincia, municipio, nombre, 
                soloDisponibles, direccion, pagina, tamañoPagina);
        return ResponseEntity.ok(resultados);
    }

    @PostMapping("/{idVivienda}/residente/{idResidente}")
    @Operation(summary = "Añadir un residente a una vivienda")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Residente añadido exitosamente"),
            @ApiResponse(responseCode = "404", description = "Vivienda o residente no encontrado")
    })
    public ResponseEntity<Vivienda> añadirResidente(
            @PathVariable int idVivienda,
            @PathVariable int idResidente) {
        Vivienda vivienda = viviendaService.añadirResidente(idVivienda, idResidente);
        if (vivienda != null) {
            return ResponseEntity.ok(vivienda);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Eliminar una vivienda")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Vivienda eliminada exitosamente"),
            @ApiResponse(responseCode = "404", description = "Vivienda no encontrada")
    })
    public ResponseEntity<Void> deleteVivienda(@PathVariable int id) {
        if (viviendaService.deleteVivienda(id)) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}