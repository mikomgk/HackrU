package com.example.miko.fragements;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.Icon;
import android.os.Build;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends AppCompatActivity implements NamesFragment.OnNameSelected {

    NotificationManager ntfMngr;
    public static final int NTF_ID =1;
    public static final String CHAN_NAME ="My Notifications";
    public static final String DESC="My description";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        NamesFragment fragment=new NamesFragment();
        fragment.setOnNameSelected(this);
        getSupportFragmentManager().beginTransaction().addToBackStack(null).replace(R.id.fragmentContainer,fragment).commit();

        ntfMngr= (NotificationManager) getSystemService(NOTIFICATION_SERVICE);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            String name = CHAN_NAME;
            NotificationChannel channel = new NotificationChannel(CHAN_NAME, name, NotificationManager.IMPORTANCE_HIGH);
            ntfMngr.createNotificationChannel(channel);
        }
    }

    @Override
    public void onNameSelectedListener(String name) {
        NameSelectedFragment fragment=new NameSelectedFragment();
        fragment.setName(name);
        getSupportFragmentManager().beginTransaction().addToBackStack(null).replace(R.id.fragmentContainer,fragment).commit();
    }

    public void myNotify(View view) {
        Notification ntf =new Notification.Builder(this, CHAN_NAME)
                .setContentTitle("My Notification")
                .setSmallIcon(R.drawable.ic_launcher_foreground)
                .setContentText("My first notify")
                .setLargeIcon(BitmapFactory.decodeResource(getResources(), R.mipmap.ic_launcher))
                .build();
        ntfMngr.notify(NTF_ID,ntf);
    }
}
