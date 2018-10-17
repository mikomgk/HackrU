package com.example.miko.lunchlog;

import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import java.util.ArrayList;
import java.util.List;

public class LogFragment extends Fragment {

    public SQLiteDatabase db;
    public static final String LUNCH_LOG = "LunchLog";

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_log, container, false);

        RecyclerView logRecyclerView = view.findViewById(R.id.logRecyclerView);
        logRecyclerView.setLayoutManager(new LinearLayoutManager(getContext()));

        List<Meal> meals=new ArrayList<>();
        db = new ADBC(getContext(), LUNCH_LOG).getReadableDatabase();
        Cursor mealsCursor = db.rawQuery("SELECT meal_id,price,description,time FROM meals",null);

        for(mealsCursor.moveToFirst();!mealsCursor.isAfterLast();mealsCursor.moveToNext()){
            meals.add(new Meal(
                    mealsCursor.getInt(0),
                    mealsCursor.getInt(1),
                    mealsCursor.getString(2),
                    mealsCursor.getString(3)
            ));
        }
        mealsCursor.close();

        logRecyclerView.setAdapter(new LogAdapter(meals.toArray(new Meal[0])));

        return view;
    }
}

class Meal {
    private int mealId;
    private int price;
    private String description;
    private String date;

    public Meal(int mealId, int price, String description, String date) {
        this.mealId = mealId;
        this.price = price;
        this.description = description;
        this.date = date;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getMealId() {
        return mealId;
    }

    public void setMealId(int mealId) {
        this.mealId = mealId;
    }
}
