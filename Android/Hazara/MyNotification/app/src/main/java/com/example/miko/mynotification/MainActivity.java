package com.example.miko.mynotification;

import android.app.Notification;
import android.app.NotificationManager;
import android.content.Intent;
import android.content.IntentFilter;
import android.support.v4.app.NotificationBuilderWithBuilderAccessor;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class MainActivity extends AppCompatActivity {
    public static final String DEFAULT_NTF_CHANNEL = "defaultChannel";
    public static final int WELCOME_NTF = 2;
    public static final String CAN_ID = "myChan";
    public static final String CAN_NAME = "my channel";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        (new NTFHandler(this, WELCOME_NTF, CAN_ID, CAN_NAME, NotificationManager.IMPORTANCE_HIGH)).ntfCreator(getString(R.string.app_name), "Welcome Back").ntfBuild().ntfNotify();
    }

    @Override
    protected void onStart() {
        super.onStart();

        registerReceiver(new NtfReceiver(), new IntentFilter("MyBGAction"));
        startService(new Intent(this, NtfService.class));
    }
}
