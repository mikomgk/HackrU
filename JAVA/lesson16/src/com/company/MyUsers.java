package com.company;

import java.util.*;

public class MyUsers implements Map<String, String> {
    private user[] users;
    private static int countUsers;

    static {
        countUsers = 0;
    }

    public MyUsers(user[] users) {
        this.users[100] = null;
    }

    @Override
    public int size() {
        return countUsers;
    }

    @Override
    public boolean isEmpty() {
        return countUsers == 0;
    }

    @Override
    public boolean containsKey(Object key) {
        if (isEmpty() || key == null)
            return false;
        for (int i = 0; i < countUsers; i++) {
            if (users[i].userName.equals(key))
                return true;
        }
        return false;
    }

    @Override
    public boolean containsValue(Object value) {
        return false;
    }

    @Override
    public String get(Object key) {
        if (isEmpty() || key == null)
            return null;
        for (int i = 0; i < countUsers; i++) {
            if (users[i].userName.equals(key))
                return users[i].password;
        }
        return null;
    }

    @Override
    public String put(String key, String value) {
        if (key == null || value == null)
            return null;
        if (!isEmpty())
            for (int i = 0; i < countUsers; i++) {
                if (users[i].userName.equals(key)) {
                    users[i].password = value;
                    return key;
                }
            }
        users[countUsers++] = new user(key, value);
        return null;
    }

    @Override
    public String remove(Object key) {
        if (isEmpty() || key == null)
            return null;
        for (int i = 0; i < countUsers; i++) {
            if (users[i].userName.equals(key)) {
                for (int j = i; j < countUsers; j++) {
                    users[j] = users[j + 1];
                }
                countUsers--;
                return (String)key;
            }
        }
        return null;
    }

    @Override
    public void putAll(Map<? extends String, ? extends String> m) {

    }

    @Override
    public void clear() {

    }

    @Override
    public Set<String> keySet() {
        return null;
    }

    @Override
    public Collection<String> values() {
        return null;
    }

    @Override
    public Set<Entry<String, String>> entrySet() {
        return null;
    }

    private static class user {
        private String userName;
        private String password;
        private int logins;

        public user(String userName, String password) {
            this.userName = userName;
            this.password = password;
            this.logins = 0;
        }

        public String getUserName() {
            return userName;
        }

        public void setUserName(String userName) {
            this.userName = userName;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public int getLogins() {
            return logins;
        }

        public void setLogins(int logins) {
            this.logins = logins;
        }
    }
}
