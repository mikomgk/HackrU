package com.example.miko.myfirstapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import static com.example.miko.myfirstapp.SecondActivity.*;

public class ThirdActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_third);
    }

    public void go2SecondActivity(View view) {
        Intent data=new Intent();
        data.putExtra(ACTIVITY,view.getTag().toString());
        setResult(RESULT_OK,data);
        finish();
    }
}
