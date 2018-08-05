package com.example.hackeru.donationapp;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.TextView;

public class ReportItemLayout extends FrameLayout {

    private int amount;
    private String type;
    private TextView amountLbl;
    private TextView typeLbl;

    public ReportItemLayout(Context context,int amount,String type) {
        super(context);

        this.amount=amount;
        this.type=type;
        LayoutInflater layoutInflater=(LayoutInflater)context.getSystemService(context.LAYOUT_INFLATER_SERVICE);
        View view=layoutInflater.inflate(R.layout.report_item,this,false);
        addView(view);
        amountLbl=findViewById(R.id.amount);
        typeLbl=findViewById(R.id.type);
        amountLbl.setText("$"+String.valueOf(this.amount));
        typeLbl.setText(String.valueOf(this.type));
    }
}
