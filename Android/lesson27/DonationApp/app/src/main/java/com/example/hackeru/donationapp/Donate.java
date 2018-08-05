package com.example.hackeru.donationapp;

import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

import static com.example.hackeru.donationapp.MainActivity.*;

public class Donate {
    private int amount;
    private String type;
    private static List<Donate> donates;
    private static int totalDonate;

    static {
        donates = new ArrayList<>();
        totalDonate = 0;
    }

    private Donate(int amount, String type) {
        this.amount = amount;
        this.type = type;
        totalDonate += amount;
        donates.add(this);
    }

    public static Donate donateCreator(int amount, String type) {
        if (totalDonate + amount > DONATION_TARGET)
            return null;
        return new Donate(amount, type);
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public static List<Donate> getDonates() {
        return donates;
    }

    public static int getTotalDonate() {
        return totalDonate;
    }

    public static void checkTotalDonate(int totalDonate) {
        Donate.totalDonate = totalDonate;
    }
}
