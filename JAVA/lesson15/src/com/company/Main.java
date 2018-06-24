package com.company;

public class Main {

    public static void main(String[] args) {
        MotionDetector m = new MotionDetector();
        m.setListener(new MotionDetector.OnDetectionListener() {
            @Override
            public void onDetection(int x, int y) {
                System.out.println(x+","+y);
                System.out.println("motion!!!");
                if (x > 900 && y <= 400)
                    System.out.println("on the top right!!      1\n");
                if (x <= 900 && y <= 400)
                    System.out.println("on the top left!!       2\n");
                if (x <= 900 && y > 400)
                    System.out.println("on the bottom left!!    3\n");
                if (x > 900 && y > 400)
                    System.out.println("on the bottom right!!   4\n");
            }
        });
        m.runForEver();
    }

}
