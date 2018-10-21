package com.example.miko.lunchlog;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
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
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    private Fragment homeFragment;
    private Fragment logFragment;
    private Fragment statsFragment;
    private int currentFragment;
    private AlertDialog alertDialog;

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
            alertDialog = new AlertDialog.Builder(this).create();
            View dialogView = getLayoutInflater().inflate(R.layout.fragment_add, null, false);
            alertDialog.setView(dialogView);
            dialogView.findViewById(R.id.addBtn).setOnClickListener(view1 -> {
                Toast.makeText(this, "New meal added!", Toast.LENGTH_LONG).show();
                alertDialog.dismiss();
            });
            alertDialog.show();
        });

        new Intent(Intent.ACTION_WEB_SEARCH).setClassName()

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
