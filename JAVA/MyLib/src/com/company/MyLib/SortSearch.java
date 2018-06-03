package com.company.MyLib;

import java.util.Random;

public class SortSearch {
    public static void printArray(int[] arr) {
        if (arr == null) {
            System.out.println("null");
            return;
        }
        System.out.print("{");
        for (int i = 0; i < arr.length - 1; i++) {
            System.out.print(arr[i] + ",");
        }
        if (arr.length > 0)
            System.out.print(arr[arr.length - 1]);
        System.out.println("}");
    }

    public static void bubbleSort(int[] arr) {
        int n = arr.length;
        int upTo = n - 1;
        boolean isSorted = false;
        while (!isSorted) {
            isSorted = true;
            for (int j = 0; j < upTo; j++) {
                if (arr[j] > arr[j + 1]) {
                    swap(arr, j, j + 1);
                    isSorted = false;
                }
            }
            upTo--;
        }
    }

    private static void swap(int[] arr, int i, int j) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;

    }

    public static void insertionSort(int[] arr) {
        int n = arr.length;
        for (int i = 1; i < n; i++) {
            int key = arr[i];
            int j = i - 1;
            while (j >= 0 && arr[j] > key) {
                arr[j + 1] = arr[j];
                j--;
            }
            arr[j + 1] = key;
        }
    }

    private static void merge(int[] arr, int l, int m, int r) {
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

    private static void mergeSort(int[] arr, int l, int r) {
        if (r <= l)
            return;
        int m = l + (r - l) / 2;
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);
        merge(arr, l, m, r);
    }

    public static void mergeSort(int[] arr) {
        mergeSort(arr, 0, arr.length);
    }

    public static int binarySearch(int[] arr, int x) {
        return binarySearch(arr, x, 0, arr.length);
    }

    private static int binarySearch(int[] arr, int x, int l, int r) {
        if (r >= l) {
            int m = l + (r - l) / 2;
            if (arr[m] == x)
                return m;
            if (arr[m] > x)
                return binarySearch(arr, x, l, m - 1);
            return binarySearch(arr, x, m + 1, r);
        }
        return -1;
    }

    private static int randomPartition(int[] arr, int low, int high) {
        Random random = new Random(System.currentTimeMillis());
        int r = low + random.nextInt(high - low + 1);
        int temp = arr[high];
        arr[high] = arr[r];
        arr[r] = temp;
        return partition(arr, low, high);
    }

    private static int partition(int[] arr, int low, int high) {
        int pivot = arr[high];
        int i = low - 1;
        for (int j = low; j < high; j++) {
            if (arr[j] <= pivot) {
                i++;
                int temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
        int temp = arr[i + 1];
        arr[i + 1] = pivot;
        arr[high] = temp;
        return i + 1;
    }

    private static void quickSort(int[] arr, int low, int high) {
        if (low >= high)
            return;
        int pi = partition(arr, low, high);
        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }

    public static void quickSort(int[] arr) {
        quickSort(arr, 0, arr.length);
    }
}
