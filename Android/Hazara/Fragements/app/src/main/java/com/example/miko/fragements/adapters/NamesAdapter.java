package com.example.miko.fragements.adapters;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

public class NamesAdapter extends BaseAdapter {

    private Context context;
    private String[] names;

    public NamesAdapter(Context context, String[] names) {
        this.context = context;
        this.names = names;
    }

    @Override
    public int getCount() {
        return names.length;
    }

    @Override
    public String getItem(int i) {
        return names[i];
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        if(view==null)
            view=new TextView(context);
        ((TextView)view).setText(names[i]);
        return view;
    }
}
