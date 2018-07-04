package com.company;

import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;

public class User {
    private String username;
    private String password;
    private int id;

    public User(String username, String password, int id) {
        this.username = username;
        this.password = password;
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List listOfUsersFromStream(InputStream input) {
        int bytes, count = 0, id = 0;
        String user = null, pass = null;
        List<User> users = new ArrayList<>();
        try {
            while ((bytes = input.read()) != -1) {
                byte[] buffer = new byte[bytes];
                input.read(buffer);
                if (count == 0)
                    user = new String(buffer);
                if (count == 1)
                    pass = new String(buffer);
                if (count == 2)
                    id = ByteBuffer.wrap(buffer).getInt();
                count = (count + 1) % 3;
                if (user != null && pass != null && id != 0)
                    users.add(new User(user, pass, id));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return users;
    }
}
