package com.estupiso.security;

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
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

import java.util.List;

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

                // ADMIN
                .requestMatchers(HttpMethod.POST, "/admin").hasAuthority("ADMIN")
                .requestMatchers(HttpMethod.PUT, "/admin").hasAuthority("ADMIN")
                .requestMatchers(HttpMethod.GET, "/admin/user/{usuario}").hasAuthority("ADMIN")
                .requestMatchers(HttpMethod.DELETE, "/admin").hasAuthority("ADMIN")

                // ANUNCIANTE
                .requestMatchers(HttpMethod.POST, "/anunciante").permitAll()
                .requestMatchers(HttpMethod.PUT, "/anunciante").hasAuthority("ANUNCIANTE")
                .requestMatchers(HttpMethod.GET, "/anunciante/all").hasAuthority("ADMIN")
                .requestMatchers(HttpMethod.GET, "/anunciante/{id}").hasAuthority("ANUNCIANTE")
                .requestMatchers(HttpMethod.DELETE, "/anunciante").hasAuthority("ANUNCIANTE")

                // ESTUDIANTE
                .requestMatchers(HttpMethod.POST, "/estudiante").permitAll()
                .requestMatchers(HttpMethod.PUT, "/estudiante").hasAuthority("ESTUDIANTE")
                .requestMatchers(HttpMethod.GET, "/estudiante/all").hasAuthority("ADMIN")
                .requestMatchers(HttpMethod.GET, "/estudiante/{id}").hasAuthority("ESTUDIANTE")
                .requestMatchers(HttpMethod.DELETE, "/estudiante").hasAuthority("ESTUDIANTE")
                .requestMatchers(HttpMethod.GET, "/estudiante/user/{usuario}").hasAuthority("ANUNCIANTE")


                // VIVIENDA
                .requestMatchers(HttpMethod.POST, "/vivienda").hasAuthority("ANUNCIANTE")
                .requestMatchers(HttpMethod.PUT, "/vivienda").hasAuthority("ANUNCIANTE")
                .requestMatchers(HttpMethod.GET, "/vivienda/all").permitAll()
                .requestMatchers(HttpMethod.GET, "/vivienda/anunciante/{id}").permitAll()
                .requestMatchers(HttpMethod.GET, "/vivienda/{id}").permitAll()
                .requestMatchers(HttpMethod.GET, "/vivienda/buscar").permitAll()
                .requestMatchers(HttpMethod.GET, "/vivienda/{idVivienda}/residente/{idResidente}").hasAuthority("ANUNCIANTE")
                .requestMatchers(HttpMethod.DELETE, "/vivienda/{id}").hasAuthority("ANUNCIANTE")

                // SWAGGER
                .requestMatchers("/swagger-ui/**").permitAll()
                .requestMatchers("/v3/api-docs/**").permitAll()

                // OTRAS RUTAS
                .anyRequest().permitAll();

        http.addFilterBefore(JWTAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }

    @Bean
    public CorsFilter corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowedOrigins(List.of("http://localhost:4200"));
        config.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        config.setAllowedHeaders(List.of("Authorization", "Content-Type"));
        config.setAllowCredentials(true);
        source.registerCorsConfiguration("/**", config);
        return new CorsFilter(source);
    }
}
