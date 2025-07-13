package com.sayrex.backend.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.sayrex.backend.model.Usuario;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {

    // 🔍 Para buscar usuarios por rol (ya lo tienes bien)
    @Query("SELECT u FROM Usuario u JOIN u.roles r WHERE r.nombreRol = :nombreRol")
    List<Usuario> findByRol(@Param("nombreRol") String nombreRol);

    // ✅ Para login (por correo)
    Optional<Usuario> findByCorreo(String correo);
}
