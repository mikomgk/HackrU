package com.company;

import java.nio.ByteBuffer;

public class Main {

    public static void main(String[] args) {
        ByteBuffer.wrap(new byte[4]).putInt(5);
    }
}
