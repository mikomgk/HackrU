package com.example.hackeru.listapp;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    private ListView listNum;
    private ArrayAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        List<Integer> a=new ArrayList();
        for (int i = 0; i < 100; i++) {
            a.add(i,i);
        }

        listNum=findViewById(R.id.listNum);
        adapter=new myAdapter(this,a);
        listNum.setAdapter(adapter);
        listNum.setOnItemClickListener(new AdapterView.OnItemClickListener(){

            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Toast.makeText(MainActivity.this, "You clicked "+i, Toast.LENGTH_SHORT).show();
            }
        });
    }
}
