package com.example.miko.myfirstapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class SecondActivity extends Activity {

    public static final int SECOND_ACTIVITY_REQUEST_CODE = 52;
    public static final String ACTIVITY = "activity";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);
        Intent intent = getIntent();
        String activity = intent.getStringExtra(ACTIVITY);
        if (activity.equals("3")) {
            intent = new Intent(this, ThirdActivity.class);
            startActivityForResult(intent, SECOND_ACTIVITY_REQUEST_CODE);
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if(requestCode==SECOND_ACTIVITY_REQUEST_CODE) {
            if (resultCode == RESULT_OK) {
                if(data.getStringExtra(ACTIVITY).equals("1"))
                    finish();
            }
        }
    }

    public void go2ToMainActivity(View view) {
        finish();
    }

    public void go2ThirdActivity(View view) {
        Intent intent =new Intent(this,ThirdActivity.class);
        startActivityForResult(intent, SECOND_ACTIVITY_REQUEST_CODE);
    }
}
