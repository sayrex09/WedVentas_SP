package com.sayrex.backend.controller;

import com.sayrex.backend.dto.JwtResponse;
import com.sayrex.backend.dto.LoginRequest;
import com.sayrex.backend.dto.RegisterRequest;
import com.sayrex.backend.model.Usuario;
import com.sayrex.backend.repository.UsuarioRepository;
import com.sayrex.backend.security.JwtService;
import com.sayrex.backend.service.UsuarioService;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final UsuarioService usuarioService;
    private final UsuarioRepository usuarioRepository;
    private final JwtService jwtService;

    public AuthController(
        UsuarioService usuarioService,
        UsuarioRepository usuarioRepository,
        JwtService jwtService
    ) {
        this.usuarioService = usuarioService;
        this.usuarioRepository = usuarioRepository;
        this.jwtService = jwtService;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {
        boolean autenticado = usuarioService.autenticarUsuario(request.getCorreo(), request.getContrasena());

        if (autenticado) {
            Optional<Usuario> usuario = usuarioRepository.findByCorreo(request.getCorreo());
            if (usuario.isPresent()) {
                String token = jwtService.generateToken(usuario.get().getCorreo());
                return ResponseEntity.ok(new JwtResponse(token));
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuario no encontrado");
            }
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Credenciales incorrectas");
        }
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody RegisterRequest request) {
        try {
            usuarioService.registrarUsuario(request);
            // Buscar el usuario recién registrado para emitir token
            Optional<Usuario> usuario = usuarioRepository.findByCorreo(request.getCorreo());
            if (usuario.isPresent()) {
                String token = jwtService.generateToken(usuario.get().getCorreo());
                return ResponseEntity.ok(new JwtResponse(token));
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body("Error al generar token después del registro");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Error al registrar: " + e.getMessage());
        }
    }
}
