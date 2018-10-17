package com.example.miko.lunchlog;

import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

public class LogAdapter extends RecyclerView.Adapter<LogViewHolder> {
    private Meal[] meals;

    LogAdapter(Meal[] meals) {
        this.meals = meals;
    }

    @NonNull
    @Override
    public LogViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        LayoutInflater inflater=LayoutInflater.from(viewGroup.getContext());
        View view=inflater.inflate(R.layout.log_item,viewGroup,false);

        return new LogViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull LogViewHolder logViewHolder, int i) {
        logViewHolder.ttlPrice.setText(String.valueOf(meals[i].getPrice()));
        logViewHolder.ttlDescription.setText(meals[i].getDescription());
        logViewHolder.ttlDate.setText(meals[i].getDate());
    }

    @Override
    public int getItemCount() {
        return meals.length;
    }
}

class LogViewHolder extends RecyclerView.ViewHolder{
    public final TextView ttlPrice;
    public final TextView ttlDescription;
    public final TextView ttlDate;

    public LogViewHolder(@NonNull View itemView) {
        super(itemView);
        ttlPrice=itemView.findViewById(R.id.ttlPrice);
        ttlDescription=itemView.findViewById(R.id.ttlDescription);
        ttlDate=itemView.findViewById(R.id.ttlDate);
    }
}
