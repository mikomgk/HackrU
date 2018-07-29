package com.example.hackeru.buttonapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends Activity {

    int x = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void pushBtn(View view) {
        System.out.println(x++);
    }

    public void btnO(View view) {
        Intent intent = new Intent(this, OActivity.class);
        startActivity(intent);
    }

    public void btnX(View view) {
        Intent intent = new Intent(this, XActivity.class);
        startActivity(intent);
    }
}
