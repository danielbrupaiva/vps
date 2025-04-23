package com.bootoolz.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ResourcesController {
    @GetMapping("/resources")
    public String Resources() {
        return "resources";
    }
}
