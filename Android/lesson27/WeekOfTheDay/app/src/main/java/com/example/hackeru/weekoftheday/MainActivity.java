package com.example.hackeru.weekoftheday;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Toast;

public class MainActivity extends Activity {

    private AutoCompleteTextView daySelector;
    private String[] dayNames={"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
    private Day[] days;
    private ArrayAdapter<Day> adapter;

    static class Day{
        private int dayNumber;
        private String name;

        public Day(int dayNumber, String name) {
            this.dayNumber = dayNumber;
            this.name = name;
        }

        @Override
        public String toString() {
            return name;
        }

        public int getDayNumber() {
            return dayNumber;
        }

        public String getName() {
            return name;
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        daySelector=findViewById(R.id.daySelector);
        days=new Day[dayNames.length];
        for (int i = 0; i < dayNames.length; i++) {
            days[i]=new Day(i+1,dayNames[i]);
        }

        adapter=new ArrayAdapter<>(this,android.R.layout.simple_dropdown_item_1line,days);
        daySelector.setThreshold(2);
        daySelector.setAdapter(adapter);

        daySelector.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Day d=adapter.getItem(i);
                if(d.getDayNumber()%2==0)
                    Toast.makeText(MainActivity.this, d.getName()+" is even day", Toast.LENGTH_SHORT).show();
            }
        });
    }
}
