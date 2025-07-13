package com.sayrex.backend.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.sayrex.backend.dto.RegisterRequest;
import com.sayrex.backend.model.Usuario;
import com.sayrex.backend.repository.UsuarioRepository;
import com.sayrex.backend.service.UsuarioService;

@Service
public class UsuarioServiceImpl implements UsuarioService {

    private final UsuarioRepository usuarioRepository;
    private final PasswordEncoder passwordEncoder;

    public UsuarioServiceImpl(UsuarioRepository usuarioRepository, PasswordEncoder passwordEncoder) {
        this.usuarioRepository = usuarioRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public boolean autenticarUsuario(String correo, String contrasena) {
        Optional<Usuario> usuario = usuarioRepository.findByCorreo(correo);
        return usuario.isPresent() && passwordEncoder.matches(contrasena, usuario.get().getContrasenaHash());
    }

    @Override
    public void registrarUsuario(RegisterRequest request) {
        Usuario usuario = new Usuario();
        usuario.setNombre(request.getNombre());
        usuario.setCorreo(request.getCorreo());
        usuario.setContrasenaHash(passwordEncoder.encode(request.getContrasena()));
        usuarioRepository.save(usuario);
    }

    @Override
    public List<Usuario> listarUsuariosPorRol(String nombreRol) {
        return usuarioRepository.findByRol(nombreRol.toUpperCase());
    }
}
