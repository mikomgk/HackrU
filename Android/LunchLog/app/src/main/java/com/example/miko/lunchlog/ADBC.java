package com.example.miko.lunchlog;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class ADBC extends SQLiteOpenHelper {

    public static final String dbName="lunch_log";

    public ADBC(Context context) {
        super(context, dbName, null, 1);
    }

    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {
        sqLiteDatabase.execSQL("CREATE TABLE IF NOT EXISTS meals(meal_id INTEGER PRIMARY KEY, price INTEGER NOT NULL, description VARCHAR(10), time INTEGER NOT NULL)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i1) {

    }
}
