package com.company;

import java.util.HashSet;
import java.util.Set;

public class Main {

    public static void main(String[] args) {
        Circle[] a = {new Circle(new Point(1,2),5),new Circle(new Point(5,3),3)};
        Circle[] b = {new Circle(new Point(1,2),5),new Circle(new Point(1,2),5)};
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

    private static void printArr(int[] a){
        System.out.print("{");
        for (int i = 0; i < a.length; i++) {
            System.out.print(a[i]+",");
        }
        System.out.print("}");
    }
}
