package com.example.miko.train;

import android.content.Context;
import android.content.Intent;
import android.support.wear.widget.WearableLinearLayoutManager;
import android.support.wear.widget.WearableRecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

public class StationRecyclerView extends View {

    private WearableRecyclerView fromRecyclerView;

    public StationRecyclerView(Context context) {
        super(context);
        ViewGroup rootView = LayoutInflater.from(context).inflate(R.layout.fragment_screen_slide_page, container, false);

        String[] list = {"ads","das","ads","das","ads","das","ads","das","ads","das","ads","das"};

        CustomScrollingLayoutCallback customScrollingLayoutCallback = new CustomScrollingLayoutCallback();
        RecyclerViewAdapter adapter = new RecyclerViewAdapter(list);
        fromRecyclerView = rootView.findViewById(R.id.from_recycler_view);
        fromRecyclerView.setAdapter(adapter);
        fromRecyclerView.setLayoutManager(new WearableLinearLayoutManager(this.getContext()));//, customScrollingLayoutCallback));
        fromRecyclerView.setEdgeItemsCenteringEnabled(true);
        RecyclerViewItemClickListener listener = new RecyclerViewItemClickListener(this.getContext(), fromRecyclerView, new RecyclerViewItemClickListener.OnItemClickListener() {
            @Override
            public void onItemClick(View view, String data, int position) {
                Intent intent = new Intent();
                intent.putExtra("from", data);
                startActivity(intent);
            }

            @Override
            public void onLongItemClick(View view, String data, int position) {
                Intent intent = new Intent();
                intent.putExtra("from", data);
            }
        });


    }
}
