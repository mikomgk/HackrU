package com.example.hackeru.transportationapp;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import java.util.List;

public class myAdapter extends ArrayAdapter<Integer>{

    private Context context;
    private int positions;


    public myAdapter(@NonNull Context context, List<Integer> a) {
        super(context, R.layout.list_item, a);
        this.context=context;
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        this.positions =position;
        View view = convertView;
        ViewsContainer viewsContainer = null;
        if (view == null) {
            LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            view = inflater.inflate(R.layout.list_item, parent, false);
            viewsContainer = new ViewsContainer();
            viewsContainer.lineNumberLbl = view.findViewById(R.id.lineNumberLbl);
            viewsContainer.upperItemLbl = view.findViewById(R.id.upperItemLbl);
            viewsContainer.lowerItemLbl = view.findViewById(R.id.lowerItemLbl);
            view.setTag(viewsContainer);
        } else
            viewsContainer = (ViewsContainer) view.getTag();
        viewsContainer.lineNumberLbl.setText(""+position);
        viewsContainer.upperItemLbl.setText(""+position+position+position+position);
        viewsContainer.lowerItemLbl.setText(""+position+position+position+position);

        return view;
    }

    static class ViewsContainer{
        TextView lineNumberLbl;
        TextView upperItemLbl;
        TextView lowerItemLbl;
    }
}
