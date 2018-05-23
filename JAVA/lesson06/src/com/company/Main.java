package com.company;

import java.util.Random;

public class Main {

    public static void main(String[] args) {
        int arr[] = {-1,0,1,2,3,4,5,6,7,8,9,10};
        Random random = new Random();
        /*for (int i = 0; i < arr.length; i++)
            arr[i] = random.nextInt(10) + 1;*/
        print(arr);
        //System.out.println(arr[findPoint(arr)]);
        System.out.println(findPoint(arr));
    }

    static int findPoint(int[] arr) {
        return findPoint(arr, 0, arr.length-1);
    }

    static int highNumber(int[] arr) {
        return highNumber(arr, 0, arr.length - 1, arr.length - 1);
    }

    static void print(int arr[]) {
        System.out.print("{" + arr[0]);
        for (int i = 1; i < arr.length - 1; i++)
            System.out.print("," + arr[i]);
        System.out.println("}");
    }

    static int binarySearch(int[] arr, int x) {
        return binarySearch(arr, x, 0, arr.length);
    }

    static int binarySearch(int[] arr, int x, int l, int r) {
        if (r < l)
            return -1;
        int m = l + (r - l) / 2;
        if (arr[m] == x)
            return m;
        else if (arr[m] > x)
            return binarySearch(arr, x, l, m - 1);
        return binarySearch(arr, x, m + 1, r);
    }

    static int binarySearchFor(int[] arr, int x) {
        int l = 0, r = arr.length - 1;
        while (r >= l) {
            int m = l + (r - l) / 2;
            if (arr[m] == x)
                return m;
            if (arr[m] > x)
                r = m - 1;
            else
                l = m + 1;
        }
        return -1;
    }

    static int highNumber(int[] arr, int l, int r, int n) {
        int m = l + (r - l) / 2;
        if ((m == 0 || arr[m] >= arr[m - 1]) && (m == n - 1 || arr[m] >= arr[m + 1]))
            return m;
        if (m > 0 && arr[m - 1] >= arr[m])
            return highNumber(arr, l, m, n);
        return highNumber(arr, m, r, n);
    }

    static int findPoint(int[] arr, int l, int r) {
        if (r < l)
            return -1;
        int m = l + (r - l) / 2;
        if (arr[m] == m)
            return m;
        else if (arr[m] > m)
            return findPoint(arr, l, m - 1);
        return findPoint(arr, m + 1, r);
    }
}
