package com.company;

public class Main {

    public static void main(String[] args) {

    }

    public static int[] kSmallest(int[] arr, int n) {
        int maxIndex = maxIndex(arr);
        if (arr[maxIndex] > n)
            arr[maxIndex] = n;
        return arr;
    }

    public static int maxIndex(int[] arr) {
        int maxIndex = 0;
        for (int i = 1; i < arr.length; i++) {
            if (arr[i] > arr[maxIndex])
                maxIndex = i;
        }
        return maxIndex;
    }

    public static int getNum(int[] digits, int index) {
        return getNum(digits, index, 0);
    }

    private static int getNum(int[] digits, int index, int num) {
        int optionSum = factorial(digits.length);
        num = num * 10 + digits[optionSum / index];
        return num;
    }

    public static int factorial(int n) {
        int factorial = 1;
        for (int i = 1; i <= n; i++) {
            factorial *= i;
        }
        return factorial;
    }
}
