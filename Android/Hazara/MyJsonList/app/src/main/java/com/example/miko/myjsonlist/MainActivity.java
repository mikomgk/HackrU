package com.example.miko.myjsonlist;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;

public class MainActivity extends AppCompatActivity {

    ImageView imageView;
    Button nextBtn;
    TextView timeFin;
    JSONObject json;
    long time;
    long time1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        imageView = findViewById(R.id.image);
        nextBtn = findViewById(R.id.nextBtn);
        timeFin=findViewById(R.id.timeFin);
    }

    @SuppressLint("StaticFieldLeak")
    @Override
    protected void onStart() {
        super.onStart();

        new AsyncTask<String, Void, Bitmap>() {
            @Override
            protected void onPreExecute() {
                time=System.currentTimeMillis();
            }

            @Override
            protected Bitmap doInBackground(String... strings) {
                try (InputStream is = new URL(strings[0]).openConnection().getInputStream()) {
                    return BitmapFactory.decodeStream(is);
                } catch (Exception e) {
                    Log.d("MIKO", "Failed: " + e.toString());
                    e.printStackTrace();
                }
                return null;
            }

            @Override
            protected void onPostExecute(Bitmap bitmap) {
                imageView.setImageBitmap(bitmap);
                time=System.currentTimeMillis()-time;
                nextBtn.setText(String.valueOf(time));
            }
        }.execute("https://upload.wikimedia.org/wikipedia/en/thumb/2/23/Deadpool_%282016_poster%29.png/220px-Deadpool_%282016_poster%29.png");

        new AsyncTask<String,Void,JSONObject>(){

        @Override
        protected JSONObject doInBackground(String... strings) {
            try {
                return new HttpRequest(strings[0]).prepare().sendAndReadJSON();
            } catch (JSONException | IOException e) {
                e.printStackTrace();
            }
            return null;
        }

        @Override
        protected void onPostExecute(JSONObject jSONObject) {
            json=jSONObject;
            nextBtn.setText("Next");
        }
    }.execute("https://api.coinmarketcap.com/v2/listings/");
    }

    public void go2List(View view) {
        Intent intent=new Intent(getBaseContext(),ListActivity.class);
        intent.putExtra("MyJson",json.toString());
        startActivity(intent);
    }
}
