package com.example.hackeru.myclock;

import android.content.Context;
import android.text.Layout;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TimePicker;
import android.widget.Toast;

public class TimePickerView extends FrameLayout {

    TimePicker timePicker;

    public TimePickerView(Context context) {
        super(context);

        LayoutInflater layoutInflater=(LayoutInflater)context.getSystemService(context.LAYOUT_INFLATER_SERVICE);
        View view=layoutInflater.inflate(R.layout.time_picker,this,false);
        addView(view);
        timePicker=findViewById(R.id.timePicker);
        timePicker.setIs24HourView(true);

//        timePicker.setScaleX((float)0.7);
//        timePicker.setScaleY((float)0.7);
        /*findViewById(R.id.okBtn).setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                Toast.makeText(view.getContext(), getHourString(timePicker.getHour(),timePicker.getMinute()), Toast.LENGTH_LONG).show();
            }
        });*/
    }

    public static String getHourString(int h,int m){
        StringBuilder hour=new StringBuilder();
        if(h<10)
            hour.append("0");
        hour.append(h);
        hour.append(":");
        if(m<10)
            hour.append("0");
        hour.append(m);
        return hour.toString();
    }
}
