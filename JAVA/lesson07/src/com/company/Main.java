package com.company;

public class Main {

    public static void main(String[] args) {
        char[][] screen = new char[40][180];
        saveRect(0, 0, 1, 1, screen);
        saveRect(2, 2, 10, 10, screen);
        saveRect(10, 5, 15, 5, screen);
        saveRect(8, 8, 25, 15, screen);
        saveRect(30, 2, 30, 10, screen);
        saveRect(15, 30, 30, 10, screen);
        printScreen(screen);
    }

    public static void printScreen(char[][] screen) {
        for (int i = 0; i < screen.length; i++) {
            for (int j = 0; j < screen[i].length; j++) {
                if (screen[i][j] == '*')
                    System.out.print('*');
                else
                    System.out.print(' ');
            }
            System.out.println();
        }
    }

    public static void saveRect(int x, int y, int width, int height, char[][] screen) {
        for (int i = x; i <= x + width && y < screen.length; i++)
            if (i < screen[y].length)
                screen[y][i] = '*';
        for (int i = y + 1; i < y + height && i < screen.length; i++) {
            if (x < screen[i].length)
                screen[i][x] = '*';
            if (x + height - 1 < screen[i].length)
                screen[i][x + width] = '*';
        }
        for (int i = x; i < x + width && y + height < screen.length; i++)
            if (i < screen[y + height].length)
                screen[y + height - 1][i] = '*';
    }
/*
    public static int getDigitSum(int n) {
        int sum = 0;
        for (; n != 0; n /= 10)
            sum += n % 10;
        return sum;
    }

    public static int getBiggestDigit(int n) {
        int biggest = 0;
        for (; n != 0; n /= 10)
            if (n % 10 > biggest)
                biggest = n % 10;
        return biggest;
    }

    public static int invertNum(int n) {
        int x = 0;
        for (; n != 0; n /= 10)
            x = x * 10 + n % 10;
        return x;
    }
/*
    public static boolean isExcistInArr(int arr[][], int x) {
        return isExcistInArr(arr, x, 0, 0);
    }

    private static boolean isExcistInArr(int arr[][], int x, int i, int j) {
        if (x == arr[i][j])
            return true;
        if (i < arr.length - 1 && x > arr[i + 1][j])
            return isExcistInArr(arr, x, i + 1, j);
        else
            binarySearch();
        return isExcistInArr(arr, x, i, j + 1);
    }*/
}
