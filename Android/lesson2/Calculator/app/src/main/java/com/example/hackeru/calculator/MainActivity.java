package com.example.hackeru.calculator;

import android.app.Activity;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import org.w3c.dom.Text;

public class MainActivity extends Activity {

    int paramA,paramB,operand;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }



    public void calculate(View view) {
        EditText paramHolder=(EditText)findViewById(R.id.param);
        int x= Integer.valueOf(paramHolder.getText().toString());
        int o=Integer.valueOf(view.getTag().toString());
        int result=0;
        switch (o){
            case 1:
            case 2:
            case 3:
            case 4:
                paramA=x;
                operand=o;
                paramHolder.setText("");
                break;
            case 5:
                paramB=x;
                switch (operand){
                    case 1:
                        result=paramA+paramB;
                        break;
                    case 2:
                        result=paramA-paramB;
                        break;
                    case 3:
                        result=paramA*paramB;
                        break;
                    case 4:
                        if(paramB!=0)
                            result=paramA/paramB;
                        break;
                }
                paramHolder.setText(String.valueOf(result));
        }
    }
}
