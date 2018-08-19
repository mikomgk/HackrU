package com.example.hackeru.smsapp;

import android.Manifest;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.provider.Telephony;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;

import org.w3c.dom.Text;

public class MainActivity extends AppCompatActivity implements SmsBroadcastReceiver.SmsReceivedListener {

    private static final int SMS_PERMISSION_CODE = 50;
    private SmsBroadcastReceiver smsBroadcastReceiver;
    private TextView txt;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        txt=findViewById(R.id.txt);
        if (!isSmsPermissionGranted())
            requestReadAndSendSmsPermission();
        else {
            smsBroadcastReceiver = new SmsBroadcastReceiver();
            registerReceiver(smsBroadcastReceiver, new IntentFilter(Telephony.Sms.Intents.SMS_RECEIVED_ACTION));
            smsBroadcastReceiver.setSmsReceivedListener(this);
        }
    }

    public boolean isSmsPermissionGranted() {
        return ContextCompat.checkSelfPermission(this, Manifest.permission.READ_SMS) == PackageManager.PERMISSION_GRANTED;
    }

    private void requestReadAndSendSmsPermission() {
        ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.RECEIVE_SMS}, SMS_PERMISSION_CODE);
        //ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_SMS}, SMS_PERMISSION_CODE);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String permissions[], int[] grantResults) {
        switch (requestCode) {
            case SMS_PERMISSION_CODE: {
                // If request is cancelled, the result arrays are empty.
                if (grantResults.length > 0
                        && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    smsBroadcastReceiver = new SmsBroadcastReceiver();
                    registerReceiver(smsBroadcastReceiver, new IntentFilter(Telephony.Sms.Intents.SMS_RECEIVED_ACTION));
                    smsBroadcastReceiver.setSmsReceivedListener(this);
                } else {
                    Toast.makeText(this, "You didn't permit read sms", Toast.LENGTH_SHORT).show();
                }
            }
        }
    }

    @Override
    public void onTextReceived(String text) {
        txt.setText(text);
        Toast.makeText(this, "message: " + text, Toast.LENGTH_LONG).show();
    }
}
