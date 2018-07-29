package com.company;

import java.awt.*;

import static java.lang.System.currentTimeMillis;

public class MotionDetector {
    private OnDetectionListener listener;

    public void setListener(OnDetectionListener listener) {
        this.listener = listener;
    }

    public void runForEver() {
        long z=currentTimeMillis();
        while (true)
            while ((currentTimeMillis()-z) % 500 == 0) {
                PointerInfo a = MouseInfo.getPointerInfo();
                Point b = a.getLocation();
                int x = (int) b.getX();
                int y = (int) b.getY();

                if (listener != null)
                    listener.onDetection(x,y);
            }
    }

    interface OnDetectionListener {
        void onDetection(int x, int y);
    }
}
