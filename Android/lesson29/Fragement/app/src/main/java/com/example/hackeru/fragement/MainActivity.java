package com.example.hackeru.fragement;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity implements AreYouSure.AreYouSureListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void check(View view) {
        AreYouSure areYouSure=new AreYouSure();
        areYouSure.setName("MIKO");
        areYouSure.setQuestion("Are You Sure?");
        areYouSure.setListener(this);
        areYouSure.show(getFragmentManager(),"");
    }

    @Override
    public void done(boolean answer) {
        TextView textView=findViewById(R.id.text);
        textView.setText(answer?"V":"X");
        textView.setTextColor(getColor(answer?R.color.green:R.color.red));
    }
}
