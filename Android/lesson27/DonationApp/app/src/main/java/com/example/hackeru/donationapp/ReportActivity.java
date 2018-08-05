package com.example.hackeru.donationapp;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;

import java.util.List;

public class ReportActivity extends Activity {

    LinearLayout reportMainLayout;
    List<Donate> donates;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_report);

        donates=Donate.getDonates();
        reportMainLayout=findViewById(R.id.reportMainLayout);
        LinearLayout.LayoutParams layoutParams=new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        Donate d;
        for(int i=0;i<donates.size();i++){
            d=donates.get(i);
            ReportItemLayout reportItemLayout=new ReportItemLayout(this,d.getAmount(),d.getType());
            reportMainLayout.addView(reportItemLayout,layoutParams);
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_report,menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()){
            case R.id.donate:
                finish();
        }
        return super.onOptionsItemSelected(item);
    }
}
