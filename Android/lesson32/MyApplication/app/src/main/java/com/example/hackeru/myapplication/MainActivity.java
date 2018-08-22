package com.example.hackeru.myapplication;

import android.support.v4.app.Fragment;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends AppCompatActivity {

    private MyFrag first;
    private MyFrag second;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        first=new MyFrag();
        second=new MyFrag();
        first.setListener(new Runnable() {
            @Override
            public void run() {
                second.setNameLbl(first.getNameLbl());
            }
        });

        getSupportFragmentManager().beginTransaction().replace(R.id.firstFrag, first).commit();
        getSupportFragmentManager().beginTransaction().replace(R.id.secondFrag, second).commit();


    }

    public void onX(View view) {
        first.changeBackgroundColor(android.R.color.holo_red_light);
        second.setLbl("X");
        second.changeTextColor(getColor(android.R.color.holo_red_light));
    }

    public void onV(View view) {
        first.changeBackgroundColor(android.R.color.holo_green_light);
        second.setLbl("V");
        second.changeTextColor(getColor(android.R.color.holo_green_light));

    }
}
