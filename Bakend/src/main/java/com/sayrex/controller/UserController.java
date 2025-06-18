package com.sayrex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.sayrex.model.Usuarios;
import com.sayrex.repository.UserRepository;

@RestController
//*Permite todo (menos cookies seguras)	Desarrollo*/
@CrossOrigin(origins = "*")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/usuario")
    Usuarios newUser(@RequestBody Usuarios newUser){
        return userRepository.save(newUser);
    }
    
    @GetMapping("/usuarios")
    List<Usuarios> getAllUsuarios(){
        return userRepository.findAll();
    }    
}
