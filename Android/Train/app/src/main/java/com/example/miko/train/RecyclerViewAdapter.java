package com.example.miko.train;

import android.support.annotation.NonNull;
import android.support.wear.widget.WearableRecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

public class RecyclerViewAdapter extends WearableRecyclerView.Adapter<ListViewHolder> {
    private String[] list;

    @NonNull
    @Override
    public ListViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        LayoutInflater inflater = LayoutInflater.from(viewGroup.getContext());
        View view = inflater.inflate(R.layout.list_cell_layout,viewGroup,false);
        return new ListViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ListViewHolder listViewHolder, int i) {
        listViewHolder.titleView.setText(list[i]);
        listViewHolder.imageView.setImageResource(R.mipmap.ic_launcher);
    }

    @Override
    public int getItemCount() {
        return list.length;
    }

    public RecyclerViewAdapter(String[] list) {
        this.list = list;
    }

    public String[] getList() {
        return list;
    }

    public void setList(String[] list) {
        this.list = list;
    }
}

class ListViewHolder extends WearableRecyclerView.ViewHolder{
    final TextView titleView;
    final ImageView imageView;

    public ListViewHolder(@NonNull View itemView) {
        super(itemView);
        titleView = itemView.findViewById(R.id.textList);
        imageView = itemView.findViewById(R.id.listImage);
    }
}
