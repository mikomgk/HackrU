package com.example.miko.train;

import android.os.Bundle;
import android.support.wear.widget.WearableLinearLayoutManager;
import android.support.wear.widget.WearableRecyclerView;
import android.support.wearable.activity.WearableActivity;

public class MainActivity extends WearableActivity {

    private WearableRecyclerView fromRecyclerView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        String[] list = {"ads","das","ads","das","ads","das","ads","das","ads","das","ads","das"};

        CustomScrollingLayoutCallback customScrollingLayoutCallback = new CustomScrollingLayoutCallback();
        fromRecyclerView = findViewById(R.id.from_recycler_view);
        fromRecyclerView.setLayoutManager(new WearableLinearLayoutManager(this, customScrollingLayoutCallback));
        fromRecyclerView.setEdgeItemsCenteringEnabled(true);
        RecyclerViewAdapter adapter = new RecyclerViewAdapter(list);
        fromRecyclerView.setAdapter(adapter);

        // Enables Always-on
        setAmbientEnabled();
    }
}
