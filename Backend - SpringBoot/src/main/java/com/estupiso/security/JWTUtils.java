package com.estupiso.security;

import java.util.Date;
import java.util.Optional;

import com.estupiso.model.Roles;
import com.estupiso.service.AnuncianteService;
import com.estupiso.service.EstudianteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import jakarta.servlet.http.HttpServletRequest;
import com.estupiso.model.Actor;
import com.estupiso.service.ActorService;
import com.estupiso.service.AdminService;

@Component
public class JWTUtils {
    private static final String JWT_FIRMA = "manyWorker123";
    private static final long DURACION_TOKEN = 86400000;

    @Autowired
    @Lazy
    private ActorService actorService;

    @Autowired
    @Lazy
    private EstudianteService estudianteService;

    @Autowired
    @Lazy
    private AdminService adminService;

    @Autowired
    @Lazy
    private AnuncianteService anuncianteService;

    public static String getToken(HttpServletRequest request) {
        String tokenBearer = request.getHeader("Authorization");
        if (StringUtils.hasText(tokenBearer) && tokenBearer.startsWith("Bearer ")) {
            return tokenBearer.substring(7);
        }
        return null;
    }

    public static boolean validateToken(String token) {
        try {
            Jwts.parser().setSigningKey(JWT_FIRMA).parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            throw new AuthenticationCredentialsNotFoundException("JWT ha experido o no es valido");
        }
    }

    public static String getUsernameOfToken(String token) {
        return Jwts.parser().setSigningKey(JWT_FIRMA).parseClaimsJws(token).getBody().getSubject();
    }

    public String generateToken(Authentication authentication) {
        String username = authentication.getName();
        Date fechaActual = new Date();
        Date fechaExpiracion = new Date(fechaActual.getTime() + DURACION_TOKEN);
        String rol = authentication.getAuthorities().iterator().next().getAuthority();

        // Obtener el ID según el rol
        int id;
        switch (rol) {
            case "ESTUDIANTE":
                id = estudianteService.findByUsuario(username)
                        .map(e -> e.getId())
                        .orElse(null);
                break;
            case "ANUNCIANTE":
                id = anuncianteService.findByUsuario(username)
                        .map(a -> a.getId())
                        .orElse(null);
                break;
            case "ADMIN":
                id = adminService.findByUsuario(username)
                        .map(a -> a.getId())
                        .orElse(null);
                break;
            default:
                id = 0;
                break;
        }

        // Construir el token, añadiendo el claim "id"
        String token = Jwts.builder()
                .setSubject(username)
                .setIssuedAt(fechaActual)
                .setExpiration(fechaExpiracion)
                .claim("rol", rol)
                .claim("id", id)
                .signWith(SignatureAlgorithm.HS512, JWT_FIRMA).compact();
        return token;
    }

    public <T extends Actor> T userLogin() {
        String usuario = SecurityContextHolder.getContext().getAuthentication().getName();
        if (StringUtils.isEmpty(usuario)) {
            return null;
        }

        Optional<Actor> actorO = actorService.findByUsuario(usuario);
        if (actorO.isEmpty()) {
            return null;
        }

        Actor actor = actorO.get();
        return switch (actor.getRol()) {
            case ESTUDIANTE -> (T) estudianteService.findByUsuario(usuario).orElse(null);
            case ADMIN -> (T) adminService.findByUsuario(usuario).orElse(null);
            case ANUNCIANTE -> (T) anuncianteService.findByUsuario(usuario).orElse(null);
            default -> null;
        };
    }

}