package com.company.client;

import java.util.Scanner;

import static java.lang.System.exit;

public class MenuOption {
    private String label;
    private OptionSelectedListener listener;
    private static MenuOption[] menuOptions;

    public MenuOption(String label, OptionSelectedListener listener) {
        this.label = label;
        this.listener = listener;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public OptionSelectedListener getListener() {
        return listener;
    }

    public void setListener(OptionSelectedListener listener) {
        this.listener = listener;
    }

    public static MenuOption[] getMenuOptions() {
        return menuOptions;
    }

    public static void setMenuOptions(MenuOption[] menuOption) {
        menuOptions = menuOption;
    }

    public static void menu(){
        System.out.println("0. EXIT");
        for (int i = 0; i < menuOptions.length; i++) {
            System.out.println((i+1)+". "+menuOptions[i].label);
        }
        int option=getIntFromUser("Select your option",0,menuOptions.length);
        if(option==0) {
            System.out.println("bye bye...");
            exit(0);
        }
        menuOptions[option-1].getListener().optionSelected();

    }

    public static int getIntFromUser(String message, int min, int max) {
        System.out.println(message);
        Scanner scan = new Scanner(System.in);
        String optionString = scan.next();
        if (optionString.length() == 0) {
            System.out.println("must enter something...");
            getIntFromUser(message, min, max);
        }
        int option = -1;
        try {
            option = Integer.valueOf(optionString);
        } catch (Exception ex) {
            System.out.println("Invalid number");
            getIntFromUser(message, min, max);
        }
        if (option < min || option > max) {
            System.out.println("not in the menu");
            getIntFromUser(message, min, max);
        }
        return option;
    }

    public interface OptionSelectedListener {
        void optionSelected();
    }
}
