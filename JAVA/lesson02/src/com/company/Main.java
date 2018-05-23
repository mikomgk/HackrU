package com.company;

public class Main {

    public static void main(String[] args) {
        organize();
    }

    public static int organize() {
        int[] array = {1, 5, 2, 7, 9, 4, 1, 4};

        for (int i = 0; i < array.length; i++) {
            int saveBigNumber = 0;
            if (array[i] >= array[i + 1]) {
                saveBigNumber = array[i];
                array[i] = array[i+1];
                array[i+1] = saveBigNumber;
            }

        }
        System.out.println("hello");
        return -1;
    }


}
