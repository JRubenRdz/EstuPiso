package com.estupiso.controller;

import com.estupiso.model.Anunciante;
import com.estupiso.repository.AnuncianteRepository;
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

@RestController
@RequestMapping("/anunciante")
@Tag(name = "Anunciante", description = "Operaciones relacionadas con la gestión de Anunciantes")
public class AnuncianteController {

    @Autowired
    private AnuncianteService anuncianteService;

    @PostMapping
    @Operation(summary = "Registrar un anunciante")
    @ApiResponses(value = { @ApiResponse(responseCode = "201", description = "Anunciante creado exitosamente"),
            @ApiResponse(responseCode = "400", description = "Solicitud no válida"),
            @ApiResponse(responseCode = "409", description = "El usuario ya existe")})
    public void saveAnunciante(@RequestBody Anunciante anunciante) {
        if (anuncianteService.findByUsuario(anunciante.getUsuario()).isPresent()) {
            ResponseEntity.status(HttpStatus.BAD_REQUEST).body("El usuario ya existe");
        } else {
            Anunciante a = anuncianteService.createAnunciante(anunciante);
            if (a != null) {
                ResponseEntity.status(HttpStatus.CREATED).body("Anunciante creado exitosamente");
            } else {
                ResponseEntity.status(HttpStatus.BAD_REQUEST).body("No se pudo crear el anunciante");
            }
        }
    }

    @PutMapping
    @Operation(summary = "Actualizar un anunciante existente")
    @ApiResponses(value = { @ApiResponse(responseCode = "200", description = "Anunciante actualizado exitosamente"),
            @ApiResponse(responseCode = "404", description = "Anunciante no encontrado"),
            @ApiResponse(responseCode = "400", description = "Solicitud no válida") })
    public void updateAnunciante(@RequestBody Anunciante anuncianteU) {
        Anunciante response = anuncianteService.updateAnunciante(anuncianteU);
        if (response != null) {
            ResponseEntity.status(HttpStatus.OK).body("anunciante actualizado exitosamente");
        } else {
            ResponseEntity.status(HttpStatus.NOT_FOUND).body("anunciante no encontrado");
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
    }

    @DeleteMapping
    @Operation(summary = "Eliminar un anunciante")
    @ApiResponses(value = { @ApiResponse(responseCode = "200", description = "Anunciante eliminado exitosamente"),
            @ApiResponse(responseCode = "404", description = "Anunciante no encontrado")})
    public void deleteAnunciante() {
        if (anuncianteService.deleteAnunciante()) {
            ResponseEntity.status(HttpStatus.OK).body("Anunciante eliminado exitosamente");
        } else {
            ResponseEntity.status(HttpStatus.NOT_FOUND).body("Anunciante no encontrado");
        }
    }



}
