package com.example.hackeru.loginapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class SecondActivity extends Activity {

    private String userName;
    private String password;
    private TextView helloBox;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);

        Intent intent=getIntent();
        helloBox=findViewById(R.id.myText);
        userName=intent.getStringExtra("username");
        password=intent.getStringExtra("password");
        helloBox.setText("Hello "+userName);
    }
}
