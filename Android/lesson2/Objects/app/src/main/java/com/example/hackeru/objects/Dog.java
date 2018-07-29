package com.example.hackeru.objects;

import org.json.JSONException;
import org.json.JSONObject;

import java.nio.ByteBuffer;

public class Dog {
    public static final String NAME = "name";
    public static final String AGE = "age";
    private String name;
    private int age;

    public Dog(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public Dog(String json) {
        try {
            JSONObject jsonDog = new JSONObject(json);
            name = jsonDog.getString(NAME);
            age = jsonDog.getInt(AGE);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    public Dog(byte dog[]) {
        int nameLength = dog[0];
        name=new String(dog,1,nameLength);
        age= ByteBuffer.wrap(new String(dog,nameLength,4).getBytes()).getInt();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String toJSON() {
        JSONObject jsonDog = new JSONObject();
        try {
            jsonDog.put(NAME, name);
            jsonDog.put(AGE, age);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return jsonDog.toString();
    }

    public byte[] toBytes() {
        int nameLength = name.length(), index = 0;
        byte dogBytes[] = new byte[nameLength + 5];
        byte nameBytes[] = name.getBytes();
        byte ageBytes[] = intToBytes(age);
        dogBytes[index++] = (byte) nameLength;
        for (int i = 0; i < nameLength; i++) {
            dogBytes[index++] = nameBytes[i];
        }
        for (int i = 0; i < 4; i++) {
            dogBytes[index++] = ageBytes[i];
        }
        return dogBytes;
    }

    @Override
    public String toString() {
        return "I am " + name + ", and I am " + age + " years old";
    }

    public byte[] intToBytes(int n) {
        byte b[] = new byte[4];
        for (int i = 0; i < 4; i++, n <<= 1) {
            b[i] = (byte) n;
        }
        return b;
    }

    public int bytesToInt(byte b[]){
        int x=0;
        for (int i = 4; i >=0 ; i--) {
            x<<=8;
            x|=b[i];
        }
        return x;
    }
}