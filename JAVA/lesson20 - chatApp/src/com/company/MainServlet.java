package com.company;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import javax.servlet.ServletException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MainServlet extends javax.servlet.http.HttpServlet {
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
    List<Message> messages = new ArrayList<>();
    Map<String, String> users = new HashMap<>();
    private int counter;

    @Override
    public void init() throws ServletException {
        super.init();
        counter = 0;
    }

    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        String action = request.getParameter(ACTION);
        String userName = request.getParameter(USERNAME);
        String password = request.getParameter(PASSWORD);
        if (action == null || userName == null || password == null)
            return;
        User user = new User(userName, password);
        switch (action) {
            case LOG_IN:
                response.getWriter().write(validateUser(user, false) ? OK : ERROR);
                break;
            case SIGN_UP:
                response.getWriter().write(validateUser(user, true) ? OK : ERROR);
                break;
            case SEND:
                if (!validateUser(user, false)) {
                    response.getWriter().write(ERROR);
                    return;
                }
                byte[] buffer = new byte[1024];
                int actuallyRead;
                StringBuilder message = new StringBuilder();
                while ((actuallyRead = request.getInputStream().read(buffer)) != -1)
                    message.append(new String(buffer, 0, actuallyRead));
                response.getWriter().write(send(message.toString(), user.getUserName()) ? OK : ERROR);
                break;
            case PULL:
                int from = Integer.valueOf(request.getParameter(FROM));
                if (!validateUser(user, false) || from < 0) {
                    response.getWriter().write(ERROR);
                    return;
                }
                response.getWriter().write(pull(from));
                break;
            default:
                response.getWriter().write(ERROR);
                break;
        }
    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        System.out.println(request);
        response.getWriter().write("fdsfds");
    }

    private boolean validateUser(User user, boolean isSignup) {
        String userName = user.getUserName();
        String password = user.getPassword();
        if (!isSignup)
            synchronized (users) {
                if (users.containsKey(userName) && users.get(userName).equals(password))
                    return true;
            }
        else
            synchronized (users) {
                if (!users.containsKey(userName)) {
                    users.put(userName, password);
                    return true;
                }
            }
        return false;
    }

    private boolean send(String message, String userName) throws IOException {
        messages.add(new Message(userName, message));
        counter++;
        return true;
    }

    private String pull(int from) {
        JSONArray messagesJSON = new JSONArray();
        JSONObject messageJSON;
        for (int i = from; i < messages.size(); i++) {
            messageJSON = new JSONObject();
            Message m = messages.get(i);
            try {
                messageJSON.put("sender", m.getSender());
                messageJSON.put("content", m.getContent());
            } catch (JSONException e) {
                return null;
            }
            messagesJSON.put(messageJSON);
        }
        return messagesJSON.toString();
    }
}
