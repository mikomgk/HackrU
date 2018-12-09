package com.example.miko.train;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.support.wear.widget.WearableLinearLayoutManager;
import android.support.wear.widget.WearableRecyclerView;
import android.support.wearable.activity.WearableActivity;
import android.view.MotionEvent;

public class MainActivity extends WearableActivity {

    private WearableRecyclerView fromRecyclerView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        String[] list = {"ads","das","ads","das","ads","das","ads","das","ads","das","ads","das"};

        CustomScrollingLayoutCallback customScrollingLayoutCallback = new CustomScrollingLayoutCallback();
        RecyclerViewAdapter adapter = new RecyclerViewAdapter(list);
        fromRecyclerView = findViewById(R.id.from_recycler_view);
        fromRecyclerView.setAdapter(adapter);
        fromRecyclerView.setLayoutManager(new WearableLinearLayoutManager(this));//, customScrollingLayoutCallback));
        fromRecyclerView.setEdgeItemsCenteringEnabled(true);
        fromRecyclerView.addOnItemTouchListener(new RecyclerView.OnItemTouchListener() {
            @Override
            public boolean onInterceptTouchEvent(@NonNull RecyclerView recyclerView, @NonNull MotionEvent motionEvent) {
                return false;
            }

            @Override
            public void onTouchEvent(@NonNull RecyclerView recyclerView, @NonNull MotionEvent motionEvent) {

            }

            @Override
            public void onRequestDisallowInterceptTouchEvent(boolean b) {

            }
        });

        // Enables Always-on
        setAmbientEnabled();
    }
}
