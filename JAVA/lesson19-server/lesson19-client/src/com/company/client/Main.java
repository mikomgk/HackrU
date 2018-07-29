package com.company.client;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.util.Scanner;

public class Main {

    public static final String HOST = "10.0.29.49";
    //public static final String HOST = "127.0.0.1";
    public static final int PORT = 3000;
    public static final int SEND_MESSAGE = 50;
    public static final int PULL = 51;
    public static final int OKAY = 200;
    public static final int SIGN_UP = 52;
    public static final int USER_EXIST = 300;
    public static final int WRONG_USER = 400;
    public static final int LOG_IN = 53;
    public static String user;
    public static String pass;


    public static void main(String[] args) {
        MenuOption[] welcomeMenu = {
                new MenuOption("LogIn", new MenuOption.OptionSelectedListener() {
                    @Override
                    public void optionSelected() {
                        Scanner scanner = new Scanner(System.in);
                        System.out.println("Log In");
                        System.out.println("User Name: ");
                        user = scanner.next();
                        if (user.equals("back"))
                            MenuOption.menu();
                        System.out.println("Password: ");
                        pass = scanner.next();
                        if (logIn() != OKAY)
                            optionSelected();
                        PullMessagesThread pullMessagesThread = new PullMessagesThread();
                        pullMessagesThread.start();
                        while (true) {
                            String input = scanner.next();
                            if (input.equals("exit"))
                                break;
                            sendMessage(input);
                        }
                        pullMessagesThread.stopPulling();
                    }
                }),
                new MenuOption("SignUp", new MenuOption.OptionSelectedListener() {
                    @Override
                    public void optionSelected() {
                        Scanner scanner = new Scanner(System.in);
                        System.out.println("Sign Up");
                        System.out.println("User Name: ");
                        user = scanner.next();
                        if (user.equals("back"))
                            MenuOption.menu();
                        System.out.println("Password: ");
                        pass = scanner.next();
                        if (signUp() == OKAY) {
                            System.out.println("Sign Up success");
                            MenuOption.menu();
                        }
                        System.out.println("error");
                        optionSelected();
                    }
                })
        };
        MenuOption.setMenuOptions(welcomeMenu);
        MenuOption.menu();
    }

    private static int signUp() {
        return send(null, SIGN_UP);
    }

    private static int logIn() {
        return send(null, LOG_IN);
    }

    private static int sendMessage(String message) {
        return send(message, SEND_MESSAGE);
    }

    private static int send(String message, int status) {
        Socket clientSocket = null;
        InputStream inputStream = null;
        OutputStream outputStream = null;
        try {
            clientSocket = new Socket(HOST, PORT);
            inputStream = clientSocket.getInputStream();
            outputStream = clientSocket.getOutputStream();
            outputStream.write(status);
            writeWord(user, outputStream);
            writeWord(pass, outputStream);
            if (status == SEND_MESSAGE)
                writeWord(message, outputStream);
            int response = inputStream.read();
            if (response != OKAY) {
                System.out.println("error sending");
            }
            return response;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (outputStream != null) {
                try {
                    outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (clientSocket != null) {
                try {
                    clientSocket.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            return 0;
        }
    }

    private static void writeWord(String message, OutputStream outputStream) throws IOException {
        byte[] messageBytes = message.getBytes();
        outputStream.write(messageBytes.length);
        outputStream.write(messageBytes);
    }


}
