package com.bootoolz.controllers;

import com.bootoolz.entities.Message;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ResourcesController {
    @RequestMapping("/resources")
    public Message getResources() {
        return new Message("resources");
    }
}
