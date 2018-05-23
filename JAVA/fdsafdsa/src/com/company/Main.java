package com.company;

public class Main {

    public static void main(String[] args) {
        int[] arr = {1, 5, 2, 7, 9, 0, 1, 4};
        insertionSort(arr);
        System.out.print("the insertionSort Array is:");
        print(arr);
    }

    public static int sort(int[] array) {
        int saveNextNumber = 0;
        for (int i = 0; i < array.length; i++) {
            while (array[i] >= array[i++]) {
                array[i] = saveNextNumber;
                array[i] = array[i++];
                array[i++] = saveNextNumber;
            }

        }

        return -1;
    }

    public static void print(int[] array) {
        System.out.print("{");

        for (int i = 0; i < array.length - 1; i++) {
            System.out.print(array[i] + ",");
        }
        if (array.length > 0)
            System.out.print(array[array.length - 1]);
        System.out.println("}");
    }

    static void insertionSort(int[] arr) {
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

    static void merge(int[] arr, int l, int m, int r) {
        int n1 = m - l + 1;
        int n2 = r - m;
        int[] L = new int[n1];
        int[] R = new int[n2];
        for (int i = 0; i < n1; i++) {
            L[i] = arr[l + 1];
        }
        for (int j = 0; j < n2; j++) {
            R[j] = arr[m + 1 + j];
        }
        int i = 0, j = 0;
        int k = l;
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
    static void mergeSort(int[] arr, int l, int r){
        if(l>=r)
            return;
        int m = (l+r)/2;
        mergeSort(arr,l,m);
        mergeSort(arr,m+1,r);
        merge(arr,l,m,r);
    }
}