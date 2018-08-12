package com.example.hackeru.thread;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.TextView;

public class MainActivity extends Activity implements Counter.CounterListener{

    private Handler handler=new Handler();
    private int counter;
    private TextView counterTxt;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        counterTxt=findViewById(R.id.counter);
    }

    public void startCounter(View view) {
        Counter.startCounter().start();
    }

    @Override
    public void onChange(int count) {
        this.counter=count;
        handler.post(new Runnable() {
            @Override
            public void run() {
                counterTxt.setText(String.valueOf(counter));
            }
        });
    }
}
