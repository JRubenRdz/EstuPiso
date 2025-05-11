package com.estupiso;

import com.estupiso.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class EstupisoApplication implements CommandLineRunner {

	@Autowired
	private AdminService adminService;

	public static void main(String[] args) {
		SpringApplication.run(EstupisoApplication.class, args);
	}

	public void run(String... args) throws Exception {
		// Invocar el método para crear el administrador por defecto si no existe
		adminService.adminPorDefecto();
	}

}
