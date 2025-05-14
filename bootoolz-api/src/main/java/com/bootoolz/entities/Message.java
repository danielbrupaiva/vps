package com.bootoolz.entities;

import lombok.*;

import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.UUID;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Message {
    private UUID uuid = UUID.randomUUID();
    private LocalDateTime timestamp = LocalDateTime.now(ZoneOffset.UTC);
    @Getter @Setter
    private String text;

    public Message(String text) {
        this.text = text;
    }
}


