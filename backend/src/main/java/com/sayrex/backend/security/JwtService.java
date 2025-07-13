package com.sayrex.backend.security;

import com.sayrex.backend.config.JwtProperties;
import org.springframework.stereotype.Service;

@Service
public class JwtService {

    private final JwtProperties jwtProperties;

    public JwtService(JwtProperties jwtProperties) {
        this.jwtProperties = jwtProperties;
    }

    public void ejemploUso() {
        String clave = jwtProperties.getSecret();
        Long tiempo = jwtProperties.getExpiration();
        System.out.println("Clave JWT: " + clave);
        System.out.println("Expira en: " + tiempo + " ms");
    }
}
