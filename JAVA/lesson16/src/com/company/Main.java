package com.company;

import java.util.SortedMap;

import static com.company.Main.Operator.*;

public class Main {

    static int max, min, sum;
    static boolean atLeastOneNumber;

    public enum Operator {NONE, ADD, SUBTRACT, MULTIPLY, DIVIDE}

    static {
        sum = 0;
        atLeastOneNumber = false;
    }

    public static void main(String[] args) {
        MenuOption[] loginMenu={new MenuOption("maxCalc", new MenuOption.OptionSelectedListener() {
            @Override
            public void optionSelected(Operator val) {
                MenuOption[] maxCalc = {new MenuOption("insert number", new MenuOption.OptionSelectedListener() {
                    @Override
                    public void optionSelected(Main.Operator val) {
                        int num = MenuOption.getIntFromUser("Enter a number");
                        insertNumber(num);
                    }
                }), new MenuOption("max number", new MenuOption.OptionSelectedListener() {
                    @Override
                    public void optionSelected(Main.Operator val) {
                        if (!atLeastOneNumber)
                            System.out.println("no numbers inserted");
                        else
                            System.out.println("the max number is: " + max);
                    }
                }), new MenuOption("min number", new MenuOption.OptionSelectedListener() {
                    @Override
                    public void optionSelected(Main.Operator val) {
                        if (!atLeastOneNumber)
                            System.out.println("no numbers inserted");
                        else
                            System.out.println("the min number is: " + min);
                    }
                }), new MenuOption("sum numbers", new MenuOption.OptionSelectedListener() {
                    @Override
                    public void optionSelected(Main.Operator val) {
                        if (!atLeastOneNumber)
                            System.out.println("no numbers inserted");
                        else
                            System.out.println("the sum is: " + sum);
                    }
                })};
                MenuOption.menu(maxCalc);
            }
        }),new MenuOption("regCalc", new MenuOption.OptionSelectedListener() {
            @Override
            public void optionSelected(Operator val) {
                MenuOption.OptionSelectedListener listener = new MenuOption.OptionSelectedListener() {
                    @Override
                    public void optionSelected(Main.Operator val) {
                        int x = MenuOption.getIntFromUser("enter first number");
                        int y = MenuOption.getIntFromUser("enter second number");
                        int result = 0;
                        switch (val) {
                            case ADD:
                                System.out.println(x + "+" + y + "=" + (result = x + y));
                                break;
                            case SUBTRACT:
                                System.out.println(x + "-" + y + "=" + (result = x - y));
                                break;
                            case MULTIPLY:
                                System.out.println(x + "*" + y + "=" + (result = x * y));
                                break;
                            case DIVIDE:
                                if (y == 0) {
                                    System.out.println("division by zero is not allowed");
                                    return;
                                }
                                System.out.println(x + "/" + y + "=" + (result = x / y));
                                break;
                        }
                        insertNumber(result);
                    }
                };
                MenuOption[] regCalc = {
                        new MenuOption("add", listener, ADD),
                        new MenuOption("subtract", listener, SUBTRACT),
                        new MenuOption("multiply", listener, MULTIPLY),
                        new MenuOption("divide", listener, DIVIDE)
                };
                MenuOption.menu(regCalc);
            }
        })};
        MenuOption.menu(loginMenu);
    }

    public static void insertNumber(int num) {
        sum += num;
        if (atLeastOneNumber) {
            if (num > max)
                max = num;
            else if (num < min)
                min = num;
        } else {
            min = max = num;
            atLeastOneNumber = true;
        }
    }
}
