package com.company;

import java.math.BigInteger;

public class Main {

    public static void main(String[] args) {
        System.out.println(sumPaths(20,20));
        System.out.println(getLexicographic(10, 20));
    }

    static String getLexicographic(int digits, int index) {
        return getLexicographic(digits, index, new int[digits], 1);
    }

    private static String getLexicographic(int digits, int index, int[] used, int counter) {
        if (digits == 0)
            return "";
        int f = factI(digits - 1), i = counter == 1 ? (index - 1) / f : (index) / f;
        i = checkI(i, used);
        return Integer.toString(i) + getLexicographic(digits - 1, counter == 1 ? (index - 1) % f : (index) % f,
                used, ++counter);
    }

    private static int checkI(int i, int[] used) {
//        i = i == -1 ? used.length - 1 : i == used.length ? 0 : i;
        if (used[i] != 0)
            return checkI(++i, used);
        used[i] = 1;
        return i;
    }

    static int factI(int n) {
        int fact = 1;
        for (int i = 2; i <= n; i++)
            fact *= i;
        return fact;
    }

    static BigInteger sumPaths(int right, int down) {
        int path = right + down;
        BigInteger sum = (fact(path).divide(fact(right).multiply(fact(down))));
        return sum;
    }

    static BigInteger fact(int n) {
        BigInteger fact = new BigInteger("1");
        for (int i = 2; i < n; i++)
            fact = fact.multiply(new BigInteger(Integer.toString(i)));
        return fact;
    }
}