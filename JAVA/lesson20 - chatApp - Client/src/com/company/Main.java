package com.company;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import static java.lang.System.exit;

public class Main {

    public static final String BASE_URL = "http://localhost:8080/servlet";
    public static final String USERNAME = "username";
    public static final String PASSWORD = "password";
    public static final String LOG_IN = "login";
    public static final String SIGN_UP = "signup";
    public static final String SEND = "send";
    public static final String PULL = "pull";
    public static final String ACTION = "action";
    public static final String FROM = "from";
    public static final String OK = "200";
    public static final String ERROR = "400";

    public static void main(String[] args) {
        List<Message> messages = new ArrayList<>();
        User user = null;
        Scanner scanner = new Scanner(System.in);
        while (true) {
            System.out.println("Choose option:");
            System.out.println("0. EXIT");
            System.out.println("1. Sign Up");
            System.out.println("2. Login");
            String optionString = scanner.next();
            int option = Integer.valueOf(optionString);
            boolean isSignUp = false;
            switch (option) {
                case 0:
                    exit(0);
                case 1:
                    isSignUp = true;
                    break;
                case 2:
                    isSignUp = false;
                    break;
                default:
                    continue;
            }
            user = getUserDetails();
            if (user == null)
                continue;
            if (loginRequest(user,isSignUp)) {
                break;
            }
        }
        System.out.println("Welcome");
        PullMessagesThread pullMessagesThread = new PullMessagesThread(user,messages);
        pullMessagesThread.start();
        while (true){
            String input=scanner.nextLine();
            if(input.equals("exit"))
                break;
            sendRequest(user,input);
        }
        pullMessagesThread.stopPulling();
    }

    static boolean loginRequest(User user, boolean isSignUp) {
        if (isSignUp)
            return makeHttpRequest(user, SIGN_UP, 0, null, null);
        return makeHttpRequest(user, LOG_IN, 0, null, null);
    }

    static boolean sendRequest(User user, String message) {
        return makeHttpRequest(user, SEND, 0, message, null);
    }

    public static boolean pullRequest(User user,int from,List<Message> messages) {
        return makeHttpRequest(user, PULL, from, null, messages);
    }

    static String getMessage(InputStream inputStream, int bufferSize) throws IOException {
        byte[] buffer = new byte[bufferSize];
        int actuallyRead;
        StringBuilder message = new StringBuilder();
        while ((actuallyRead = inputStream.read(buffer)) != -1)
            message.append(new String(buffer, 0, actuallyRead));
        return message.toString();
    }

    static User getUserDetails() {
        Scanner scanner = new Scanner(System.in);
        String user, pass;
        System.out.println("type back to go back");
        System.out.println("Username: ");
        user = scanner.next();
        if (user.equals("back"))
            return null;
        System.out.println("Password: ");
        pass = scanner.next();
        if(user.length()==0||pass.length()==0)
            return null;
        return new User(user, pass);
    }

    static boolean makeHttpRequest(User user, String action, int from, String message, List<Message> messages) {
        URL url = null;
        HttpURLConnection connection = null;
        OutputStream outputStream = null;
        InputStream inputStream = null;
        try {
            url = new URL(BASE_URL + "?action=" + action + "&username=" + user.getUserName() + "&password=" + user.getPassword() +
                    (action.equals(PULL) ? "&from=" + from : ""));
            connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);
            connection.setUseCaches(false);

            outputStream = connection.getOutputStream();
            inputStream = connection.getInputStream();
            if (action.equals(SEND)) {
                outputStream.write(message.getBytes());
            }
            if (!action.equals(PULL)) {
                if (getMessage(inputStream, 16).equals(OK))
                    return true;
            } else {
                String responseMessage = getMessage(inputStream, 1024);
                JSONArray JSONMessages = new JSONArray(responseMessage);
                boolean isNew=false;
                for (int i = from; i < JSONMessages.length(); i++) {
                    messages.add(
                            new Message(
                                    JSONMessages.getJSONObject(i).get("sender").toString(),
                                    JSONMessages.getJSONObject(i).get("content").toString()
                            )
                    );
                    isNew=true;
                }
                return isNew;
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (JSONException e) {
            e.printStackTrace();
        } finally {
            if (outputStream != null) {
                try {
                    outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null)
                connection.disconnect();
        }
        return false;
    }
}
