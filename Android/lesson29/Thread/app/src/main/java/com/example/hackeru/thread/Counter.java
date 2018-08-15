package com.example.hackeru.thread;

import android.content.Context;
import android.widget.Toast;

public class Counter extends Thread {

    private static int count;
    private static boolean running;
    private CounterListener listener;
    private static Counter counterThread;

    private Counter(CounterListener listener) {
        this.count = 100;
        this.listener=listener;
        running=true;
        counterThread=this;
    }

    public static boolean getRunning(){
        return running;
    }

    public static Counter startCounter(CounterListener listener, Context context){
        if(running) {
            Toast.makeText(context, "Counter already running", Toast.LENGTH_SHORT).show();
            return null;
        }
        return new Counter(listener);
    }

    @Override
    public void run() {
        while (count >= 0) {
            if(!running)
                continue;
            listener.onChange(count);
            if (count == 0) {
                running = false;
                counterThread=null;
                break;
            }
            count--;
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public void setListener(CounterListener listener) {
        this.listener = listener;
    }

    public interface CounterListener{
        void onChange(int count);
    }

    public static void stopCounterThread() {
        count = 0;
        counterThread.interrupt();
    }

    public static void pauseCounterThread(boolean pause) {
        running = !pause;
    }
}
