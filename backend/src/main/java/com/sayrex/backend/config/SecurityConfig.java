package com.sayrex.backend.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/auth/login", "/api/auth/register").permitAll()  // ✅ Permite login y registro
                .requestMatchers("/api/usuarios/rol/{nombreRol}").permitAll()  // ✅ Permite login y registro
                .requestMatchers("/api/hello").permitAll()  // ✅ Permite login y registro
                .anyRequest().authenticated()                 // ❌ Bloquea el resto si no hay login
            );

        return http.build();
    }
}
