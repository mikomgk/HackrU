package com.example.hackeru.donationapp;

import android.content.Context;
import android.text.InputType;
import android.text.Layout;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;

public class PayPalDetailsLayout extends FrameLayout {

    private EditText passwordTxt;

    public PayPalDetailsLayout(Context context) {
        super(context);

        LayoutInflater layoutInflater=(LayoutInflater)context.getSystemService(context.LAYOUT_INFLATER_SERVICE);
        View view=layoutInflater.inflate(R.layout.pyapal_details,this,false);
        addView(view);
        Button showPasswordBtn=findViewById(R.id.showPasswordBtn);
        passwordTxt=view.findViewById(R.id.passwordTxt);
        showPasswordBtn.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                passwordTxt.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);
            }
        });
    }
}
