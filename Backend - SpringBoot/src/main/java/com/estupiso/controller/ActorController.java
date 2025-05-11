package com.estupiso.controller;

import com.estupiso.model.Actor;
import com.estupiso.model.ActorLogin;
import com.estupiso.security.JWTUtils;
import com.estupiso.service.ActorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
public class ActorController {

    @Autowired
    private JWTUtils jwtUtils;

    @Autowired
    private ActorService actorService;

    @Autowired
    private AuthenticationManager authenticationManager;


    @PostMapping("/login")
    public ResponseEntity<Map<String, String>> login(@RequestBody ActorLogin actorLogin) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(actorLogin.getUsername(), actorLogin.getPassword()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String token = jwtUtils.generateToken(authentication);
        Map<String, String> response = new HashMap<>();
        response.put("token", token);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/userLogin")
    public ResponseEntity<Actor> login() {
        Actor a = jwtUtils.userLogin();
        if (a == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        return ResponseEntity.ok(a);
    }

    @GetMapping("/actorExiste/{username}")
    public ResponseEntity<Boolean> checkUserExists(@PathVariable String username) {
        boolean exists = actorService.findByUsuario(username).isPresent();
        return ResponseEntity.ok(exists);
    }
}
