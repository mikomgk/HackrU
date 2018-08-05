package com.example.hackeru.daynightbackground;

import android.app.Activity;
import android.os.Bundle;
import android.widget.LinearLayout;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        LinearLayout mainLayout = findViewById(R.id.mainLayout);
        mainLayout.setBackgroundResource(isMorning() ? R.color.dayColor : R.color.nightColor);
    }

    public static boolean isMorning() {
        if ((System.currentTimeMillis()/3600000) % 24 < 12 )
            return true;
        return false;
    }
}
