package com.example.miko.mynotification;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.util.Log;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

public class NtfService extends Service implements Runnable {

    private static final int times = 10;
    public static final String MY_DATA = "myData";

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        new Thread(this).start();

        return super.onStartCommand(intent, flags, startId);
    }

    @Override
    public void run() {
        try {
            JSONObject coinsJsonArr = new HttpRequest("https://api.coinmarketcap.com/v2/listings/").prepare().sendAndReadJSON();
            Log.i("Ntf Service", "Sending Broadcast");
            sendBroadcast(dataIntent(coinsJsonArr.toString()));
        } catch (Exception e) {
            e.printStackTrace();
            Log.d("MIKO","JSON failed: "+e.toString());
        }
        stopSelf();
    }

    private Intent dataIntent(String data) {
        String action = "MyBGAction";
        Intent intent = new Intent(action);
        intent.putExtra(MY_DATA, data);
        return intent;
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
