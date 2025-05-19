package com.bootoolz.controllers;

import com.bootoolz.entities.Message;
import com.bootoolz.exceptions.NotImplement;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ResourcesController {
    @GetMapping("/api/resources")
    public ResponseEntity<Message> getResources() {
        return new ResponseEntity<>(new Message("message"), HttpStatus.OK);
    }

    @GetMapping("/api/users")
    public ResponseEntity<Object> getUsers() {
        throw new NotImplement("Not implemented yet");
    }
}
