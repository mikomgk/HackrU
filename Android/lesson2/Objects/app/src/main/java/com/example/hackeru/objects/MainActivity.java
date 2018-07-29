package com.example.hackeru.objects;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

public class MainActivity extends Activity {

    public static final String DOG = "dog";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Dog snoopy = new Dog("Snoopy", 12);
        Intent intent=new Intent(this,SecondActivity.class);
        intent.putExtra(DOG,snoopy.toBytes());
        startActivity(intent);
    }
}
