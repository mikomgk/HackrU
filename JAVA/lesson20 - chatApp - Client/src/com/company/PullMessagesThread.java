package com.company;

import java.util.List;

public class PullMessagesThread extends Thread {
    private int from = 0;
    private boolean go = true;
    private User user;
    private List<Message> messages;

    public PullMessagesThread(User user, List<Message> messages) {
        this.user = user;
        this.messages = messages;
    }

    public int getFrom() {
        return from;
    }

    public void setFrom(int from) {
        this.from = from;
    }

    public boolean isGo() {
        return go;
    }

    public void setGo(boolean go) {
        this.go = go;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Message> getMessages() {
        return messages;
    }

    public void setMessages(List<Message> messages) {
        this.messages = messages;
    }

    @Override
    public void run() {
        while (go) {
            from = messages.size();
            if (Main.pullRequest(user,from,messages))
                printNewMessages();
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    private void printNewMessages() {
        for (int i = from; i < messages.size(); i++) {
            System.out.println(messages.get(i));
        }
    }

    public void stopPulling() {
        go = false;
        interrupt();
    }
}
