package com.company;

public class Main {

    public static void main(String[] args) {
        int arr[] = {1, 2, 3, 5, 44, 66, 88, 77, 99, 111, 222, 333, 444, 555, 6666};
        System.out.println(binarySearchFor(arr, 666));
        print(arr);
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
        int l = 0, r = arr.length;
        while(r>=l){
            int m = l + (r - l) / 2;
            if(arr[m]==x)
                return m;
            if (arr[m]>x)
                r=m-1;
            else
                l=m+1;
        }
        return -1;
    }
}
