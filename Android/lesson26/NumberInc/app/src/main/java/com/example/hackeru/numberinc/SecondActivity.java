package com.example.hackeru.numberinc;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

public class SecondActivity extends Activity {

    private int num;
    TextView numText;
    private final int TOP = 50;
    private final int BOTTOM = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);

        numText = findViewById(R.id.numText);
        setNum(5);
        printNum();
    }

    public void changeNum(View view) {
        setNum(num + Integer.valueOf(view.getTag().toString()));
        printNum();
    }

    private void printNum() {
        numText.setText(String.valueOf(num));
    }

    public int getNum() {
        return num;
    }

    public void setNum(int newNum) {
        if (newNum > TOP)
            Toast.makeText(this, "Num must be smaller then " + TOP, Toast.LENGTH_SHORT).show();
        else if (newNum < BOTTOM)
            Toast.makeText(this, "Num must be bigger then " + BOTTOM, Toast.LENGTH_SHORT).show();
        else
            this.num = newNum;
    }

    public void sendNumBtn(View view) {
        Intent data = new Intent();
        data.putExtra("number", num);
        setResult(RESULT_OK, data);
        finish();
    }
}
