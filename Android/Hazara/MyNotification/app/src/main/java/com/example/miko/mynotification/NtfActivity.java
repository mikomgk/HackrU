package com.example.miko.mynotification;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.widget.TextView;

public class NtfActivity extends AppCompatActivity {

    private RecyclerView coinsList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ntf);

        coinsList = findViewById(R.id.coinsList);
    }

    @Override
    protected void onStart() {
        super.onStart();

        String data = getIntent().getStringExtra(NtfService.MY_DATA);
        if (data != null){
            CoinsAdapter adapter=new CoinsAdapter(data);
            coinsList.setAdapter(adapter);
            coinsList.setLayoutManager(new LinearLayoutManager(this));
        }
    }
}
