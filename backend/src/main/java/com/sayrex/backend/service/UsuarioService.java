package com.sayrex.backend.service;

import java.util.List;
import com.sayrex.backend.dto.RegisterRequest;
import com.sayrex.backend.model.Usuario;

public interface UsuarioService {
    boolean autenticarUsuario(String correo, String contrasena);
    void registrarUsuario(RegisterRequest request);
    List<Usuario> listarUsuariosPorRol(String nombreRol);
}
