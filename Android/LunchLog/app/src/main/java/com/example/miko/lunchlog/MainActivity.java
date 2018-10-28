package com.example.miko.lunchlog;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
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
import android.view.KeyEvent;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.view.WindowManager;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import java.text.DateFormat;
import java.text.FieldPosition;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MainActivity extends AppCompatActivity {

    private Fragment homeFragment;
    private Fragment logFragment;
    private Fragment statsFragment;
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
                addMealBtn(view1.getRootView());
            });
            ((EditText) dialogView.findViewById(R.id.priceInput)).setOnEditorActionListener((textView, actionId, keyEvent) -> {
                boolean handled = false;
                if (actionId == EditorInfo.IME_ACTION_DONE) {
                    addMealBtn(textView.getRootView());
                    handled = true;
                }
                return handled;
            });
            alertDialog.show();
            //openKeyboard(dialogView.findViewById(R.id.descriptionInput));
            //alertDialog.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_VISIBLE);
//            ((InputMethodManager) this.getSystemService(Context.INPUT_METHOD_SERVICE)).toggleSoftInput(
//                    InputMethodManager.RESULT_SHOWN,
//                    InputMethodManager.RESULT_HIDDEN
//            );
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

    private void addMealBtn(View view) {
        EditText description = view.findViewById(R.id.descriptionInput);
        EditText price = view.findViewById(R.id.priceInput);
        addMeal(description.getText().toString(), Integer.valueOf(price.getText().toString()), System.currentTimeMillis());
        Toast.makeText(this, String.valueOf(System.currentTimeMillis()), Toast.LENGTH_LONG).show();
        alertDialog.dismiss();
        //closeKeyboard(view);
//        ((InputMethodManager) this.getSystemService(Context.INPUT_METHOD_SERVICE)).toggleSoftInput(
//                InputMethodManager.RESULT_SHOWN,
//                InputMethodManager.RESULT_HIDDEN
//        );
    }

    private void addMeal(String description, int price, Long date) {

    }

    /*public void showInputMethod() {
        InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.toggleSoftInput(InputMethodManager.SHOW_FORCED, InputMethodManager.HIDE_IMPLICIT_ONLY);
    }

    public static void hideKeyboardFrom(Context context, View view) {
        InputMethodManager imm = (InputMethodManager) context.getSystemService(Activity.INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
    }*/
    private void closeKeyboard(View view) {
        InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
    }

    private void openKeyboard(View view) {
        InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.showSoftInput(view, InputMethodManager.SHOW_IMPLICIT);
    }

}
