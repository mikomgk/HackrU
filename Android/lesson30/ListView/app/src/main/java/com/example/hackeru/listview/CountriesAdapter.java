package com.example.hackeru.listview;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class CountriesAdapter extends ArrayAdapter<Country> {

    private Country[] countries;
    private Context context;

    public CountriesAdapter(@NonNull Context context, Country[] countries) {
        super(context, R.layout.item_country,countries);
        this.countries = countries;
        this.context = context;
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        View view=convertView;
        ViewContainers viewContainers=null;
        if(view==null){
            LayoutInflater inflater= (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            view=inflater.inflate(R.layout.item_country,parent,false);
            viewContainers=new ViewContainers();
            viewContainers.txtCountryName=view.findViewById(R.id.txtCountryName);
            viewContainers.txtCode=view.findViewById(R.id.txtCode);
            viewContainers.txtDialCode=view.findViewById(R.id.txtDialCode);
            viewContainers.image=view.findViewById(R.id.image);
            view.setTag(viewContainers);
        }else
            viewContainers= (ViewContainers) view.getTag();
        viewContainers.txtCountryName.setText(countries[position].getName());
        viewContainers.txtCode.setText(countries[position].getCode());
        viewContainers.txtDialCode.setText(countries[position].getDialCode());
        viewContainers.image.setImageResource(R.drawable.images);
        return view;
    }

    static class ViewContainers {
        TextView txtCountryName;
        TextView txtCode;
        TextView txtDialCode;
        ImageView image;
    }
}
