package com.estupiso.security;

import com.estupiso.model.Roles;
import org.apache.tomcat.util.http.parser.HttpParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration {

    @Autowired
    private JWTAuthenticationFilter JWTAuthenticationFilter;

    @Bean
    AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.cors().and()
                .csrf().disable()
                .authorizeHttpRequests()
                // LOGIN
                .requestMatchers("/login").permitAll()
                .requestMatchers("/userLogin").permitAll()
                .requestMatchers("/actorExiste/**").hasAuthority("ADMIN")

                // ANUNCIANTE
                .requestMatchers(HttpMethod.POST, "/anunciante").permitAll()
                .requestMatchers(HttpMethod.PUT, "/anunciante").hasAuthority("ANUNCIANTE")
                .requestMatchers(HttpMethod.GET, "/anunciante/all").hasAuthority("ADMIN")
                .requestMatchers(HttpMethod.GET, "/anunciante/user/{usuario}").hasAuthority("ADMIN")
                .requestMatchers(HttpMethod.GET, "/anunciante/{id}").permitAll()
                .requestMatchers(HttpMethod.DELETE, "/anunciante").hasAuthority("ANUNCIANTE")

                // ESTUDIANTE
                .requestMatchers(HttpMethod.POST, "/estudiante").permitAll()
                .requestMatchers(HttpMethod.PUT, "/estudiante").hasAuthority("ESTUDIANTE")
                .requestMatchers(HttpMethod.GET, "/estudiante/all").hasAuthority("ADMIN")
                .requestMatchers(HttpMethod.GET, "/estudiante/{id}").permitAll()
                .requestMatchers(HttpMethod.DELETE, "/estudiante").hasAuthority("ESTUDIANTE")
                //.requestMatchers(HttpMethod.GET, "/estudiante/user/{usuario}").hasAuthority("ADMIN")

                // VIVIENDA
                .requestMatchers(HttpMethod.POST, "/vivienda").hasAuthority("ANUNCIANTE")
                .requestMatchers(HttpMethod.PUT, "/vivienda").hasAuthority("ANUNCIANTE")
                .requestMatchers(HttpMethod.GET, "/vivienda/all").hasAnyAuthority("ADMIN", "ANUNCIANTE", "ESTUDIANTE")
                .requestMatchers(HttpMethod.GET, "/vivienda/anunciante").hasAuthority("ANUNCIANTE")
                .requestMatchers(HttpMethod.GET, "/vivienda/{id}").permitAll()
                .requestMatchers(HttpMethod.GET, "/vivienda/buscar").hasAnyAuthority("ADMIN", "ANUNCIANTE", "ESTUDIANTE")
                .requestMatchers(HttpMethod.POST, "/vivienda/{idVivienda}/residente/{idResidente}").hasAuthority("ANUNCIANTE")
                .requestMatchers(HttpMethod.DELETE, "/vivienda/{id}").hasAuthority("ANUNCIANTE")

                // SWAGGER
                .requestMatchers("/swagger-ui/**").permitAll()
                .requestMatchers("/v3/api-docs/**").permitAll()

                // OTRAS RUTAS
                .anyRequest().permitAll();

        http.addFilterBefore(JWTAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }
}
