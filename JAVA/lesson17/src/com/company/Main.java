package com.company;

import java.io.File;
import java.util.HashSet;
import java.util.Set;

public class Main {

    public static void main(String[] args) {
        System.out.println(countFiles("C:\\"));
    }

    private static int countFiles(String path) {
        int count=0;
        File file = new File(path);
        if (file.isFile())
            return 1;
        else {
            File[] files = file.listFiles();
            if (files == null)
                return 0;
            for (int i = 0; i < files.length; i++) {
                count += countFiles(files[i].getAbsolutePath());
            }
        }
        return count;
    }

    private static void targil() {
        Circle[] a = {new Circle(new Point(1, 2), 5), new Circle(new Point(5, 3), 3)};
        Circle[] b = {new Circle(new Point(1, 2), 5), new Circle(new Point(1, 2), 5)};
        Set<Circle> mySet = new HashSet<>();
        for (int i = 0; i < a.length; i++) {
            mySet.add(a[i]);
        }
        System.out.println(containsArr(b, mySet));
    }

    private static boolean containsArr(Circle[] b, Set<Circle> mySet) {
        if (b == null)
            return false;
        for (int i = 0; i < b.length; i++) {
            if (!mySet.contains(b[i]))
                return false;
        }
        return true;
    }

    private static int[] hituch(int[] b, Set<Integer> mySet) {
        int[] result = new int[b.length];
        int p = 0;
        for (int i = 0; i < b.length; i++) {
            if (mySet.contains(b[i]))
                result[p++] = b[i];
        }
        int[] r = new int[p];
        for (int i = 0; i < p; i++) {
            r[i] = result[i];
        }
        return r;
    }

    private static void printArr(int[] a) {
        System.out.print("{");
        for (int i = 0; i < a.length; i++) {
            System.out.print(a[i] + ",");
        }
        System.out.print("}");
    }
}
