package com.example.miko.train;

import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.MotionEvent;

public class RecyclerViewOnItemClickListener implements RecyclerView.OnItemTouchListener {


    @Override
    public boolean onInterceptTouchEvent(@NonNull RecyclerView recyclerView, @NonNull MotionEvent motionEvent) {
        return false;
    }

    @Override
    public void onTouchEvent(@NonNull RecyclerView recyclerView, @NonNull MotionEvent motionEvent) {
        Intent intent = new Intent();
        intent.
    }

    @Override
    public void onRequestDisallowInterceptTouchEvent(boolean b) {

    }
}
