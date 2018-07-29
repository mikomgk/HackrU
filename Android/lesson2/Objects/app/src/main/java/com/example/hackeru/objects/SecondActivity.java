package com.example.hackeru.objects;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;

import static com.example.hackeru.objects.MainActivity.DOG;

public class SecondActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);

        Toast.makeText(this, new Dog(getIntent().getByteArrayExtra(DOG)).toString(), Toast.LENGTH_LONG).show();
    }
}
