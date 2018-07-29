
package com.company;

import com.sun.org.apache.xpath.internal.SourceTree;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);


        for (int i = 0; i < 1000; i++) {
            System.out.println("Welcome to my calculator :) please select your action:");
            System.out.println("1=ADD, 2=CUT, 3=DIVIDE, 4=MULTIPLY.");
            System.out.println("*To exit input any other number.");
            int first;
            int second;
            int score;
            int calc = scanner.nextInt();
            switch (calc) {
                case 1:
                    System.out.println("please input the sum you like to add");
                    first = scanner.nextInt();
                    System.out.println("the first number is " + first + " what sum you like to add?");
                    second = scanner.nextInt();
                    score = first + second;
                    System.out.println("the value is: " + score);
                    break;
                case 2:
                    System.out.println("please input the sum you like to cut");
                    first = scanner.nextInt();
                    System.out.println("the first number is " + first + " what sum you like to cut?");
                    second = scanner.nextInt();
                    score = first - second;
                    System.out.println("the value is: " + score);
                    break;
                case 3:
                    System.out.println("please input the sum you like to divide");
                    first = scanner.nextInt();
                    while (first == 0) {
                        System.out.println("you cannot divide by 0 please choose a different number");
                        first = scanner.nextInt();
                    }
                    System.out.println("the first number is " + first + " what sum you like to divide?");
                    second = scanner.nextInt();
                    score = first / second;
                    System.out.println("the value is: " + score);
                    break;
                case 4:
                    System.out.println("please input the sum you like to multiply");
                    first = scanner.nextInt();
                    System.out.println("the first number is " + first + " what sum you like to multiply?");
                    second = scanner.nextInt();
                    score = first * second;
                    System.out.println("the value is: " + score);
                    break;
                default:
                    i = 1000;
            }
        }
        scanner.close();
    }
}