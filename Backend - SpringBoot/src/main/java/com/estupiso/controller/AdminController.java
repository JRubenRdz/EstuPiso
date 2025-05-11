package com.estupiso.controller;

import com.estupiso.model.Admin;
import com.estupiso.service.AdminService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/admin")
@Tag(name = "Admin", description = "Operaciones relacionadas con la gestión de los administradores")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @PutMapping
    @Operation(summary = "Actualizar un administrador existente")
    @ApiResponses(value = { @ApiResponse(responseCode = "200", description = "Administrador actualizado exitosamente"),
            @ApiResponse(responseCode = "404", description = "Administrador no encontrado"),
            @ApiResponse(responseCode = "400", description = "Solicitud inválida") })
    public void updateAdmin(@RequestBody Admin updatedAdmin) {
        Admin response = adminService.updateAdmin(updatedAdmin);
        if (response != null) {
            ResponseEntity.status(HttpStatus.OK).body("Administrador actualizado exitosamente");
        } else {
            ResponseEntity.status(HttpStatus.NOT_FOUND).body("Administrador no encontrado");
        }
    }

    @PostMapping
    @ApiResponses(value = { @ApiResponse(responseCode = "201", description = "Administrador creado exitosamente"),
            @ApiResponse(responseCode = "400", description = "Solicitud inválida"),
            @ApiResponse(responseCode = "409", description = "El username ya está en uso") })
    public void saveAdmin(@RequestBody Admin admin) {
        if (adminService.findByUsuario(admin.getUsuario()).isPresent()) {
            ResponseEntity.status(HttpStatus.BAD_REQUEST).body("El username ya está en uso");
        } else {
            Admin a = adminService.createAdmin(admin);
            if (a != null) {
                ResponseEntity.status(HttpStatus.CREATED).body("Administrador creado exitosamente");
            } else {
                ResponseEntity.status(HttpStatus.BAD_REQUEST).body("No se pudo crear el administrador");
            }
        }
    }


}
