package com.example.miko.lunchlog;

import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.app.DialogFragment;
import android.support.v4.app.Fragment;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private Fragment homeFragment;
    private Fragment logFragment;
    private Fragment statsFragment;
    private int currentFragment;

    private BottomNavigationView.OnNavigationItemSelectedListener mOnNavigationItemSelectedListener
            = new BottomNavigationView.OnNavigationItemSelectedListener() {

        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem item) {
            switch (item.getItemId()) {
                case R.id.navigation_home:
                    replaceFragment(homeFragment);
                    return true;
                case R.id.navigation_log:
                    replaceFragment(logFragment);
                    return true;
                case R.id.navigation_stats:
                    replaceFragment(statsFragment);
                    return true;
            }
            return false;
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        FloatingActionButton fab = findViewById(R.id.fab);
        fab.setOnClickListener((View view) -> {
            AddFragment addFragment=new AddFragment();
            addFragment.setTtl("Enter Lunch");
            addFragment.setStyle(DialogFragment.STYLE_NORMAL,R.style.Theme_AppCompat_DayNight_Dialog);
            addFragment.show(getSupportFragmentManager(),"");
        });

        BottomNavigationView navigation = findViewById(R.id.navigation);
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener);

        homeFragment = new HomeFragment();
        logFragment = new LogFragment();
        statsFragment = new StatsFragment();

        replaceFragment(homeFragment);
    }

    private void replaceFragment(Fragment newFrag) {
        getSupportFragmentManager()
                .beginTransaction()
                .setCustomAnimations(android.R.anim.fade_in, android.R.anim.fade_out)
                .addToBackStack(null)
                .replace(R.id.fragmentContainer, newFrag)
                .commit();
    }

}
