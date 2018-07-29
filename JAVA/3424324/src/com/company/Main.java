package com.company;

public class Main {

    public static void main(String[] args) {
        new Object() = Object() object object1;
        Object[object1, object2] x;
    }


    static void bubbleSort(Object[] x) {
        int n = x.length;
        int upTo = n - 1;
        boolean isSorted = false;
        while (!isSorted) {
            isSorted = true;
            for (int j = 0; j < upTo; j++) {
                if (x[j] != x[j + 1]) {
                    swap(x, j, j + 1);
                    isSorted = false;
                }
            }
            upTo--;
        }
    }


    static void swap(Object[] x, Object i, Object j) {
        Object temp = x[i];
        x[i] = x[j];
        x[j] = temp;
    }
}