package com.company;

public class Message {
    private String sender;
    private String content;

    public Message(String sender, String message) {
        this.sender = sender;
        this.content = message;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
