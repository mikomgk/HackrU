package com.example.miko.train;

import android.content.Intent;
import android.os.Bundle;
import android.support.wearable.activity.WearableActivity;

public class MainActivity extends WearableActivity {

    private boolean active = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Enables Always-on
        setAmbientEnabled();

        Intent intent = new Intent(this, RecyclerActivity.class);
        intent.putExtra("index", 1);
        startActivity(intent);
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (active)
            this.finish();
        active = true;
    }
}
