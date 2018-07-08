package com.company.client;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.nio.ByteBuffer;
import static com.company.client.Main.*;


public class PullMessagesThread extends Thread {

    private int from = 0;
    private boolean go = true;

    @Override
    public void run() {
        while (go) {
            pull();
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    private void pull(){
        Socket clientSocket = null;
        InputStream inputStream = null;
        OutputStream outputStream = null;
        try {
            clientSocket = new Socket(HOST, PORT);
            inputStream = clientSocket.getInputStream();
            outputStream = clientSocket.getOutputStream();
            outputStream.write(PULL);
            byte[] fromBytes = new byte[4];
            ByteBuffer.wrap(fromBytes).putInt(from);
            outputStream.write(fromBytes);
            int messageLength;
            while ((messageLength = inputStream.read()) != -1){
                byte[] messageBytes = new byte[messageLength];
                int actuallyRead = inputStream.read(messageBytes);
                if(actuallyRead != messageLength){
                    System.out.println("error");
                    return;
                }
                String message = new String(messageBytes);
                System.out.println(message);
                from++;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if(inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if(outputStream != null) {
                try {
                    outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if(clientSocket != null) {
                try {
                    clientSocket.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public void stopPulling(){
        go = false;
        interrupt();
    }
}