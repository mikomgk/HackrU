package com.company;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.nio.ByteBuffer;
import java.util.List;
import java.util.Map;

public class ClientThread extends Thread {

    public static final int SEND = 50;
    public static final int PULL = 51;
    public static final int OKAY = 200;
    public static final int SIGN_UP = 52;
    public static final int USER_EXIST = 300;
    public static final int WRONG_USER = 400;
    public static final int LOG_IN = 53;
    private Socket clientSocket;
    private InputStream inputStream;
    private OutputStream outputStream;
    private List<String> messages;
    private Map<String, String> users;

    public ClientThread(Socket clientSocket, List<String> messages, Map<String, String> users) {
        this.clientSocket = clientSocket;
        this.messages = messages;
        this.users = users;
    }

    @Override
    public void run() {
        try {
            inputStream = clientSocket.getInputStream();
            outputStream = clientSocket.getOutputStream();
            int action = inputStream.read();
            switch (action) {
                case SEND:
                    send();
                    break;
                case PULL:
                    pull();
                    break;
                case SIGN_UP:
                    signUp();
                    break;
                case LOG_IN:
                    logIn();
                    break;
            }
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
        }

    }

    private void send() throws IOException {
        String user;
        if ((user = checkLogIn()) == null) {
            outputStream.write(WRONG_USER);
            return;
        }
        String message = getString();
        if (message == null)
            return;
        messages.add(user + "\r\n" + message);
        outputStream.write(OKAY);
    }

    private void pull() throws IOException {
        if (checkLogIn() == null) {
            outputStream.write(WRONG_USER);
            return;
        }
        byte[] fromBytes = new byte[Integer.BYTES];
        int actuallyRead = inputStream.read(fromBytes);
        if (actuallyRead != Integer.BYTES)
            return;
        int from = ByteBuffer.wrap(fromBytes).getInt();
        for (int i = from; i < messages.size(); i++) {
            byte[] messageBytes = messages.get(i).getBytes();
            outputStream.write(messageBytes.length);
            outputStream.write(messageBytes);
        }
    }

    private void signUp() throws IOException {
        String user = getString(), pass = getString();
        if (user == null || pass == null)
            return;
        boolean success = false;
        synchronized (this) {
            if (!users.containsKey(user)) {
                users.put(user, pass);
                success = true;
            }
        }
        outputStream.write(success ? OKAY : USER_EXIST);
    }

    private void logIn() throws IOException {
        outputStream.write(checkLogIn() != null ? OKAY : WRONG_USER);
    }

    private String checkLogIn() throws IOException {
        String user = getString(), pass = getString();
        if (user == null || pass == null)
            return null;
        synchronized (this) {
            if (users.containsKey(user) && users.get(user).equals(pass))
                return user;
        }
        return null;
    }

    private String getString() throws IOException {
        int messageLength = inputStream.read();
        if (messageLength == -1)
            return null;
        byte[] messageBytes = new byte[messageLength];
        int actuallyRead = inputStream.read(messageBytes);
        if (actuallyRead != messageLength)
            return null;
        return new String(messageBytes);
    }
}