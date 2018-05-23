package com.company;

import java.util.Random;

public class Main {

    public static void main(String[] args) {
        int arr[] = {750,825,73,118,82,893,832,733,537,896,877,757,850,769,421,926,847,22};
        Random random = new Random();
        for(int i=0;i<arr.length;i++)
            arr[i]=random.nextInt(1000)+1;
        print(arr);
        System.out.println(arr[highNumber(arr)]);
        System.out.println(highNumber(arr));
    }

    static int highNumber(int[] arr) {
        return highNumber(arr, 0, arr.length - 1);
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

    static int highNumber(int[] arr, int l, int r) {
        if (r < l)
            return -1;
        int m = l + (r - l) / 2;
        if (l == 0 || r == arr.length - 1)
            if (arr[l] >= arr[l + 1] || arr[r] >= arr[r - 1])
                return arr[l] >= arr[l + 1] ? l : r;
        if (arr[m] >= arr[m - 1] && arr[m] >= arr[m + 1])
            return m;
        else if (arr[m] >= arr[m - 1])
            return highNumber(arr, m, r);
        return highNumber(arr, l, m);
    }
}
