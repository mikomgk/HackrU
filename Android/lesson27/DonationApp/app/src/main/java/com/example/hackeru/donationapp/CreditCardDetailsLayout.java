package com.example.hackeru.donationapp;

import android.content.Context;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;

public class CreditCardDetailsLayout extends FrameLayout {

    private EditText cardNumberTxt;

    public CreditCardDetailsLayout(Context context) {
        super(context);

        LayoutInflater layoutInflater=(LayoutInflater)context.getSystemService(context.LAYOUT_INFLATER_SERVICE);
        View view=layoutInflater.inflate(R.layout.pyapal_details,this,false);
        addView(view);
        cardNumberTxt=view.findViewById(R.id.cardNumber);
        cardNumberTxt.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                
            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        });
    }
}
