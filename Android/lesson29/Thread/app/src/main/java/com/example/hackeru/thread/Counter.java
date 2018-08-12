package com.example.hackeru.thread;

public class Counter extends Thread {

    private int count;
    private static boolean running;
    private CounterListener listener;

    private Counter() {
        this.count = 10;
        running=true;
    }

    public static Counter startCounter(){
        if(running)
            return null;
        return new Counter();
    }

    @Override
    public void run() {
        while(count>10) {
            listener.onChange(count);
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
}
