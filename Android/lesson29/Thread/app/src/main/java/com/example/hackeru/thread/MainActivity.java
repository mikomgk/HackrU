package com.example.hackeru.thread;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends Activity implements Counter.CounterListener{

    private Handler handler=new Handler();
    private int counter;
    private TextView counterTxt;
    private Button start,pause,stop;
    private Counter counterThread;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        counterTxt = findViewById(R.id.counter);
        start = findViewById(R.id.start);
        stop = findViewById(R.id.stop);
        pause = findViewById(R.id.pause);
    }

    public void startCounter(View view) {
        counterThread = Counter.startCounter(this,this);
        if (counterThread != null) {
            counterThread.start();
            changeBtns(false);
            counterTxt.setVisibility(View.VISIBLE);
        }
    }

    public void changeBtns(boolean showStart) {
        start.setVisibility(showStart ? View.VISIBLE : View.GONE);
        pause.setVisibility(showStart ? View.GONE : View.VISIBLE);
        stop.setVisibility(showStart ? View.GONE : View.VISIBLE);
    }

    @Override
    public void onChange(int count) {
        this.counter=count;
        handler.post(new Runnable() {
            @Override
            public void run() {
                counterTxt.setText(String.valueOf(counter));
                if(counter==0) {
                    counterTxt.setVisibility(View.INVISIBLE);
                    changeBtns(true);
                }
            }
        });
    }

    public void stopCounter(View view) {
        Counter.stopCounterThread();
        changeBtns(true);
    }

    public void pauseCounter(View view) {
        if (Counter.getRunning()) {
            Counter.pauseCounterThread(true);
            pause.setText(getString(R.string.play));
        } else {
            Counter.pauseCounterThread(false);
            pause.setText(getString(R.string.pause));
        }
    }
}
