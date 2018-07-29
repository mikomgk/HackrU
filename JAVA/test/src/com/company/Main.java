package com.company;

import static com.company.Base.x;

public class Main {

    public static void main(String []args) {
        x
    }
}

class Base {
    private static int x=5;
    public Base() {
        System.out.print("Base ");
    }
    public Base(String s) {
        System.out.print("Base: " + s);
    }
}
class Derived extends Base {
    public Derived(String s) {
        //super(); // Stmt-1
        //super(s); // Stmt-2
        System.out.print("Derived ");
    }
}