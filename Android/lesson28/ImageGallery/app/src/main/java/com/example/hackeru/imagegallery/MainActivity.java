package com.example.hackeru.imagegallery;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends Activity {

    private int currentPic = 0;
    private List<ImageView> images;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        FrameLayout frameLayout = findViewById(R.id.frameLayout);
        images = new ArrayList<>();
        for (int i = 0; i < frameLayout.getChildCount(); i++) {
            images.add((ImageView) frameLayout.getChildAt(i));
        }
        showPic();
    }

    public void changePic(View view) {
        currentPic += Integer.valueOf(view.getTag().toString());
        currentPic %= images.size();
        showPic();
    }

    public void showPic() {
        ImageView iV;
        for (int i = 0; i < images.size(); i++) {
            iV = images.get(i);
            iV.setVisibility(Integer.valueOf(iV.getTag().toString()) - 1 == currentPic ? View.VISIBLE : View.INVISIBLE);
        }
        ((TextView) findViewById(R.id.text)).setText("CAR" + (currentPic + 1));
    }
}
