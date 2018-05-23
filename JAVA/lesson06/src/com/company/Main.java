package com.company;

import java.util.Random;

public class Main {

    public static void main(String[] args) {
        int arr[] = new int[30];
        Random random = new Random();
        for (int i = 0; i < arr.length; i++)
            arr[i] = random.nextInt(10) + 1;
        print(arr);
        //System.out.println(arr[findPoint(arr)]);
        int x = random.nextInt(10) + 1;
        System.out.println(x);
        System.out.println(findSum2(arr, x));
        print(arr);
    }

    static boolean findSum2(int[] arr, int sum) {
        boolean[] existNumbers = new boolean[600 - 500];
        for (int i = 0; i < arr.length; i++) {
            existNumbers[arr[i] - 500] = true;
        }
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] < 500 || arr[i] >= 600)
                return false;
            if (existNumbers[arr[i] - 500])
                return true;
        }
        return false;
    }

    static int findPoint(int[] arr) {
        return findPoint(arr, 0, arr.length - 1);
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

    static boolean findSum(int[] arr, int z) {
        mergeSort(arr);
        return findSum(arr, z, 0, arr.length - 1);
    }

    static boolean findSum(int[] arr, int z, int l, int h) {
        if (l == h)
            return false;
        if (arr[l] + arr[h] == z)
            return true;
        if (arr[l] + arr[h] > z)
            return findSum(arr, z, l, h - 1);
        return findSum(arr, z, l + 1, h);
    }

    static void merge(int[] arr, int l, int m, int r) {
        int n1 = m - l + 1;
        int n2 = r - m;
        int[] L = new int[n1];
        int[] R = new int[n2];
        for (int i = 0; i < n1; i++) {
            L[i] = arr[l + i];
        }
        for (int j = 0; j < n2; j++) {
            R[j] = arr[m + 1 + j];
        }
        int i = 0, j = 0;
        int k = l;  //k == l + i + j
        while (i < n1 && j < n2) {
            if (L[i] <= R[j]) {
                arr[k] = L[i];
                i++;
            } else {
                arr[k] = R[j];
                j++;
            }
            k++;
        }
        while (i < n1) {
            arr[k] = L[i];
            i++;
            k++;
        }
        while (j < n2) {
            arr[k] = R[j];
            j++;
            k++;
        }
    }

    static void mergeSort(int[] arr) {
        mergeSort(arr, 0, arr.length - 1);
    }

    static void mergeSort(int[] arr, int l, int r) {
        if (r <= l)
            return;
        int m = l + (r - l) / 2;
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);
        merge(arr, l, m, r);
    }
}
