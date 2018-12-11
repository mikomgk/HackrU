package com.example.miko.train;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.wear.widget.WearableLinearLayoutManager;
import android.support.wear.widget.WearableRecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

public class ScreenSlidePageFragment extends Fragment {

    private WearableRecyclerView fromRecyclerView;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        ViewGroup rootView = (ViewGroup) inflater.inflate(R.layout.fragment_screen_slide_page, container, false);

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



        return rootView;
    }
}