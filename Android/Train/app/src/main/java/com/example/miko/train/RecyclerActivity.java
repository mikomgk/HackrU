package com.example.miko.train;

import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.animation.ValueAnimator;
import android.app.Activity;
import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.support.wear.widget.WearableLinearLayoutManager;
import android.support.wear.widget.WearableRecyclerView;
import android.view.View;
import android.widget.TextView;

public class RecyclerActivity extends Activity {

    private WearableRecyclerView recyclerView;
    private TextView tag;
    private int index;
    private String from;
    private String to;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Intent intent = getIntent();
        index = intent.getIntExtra("index", 1);
        from = intent.getStringExtra("from");
        to = intent.getStringExtra("to");

        setContentView(R.layout.activity_recycler);

        String[] list = {"ads", "das", "ads", "das", "ads", "das", "ads", "das", "ads", "das", "ads", "das"};


        tag = findViewById(R.id.tagTxt);
        recyclerView = findViewById(R.id.from_recycler_view);

        CustomScrollingLayoutCallback customScrollingLayoutCallback = new CustomScrollingLayoutCallback();
        RecyclerViewAdapter adapter = new RecyclerViewAdapter(list);
        recyclerView.setAdapter(adapter);
        recyclerView.setLayoutManager(new WearableLinearLayoutManager(this));//, customScrollingLayoutCallback));
        recyclerView.setEdgeItemsCenteringEnabled(true);
        RecyclerViewItemClickListener listener = new RecyclerViewItemClickListener(this, recyclerView, new RecyclerViewItemClickListener.OnItemClickListener() {
            @Override
            public void onItemClick(View view, String data, int position) {
                onClickAction(data);
            }

            @Override
            public void onLongItemClick(View view, String data, int position) {
                onClickAction(data);
            }
        });
        recyclerView.addOnItemTouchListener(listener);
    }

    @Override
    protected void onResume() {
        super.onResume();
        int screenWidth = Resources.getSystem().getDisplayMetrics().widthPixels;
        float move = screenWidth / 3.5f;
        int delay = 800;
        AnimatorSet animatorSet = new AnimatorSet();
        ValueAnimator fromFadeAnim = ObjectAnimator.ofFloat(recyclerView, "alpha", 0f, 1f);
        fromFadeAnim.setStartDelay(delay + 100);
        fromFadeAnim.setDuration(1200);
        ValueAnimator tagFadeAnim = ObjectAnimator.ofFloat(tag, "alpha", 1f, 0.8f);
        tagFadeAnim.setStartDelay(delay);
        tagFadeAnim.setDuration(800);
        ValueAnimator moveAnim = ObjectAnimator.ofFloat(tag, "translationX", move);
        moveAnim.setStartDelay(delay);
        moveAnim.setDuration(800);
        ValueAnimator scaleXAnim = ObjectAnimator.ofFloat(tag, "scaleX", 0.5f);
        scaleXAnim.setStartDelay(delay);
        scaleXAnim.setDuration(800);
        ValueAnimator scaleYAnim = ObjectAnimator.ofFloat(tag, "scaleY", 0.5f);
        scaleYAnim.setStartDelay(delay);
        scaleYAnim.setDuration(800);
        animatorSet.play(tagFadeAnim).with(moveAnim).with(scaleXAnim).with(scaleYAnim).with(fromFadeAnim);
        animatorSet.start();
    }

    private void onClickAction(String data) {
        Class<?> cs = index == 1 ? RecyclerActivity.class : MainActivity.class;//TODO: change to time picker activity
        if (index == 1)
            from = data;
        if (index == 2)
            to = data;
        Intent intent = new Intent(this, cs);
        intent.putExtra("index", index + 1);
        intent.putExtra("from", from);
        if (to != null && !to.isEmpty())
            intent.putExtra("to", to);
        startActivity(intent);
    }
}
