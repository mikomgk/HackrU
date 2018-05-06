package com.company;

public class Main {

    public static void main(String[] args) {
        System.out.println(distance(8, 3));
        System.out.println(product(5, 6));
        System.out.println(quotient(152, 152));
        System.out.println(remainder(19, 20));
        System.out.println(power(2, 24));
    }

    static int distance(int x, int y) {
        int count = 0;
        for (int i = (x > y ? y : x); i < (x > y ? x : y); i++, count++) ;
        return count;
    }

    static int product(int x, int y) {
        int res = 0;
        for (int i = 0; i < y; i++, res += x) ;
        return res;
    }

    static int quotient(int x, int y) {
        if (y == 0)
            return -1;
        int count = 0;
        for (int i = y; i <= x; i += y, count++) ;
        return count;
    }

    static int remainder(int x, int y) {
        if (y == 0)
            return -1;
        return distance(product(quotient(x, y), y), x);
    }

    static int power(int x, int y) {
        if (x == 0 && y == 0)
            return -1;
        int res = 1;
        for (int i = 0; i < y; i++, res *= x) ;
        return res;
    }
}
