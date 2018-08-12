package com.example.hackeru.loginapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.InputType;
import android.view.MotionEvent;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import java.util.HashMap;
import java.util.Map;

public class MainActivity extends Activity {

    private Map<String, String> users;
    private String userName;
    private String password;
    private TextView commentRed;
    private TextView commentGreen;
    private EditText passwordBox;
    private TextView viewPassword;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        users = new HashMap<>();
        passwordBox=findViewById(R.id.passInput);
        userName = ((EditText) findViewById(R.id.userInput)).getText().toString();
        password = passwordBox.getText().toString();
        commentRed =findViewById(R.id.commentRed);
        commentGreen =findViewById(R.id.commentGreen);
        viewPassword=findViewById(R.id.viewPasswordBtn);
        viewPassword.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent motionEvent) {

                return false;
            }
        });
    }

    public void loginBtn(View view) {
        getDetails();
        if (users.containsKey(userName)) {
            Intent intent=new Intent(this,SecondActivity.class);
            intent.putExtra("username",userName);
            intent.putExtra("password",password);
            startActivity(intent);
        }
        else {
            commentRed.setText("User Not Exist");
            viewRed();
        }
    }

    public void signUpBtn(View view) {
        getDetails();
        if (users.containsKey(userName)) {
            commentRed.setText("User Already Exist");
            viewRed();
        }
        else {
            users.put(userName, password);
            commentGreen.setText("Sign Up Successfully");
            viewGreen();
        }
    }

    public void getDetails(){
        userName = ((EditText) findViewById(R.id.userInput)).getText().toString();
        password = ((EditText) findViewById(R.id.passInput)).getText().toString();
    }

    public void viewRed(){
        commentGreen.setVisibility(View.INVISIBLE);
        commentRed.setVisibility(View.VISIBLE);
    }

    public void viewGreen(){
        commentRed.setVisibility(View.INVISIBLE);
        commentGreen.setVisibility(View.VISIBLE);
    }

    public void viewPasswordBtn(View view) {
        passwordBox.setInputType(InputType.TYPE_CLASS_TEXT);
    }
}
