package com.example.miko.lunchlog;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.RequiresApi;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class LogFragment extends Fragment {

    public static final String LUNCH_LOG = "LunchLog";
    public SQLiteDatabase db;
    public List<Meal> meals;
    public LogAdapter adapter;
    private Context context;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_log, container, false);

        db = new ADBC(context).getWritableDatabase();
        RecyclerView logRecyclerView = view.findViewById(R.id.logRecyclerView);
        logRecyclerView.setLayoutManager(new LinearLayoutManager(getContext()));
        if (meals == null) {
            meals = new ArrayList<>();
            getMealList();
        }
        if (adapter == null)
            adapter = new LogAdapter(meals);
        logRecyclerView.setAdapter(adapter);
        ((MainActivity) getActivity()).setAdapter(adapter);
        return view;
    }

    public void getMealList() {
        Cursor mealsCursor = db.rawQuery("SELECT * FROM meals ORDER BY time DESC", null);
        for (mealsCursor.moveToFirst(); !mealsCursor.isAfterLast(); mealsCursor.moveToNext()) {
            meals.add(new Meal(
                    mealsCursor.getInt(0),
                    mealsCursor.getInt(1),
                    mealsCursor.getString(2),
                    mealsCursor.getLong(3)
            ));
        }
        mealsCursor.close();
        /*meals.sort(new Comparator<Meal>() {
            @Override
            public int compare(Meal meal, Meal t1) {
                return (int) (meal.getDate() - t1.getDate());
            }
        });*/
        ((MainActivity) getActivity()).setMeals(meals);
    }

    public void setContext(Context context) {
        this.context = context;
    }

    public void setMeals(List<Meal> meals) {
        this.meals = meals;
    }

    public void setAdapter(LogAdapter adapter) {
        this.adapter = adapter;
    }
}

class Meal {
    private int mealId;
    private int price;
    private String description;
    private Long date;

    public Meal(int mealId, int price, String description, Long date) {
        this.mealId = mealId;
        this.price = price;
        this.description = description;
        this.date = date;
    }

    public Long getDate() {
        return date;
    }

    public void setDate(Long date) {
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
