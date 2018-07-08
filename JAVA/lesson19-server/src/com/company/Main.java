package com.company;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Main {

    public static void main(String[] args) {
        ServerSocket serverSocket = null;
        try {
            serverSocket = new ServerSocket(3000);
            List<String> messages = new ArrayList<>();
            Map<String,String> users=new HashMap<>();
            while (true) {
                System.out.println("waiting for incoming client");
                Socket clientSocket = serverSocket.accept();
                System.out.println("client connected");
                Thread clientThread = new ClientThread(clientSocket, messages,users);
                clientThread.start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if(serverSocket != null){
                try {
                    serverSocket.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}