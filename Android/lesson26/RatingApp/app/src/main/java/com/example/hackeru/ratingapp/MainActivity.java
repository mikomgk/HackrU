package com.example.hackeru.ratingapp;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends Activity {

    private ViewGroup mainLayout;
    List<MyRatingLayout> questions = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mainLayout=findViewById(R.id.mainLayout);
        String[] lblQuestions={"dsa","fdsd","Fdsfds"};

        LinearLayout.LayoutParams layoutParams=new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,ViewGroup.LayoutParams.WRAP_CONTENT);

        for (int i = 0; i < lblQuestions.length; i++) {
            MyRatingLayout myRatingLayout=new MyRatingLayout(this,lblQuestions[i]);
            mainLayout.addView(myRatingLayout,layoutParams);
            questions.add(myRatingLayout);
        }

        Button checkBtn=new Button(this);
        checkBtn.setText("Check");
        checkBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                for (int i = 0; i < questions.size(); i++) {
                    Log.d("MIKO",String.valueOf(questions.get(i).getValue()));
                }
            }
        });
        mainLayout.addView(checkBtn,layoutParams);
    }
}
