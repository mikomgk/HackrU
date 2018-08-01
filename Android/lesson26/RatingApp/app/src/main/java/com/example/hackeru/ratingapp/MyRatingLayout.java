package com.example.hackeru.ratingapp;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.CheckBox;
import android.widget.FrameLayout;
import android.widget.TextView;
import android.widget.Toast;

public class MyRatingLayout extends FrameLayout {

    private int value;
    private TextView lblQuestion;
    private int stars=10;

    public MyRatingLayout(Context context,String question) {
        super(context);

        LayoutInflater layoutInflater=(LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View view=layoutInflater.inflate(R.layout.rating,this,false);
        addView(view);
        for (int i = 1; i <= stars; i++) {
            findViewWithTag(String.valueOf(i)).setOnClickListener(listener);
        }
        lblQuestion=view.findViewById(R.id.lblQuestion);
        setLblQuestion(question);
    }

    private OnClickListener listener=new OnClickListener() {
        @Override
        public void onClick(View view) {
            value = Integer.parseInt(view.getTag().toString());
            setStars();
        }
    };

    private void setStars() {
        for (int i = 1; i <= stars; i++)
            ((CheckBox)findViewWithTag(String.valueOf(i))).setChecked(i<=value);
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public String getLblQuestion() {
        return lblQuestion.getText().toString();
    }

    public void setLblQuestion(String lblQuestion) {
        this.lblQuestion.setText(lblQuestion);
    }
}
