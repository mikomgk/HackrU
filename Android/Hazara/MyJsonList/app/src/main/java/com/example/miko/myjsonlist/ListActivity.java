package com.example.miko.myjsonlist;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class ListActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list);

        TextView list=findViewById(R.id.list);

        Intent intent=getIntent();
        try {
            JSONObject jsonObject=new JSONObject(intent.getStringExtra("MyJson"));
            JSONArray jsonArr=jsonObject.getJSONArray("data");
            list.setText(jsonArr.getJSONObject(0).getString("name")+" "+jsonArr.getJSONObject(1).getString("name"));
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }
}
