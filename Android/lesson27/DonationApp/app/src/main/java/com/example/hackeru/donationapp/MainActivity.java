package com.example.hackeru.donationapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.NumberPicker;
import android.widget.ProgressBar;
import android.widget.RadioGroup;
import android.widget.Toast;

public class MainActivity extends Activity {

    public static final int MIN_DONATE = 1;
    public static final int MAX_DONATE = 500;
    public static final int DONATION_TARGET = 1000;
    private RadioGroup typeOptions;
    private NumberPicker amountPicker;
    private ProgressBar progressBar;
    private Button sendBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        typeOptions = findViewById(R.id.typeChooser);
        amountPicker = findViewById(R.id.amountPicker);
        progressBar = findViewById(R.id.progresBar);
        sendBtn = findViewById(R.id.sendBtn);

        amountPicker.setMinValue(MIN_DONATE);
        amountPicker.setMaxValue(MAX_DONATE);
        progressBar.setMax(DONATION_TARGET);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_donate, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()){
            case (R.id.report):
                Intent intent=new Intent(this,ReportActivity.class);
                startActivity(intent);
        }
        return super.onOptionsItemSelected(item);
    }

    public void sendDonation(View view) {
        int typeSelectedID = typeOptions.getCheckedRadioButtonId();
        if(typeSelectedID==-1){
            Toast.makeText(this, "Didn't select type", Toast.LENGTH_SHORT).show();
            return;
        }
        int newAmount = amountPicker.getValue();
        String type = "";
        if (typeSelectedID == R.id.PayPal)
            type = getString(R.string.paypal);
        if (typeSelectedID == R.id.CreditCard)
            type = getString(R.string.creditcard);
        if(Donate.donateCreator(newAmount,type)==null) {
            Toast.makeText(this, "Donation not allowed to be more then $1000", Toast.LENGTH_SHORT).show();
            return;
        }
        progressBar.setProgress(Donate.getTotalDonate());
        Toast.makeText(this, "Total so Far $" + Donate.getTotalDonate(), Toast.LENGTH_SHORT).show();
    }
}
