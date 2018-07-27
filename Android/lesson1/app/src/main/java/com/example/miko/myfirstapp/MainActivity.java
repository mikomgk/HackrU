package com.example.miko.myfirstapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import static com.example.miko.myfirstapp.SecondActivity.*;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void go2SecondActivity(View view) {
        Intent intent = new Intent(this, SecondActivity.class);
        intent.putExtra(ACTIVITY,view.getTag().toString());
        startActivity(intent);
    }
}
