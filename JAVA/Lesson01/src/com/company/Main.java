package com.company;

public class Main {

    public static void main(String[] args) {
        int a=1,b=1,c=2,x=1000,i=3;
        while(c<Math.pow(10,x-1)){
            a=b;
            b=c;
            c=a+b;
            i++;
        }
        System.out.println(c);
        System.out.println(i);
    }
}
