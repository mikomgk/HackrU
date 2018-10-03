package com.example.miko.fragements;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class MainActivity extends AppCompatActivity implements NamesFragment.OnNameSelected {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        NamesFragment fragment=new NamesFragment();
        fragment.setOnNameSelected(this);
        getSupportFragmentManager().beginTransaction().addToBackStack(null).replace(R.id.fragmentContainer,fragment).commit();
    }

    @Override
    public void onNameSelectedListener(String name) {
        NameSelectedFragment fragment=new NameSelectedFragment();
        fragment.setName(name);
        getSupportFragmentManager().beginTransaction().addToBackStack(null).replace(R.id.fragmentContainer,fragment).commit();
    }
}
