package com.estupiso.controller;

import com.estupiso.model.Anunciante;
import com.estupiso.service.ActorService;
import com.estupiso.service.AnuncianteService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
import java.util.Optional;

@RestController
@RequestMapping("/anunciante")
@Tag(name = "Anunciante", description = "Operaciones relacionadas con la gestión de Anunciantes")
public class AnuncianteController {

    @Autowired
    private AnuncianteService anuncianteService;

    @Autowired
    private ActorService actorService;

    @PostMapping
    @Operation(summary = "Registrar un anunciante")
    @ApiResponses(value = { @ApiResponse(responseCode = "201", description = "Anunciante creado exitosamente"),
            @ApiResponse(responseCode = "400", description = "Solicitud no válida"),
            @ApiResponse(responseCode = "409", description = "El usuario ya existe")})
    public ResponseEntity<String> saveAnunciante(@RequestBody Anunciante anunciante) {
        if (actorService.findByUsuario(anunciante.getUsuario()).isPresent()) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("El usuario ya existe");
        } else {
            Anunciante a = anuncianteService.createAnunciante(anunciante);
            if (a != null) {
                return ResponseEntity.status(HttpStatus.CREATED).body("Anunciante creado exitosamente");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("No se pudo crear el anunciante");
            }
        }
    }    @PutMapping
    @Operation(summary = "Actualizar un anunciante existente")
    @ApiResponses(value = { @ApiResponse(responseCode = "200", description = "Anunciante actualizado exitosamente"),
            @ApiResponse(responseCode = "400", description = "Solicitud no válida") })
    public ResponseEntity<String> updateAnunciante(@RequestBody Anunciante anuncianteU) {
        Anunciante update = anuncianteService.updateAnunciante(anuncianteU);
        if (update != null) {
            return ResponseEntity.status(HttpStatus.OK).body("Anunciante actualizado exitosamente");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Anunciante no encontrado");
        }
    }

    @GetMapping("/all")
    @Operation(summary = "Listar todos los anunciantes")
    public ResponseEntity<?> findAllAnunciantes() {
        return ResponseEntity.ok(anuncianteService.findAllAnunciantes());
    }

    @GetMapping("/user/{usuario}")
    @Operation(summary = "Obtener un anunciante por su usuario")
    public ResponseEntity<Anunciante> findByUsuario(@PathVariable String usuario) {
        return ResponseEntity.ok(anuncianteService.findByUsuario(usuario).orElse(null));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Obtener un anunciante por su id")
    public ResponseEntity<Anunciante> userLogin(@PathVariable int id) {
        Optional<Anunciante> a = anuncianteService.findById(id);
        if (a.isPresent()) {
            return ResponseEntity.ok(a.get());
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }    @DeleteMapping
    @Operation(summary = "Eliminar un anunciante")
    @ApiResponses(value = { 
        @ApiResponse(responseCode = "200", description = "Anunciante eliminado exitosamente"),
        @ApiResponse(responseCode = "400", description = "No se puede eliminar: viviendas con residentes"),
        @ApiResponse(responseCode = "404", description = "Anunciante no encontrado")
    })
    public ResponseEntity<String> deleteAnunciante() {
        try {
            if (anuncianteService.deleteAnunciante()) {
                return ResponseEntity.status(HttpStatus.OK)
                    .body("Anunciante eliminado exitosamente junto con todas sus viviendas, fotos y solicitudes");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("Anunciante no encontrado");
            }
        } catch (RuntimeException e) {
            // Capturar errores de validación (ej: viviendas con residentes)
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body("Error al eliminar anunciante: " + e.getMessage());
        } catch (Exception e) {
            // Capturar otros errores inesperados
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Error interno del servidor al eliminar anunciante");
        }
    }

}