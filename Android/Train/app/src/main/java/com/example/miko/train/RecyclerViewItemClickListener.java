package com.example.miko.train;

import android.content.Context;
import android.os.Bundle;
import android.support.v7.widget.RecyclerView;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.view.View;

public class RecyclerViewItemClickListener implements RecyclerView.OnItemTouchListener {
    private OnItemClickListener mListener;
    private GestureDetector mGestureDetector;
    private RecyclerView recyclerView;

    public RecyclerViewItemClickListener(Context context, final RecyclerView recyclerView, Bundle data) {
        mGestureDetector = new GestureDetector(context, new GestureDetector.SimpleOnGestureListener() {
            @Override
            public boolean onSingleTapUp(MotionEvent e) {
                return true;
            }

            @Override
            public void onLongPress(MotionEvent e) {
                View child = recyclerView.findChildViewUnder(e.getX(), e.getY());
                RecyclerViewAdapter adapter = (RecyclerViewAdapter) recyclerView.getAdapter();
                int index = recyclerView.getChildAdapterPosition(child);
                if (child != null && mListener != null) {
                    mListener.onLongItemClick(child, adapter.getList()[index], index);
                }
            }
        });
    }

    public RecyclerViewItemClickListener(Context context, final RecyclerView recyclerView, OnItemClickListener listener) {
        mListener = listener;
        this.recyclerView = recyclerView;
        mGestureDetector = new GestureDetector(context, new GestureDetector.SimpleOnGestureListener() {
            @Override
            public boolean onSingleTapUp(MotionEvent e) {
                return true;
            }

            @Override
            public void onLongPress(MotionEvent e) {
                View child = recyclerView.findChildViewUnder(e.getX(), e.getY());
                RecyclerViewAdapter adapter = (RecyclerViewAdapter) recyclerView.getAdapter();
                int index = recyclerView.getChildAdapterPosition(child);
                if (child != null && mListener != null) {
                    mListener.onLongItemClick(child, adapter.getList()[index], index);
                }
            }
        });
    }

    @Override
    public boolean onInterceptTouchEvent(RecyclerView view, MotionEvent e) {
        View childView = view.findChildViewUnder(e.getX(), e.getY());
        RecyclerViewAdapter adapter = (RecyclerViewAdapter) recyclerView.getAdapter();
        int index = view.getChildAdapterPosition(childView);
        if (childView != null && mListener != null && mGestureDetector.onTouchEvent(e)) {
            mListener.onItemClick(childView, adapter.getList()[index], index);
            return true;
        }
        return false;
    }

    @Override
    public void onTouchEvent(RecyclerView view, MotionEvent motionEvent) {
    }

    @Override
    public void onRequestDisallowInterceptTouchEvent(boolean disallowIntercept) {
    }


    public interface OnItemClickListener {
        void onItemClick(View view, String data, int position);

        void onLongItemClick(View view, String data, int position);
    }
}