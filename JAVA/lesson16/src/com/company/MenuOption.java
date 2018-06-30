package com.company;

import java.util.Scanner;

import static com.company.Main.Operator.*;
import static java.lang.System.exit;

public class MenuOption {
    private String label;
    private OptionSelectedListener listener;
    private Main.Operator val;

    public MenuOption(String label, OptionSelectedListener listener) {
        this(label, listener, NONE);
    }

    public MenuOption(String label, OptionSelectedListener listener, Main.Operator val) {
        this.label = label;
        this.listener = listener;
        this.val = val;
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

    public interface OptionSelectedListener {
        void optionSelected(Main.Operator val);
    }

    public static void menu(MenuOption[] menuOptions) {
        System.out.println("0. EXIT");
        for (int i = 0; i < menuOptions.length; i++) {
            System.out.println((i + 1) + ". " + menuOptions[i].label);
        }
        int option = getIntFromUser("Select yout option", 0, menuOptions.length);
        if (option == 0) {
            System.out.println("bye bye...");
            exit(0);
        }
        menuOptions[option - 1].getListener().optionSelected(menuOptions[option - 1].val);
        menu(menuOptions);
    }

    public static int getIntFromUser(String message) {
        return getIntFromUser(message, Integer.MIN_VALUE, Integer.MAX_VALUE);
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
}
