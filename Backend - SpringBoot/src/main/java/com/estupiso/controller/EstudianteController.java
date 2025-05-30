package com.estupiso.controller;

import com.estupiso.dto.EstudianteDto;
import com.estupiso.model.Estudiante;
import com.estupiso.service.ActorService;
import com.estupiso.service.EstudianteService;
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
@RequestMapping("/estudiante")
@Tag(name = "Estudiante", description = "Operaciones relacionadas con la gestión de Estudiantes")
public class EstudianteController {

    @Autowired
    private EstudianteService estudianteService;

    @Autowired
    private ActorService actorService;

    @PostMapping
    @Operation(summary = "Registrar un estudiante")
    @ApiResponses(value = { @ApiResponse(responseCode = "201", description = "Estudiante creado exitosamente"),
            @ApiResponse(responseCode = "400", description = "Solicitud no válida"),
            @ApiResponse(responseCode = "409", description = "El usuario ya existe")})
    public ResponseEntity<?> saveEstudiante(@RequestBody Estudiante usuario) {
        if (actorService.findByUsuario(usuario.getUsuario()).isPresent()) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("El usuario ya existe");
        } else {
            Estudiante e = estudianteService.createEstudiante(usuario);
            if (e != null) {
                return ResponseEntity.status(HttpStatus.CREATED).body("Estudiante creado exitosamente");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("No se pudo crear el estudiante");
            }
        }
    }

    @PutMapping
    @Operation(summary = "Actualizar un estudiante existente")
    @ApiResponses(value = { @ApiResponse(responseCode = "200", description = "Estudiante actualizado exitosamente"),
            @ApiResponse(responseCode = "400", description = "Solicitud no válida") })
    public void updateEstudiante(@RequestBody Estudiante estudianteU) {
        Estudiante response = estudianteService.updateEstudiante(estudianteU);
        if (response != null) {
            ResponseEntity.status(HttpStatus.OK).body("Estudiante actualizado exitosamente");
        } else {
            ResponseEntity.status(HttpStatus.NOT_FOUND).body("Estudiante no encontrado");
        }
    }

    @GetMapping("/all")
    @Operation(summary = "Listar todos los estudiantes")
    public ResponseEntity<?> findAllEstudiantes() {
        return ResponseEntity.ok(estudianteService.findAllEstudiantes());
    }

    @GetMapping("/user/{usuario}")
    @Operation(summary = "Obtener un estudiante por su usuario")
    public ResponseEntity<Estudiante> findByUsuario(@PathVariable String usuario) {
        return ResponseEntity.ok(estudianteService.findByUsuario(usuario).orElse(null));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Obtener un estudiante por su id")
    public ResponseEntity<EstudianteDto> findById(@PathVariable int id) {
        Optional<EstudianteDto> e = estudianteService.findById(id);
        if (e.isPresent()) {
            return ResponseEntity.ok(e.get());
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @DeleteMapping
    @Operation(summary = "Eliminar estudiante logeado")
    @ApiResponses(value = { @ApiResponse(responseCode = "200", description = "Estudiante eliminado exitosamente"),
            @ApiResponse(responseCode = "404", description = "Estudiante no encontrado")})
    public void deleteEstudiante() {
        if (estudianteService.deleteEstudiante()) {
            ResponseEntity.status(HttpStatus.OK).body("Estudiante eliminado exitosamente");
        } else {
            ResponseEntity.status(HttpStatus.NOT_FOUND).body("Estudiante no encontrado");
        }
    }
}