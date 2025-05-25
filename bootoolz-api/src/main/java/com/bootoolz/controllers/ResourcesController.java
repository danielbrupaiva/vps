package com.bootoolz.controllers;

import com.bootoolz.entities.Message;
import com.bootoolz.exceptions.NotImplemented;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class ResourcesController {

    @GetMapping("/")
    public Message getRoot() {
       return new Message("bootoolz api entry point");
    }

    @GetMapping("/resources")
    public Message getResources() {
        return new Message("message");
    }

    @GetMapping("/users")
    public void getUsers() {
        throw new NotImplemented("Not implemented yet");
    }
}
