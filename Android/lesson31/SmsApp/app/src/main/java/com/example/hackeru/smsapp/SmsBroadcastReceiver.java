package com.example.hackeru.smsapp;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.provider.Telephony;
import android.telephony.SmsMessage;
import android.util.Log;
import android.widget.Toast;

public class SmsBroadcastReceiver extends BroadcastReceiver {

    private static final String TAG = "SmsBroadcastReceiver";

    //private final String serviceProviderNumber;
    //private final String serviceProviderSmsCondition;

    private SmsReceivedListener smsReceivedListener;

    public SmsBroadcastReceiver(/*String serviceProviderNumber, String serviceProviderSmsCondition*/) {
        //this.serviceProviderNumber = serviceProviderNumber;
        //this.serviceProviderSmsCondition = serviceProviderSmsCondition;
        Log.d("MIKO","SmsBroadcastReceiver");
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent.getAction().equals(Telephony.Sms.Intents.SMS_RECEIVED_ACTION)) {
            String smsSender = "";
            String smsBody = "";
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                for (SmsMessage smsMessage : Telephony.Sms.Intents.getMessagesFromIntent(intent)) {
                    smsSender = smsMessage.getDisplayOriginatingAddress();
                    smsBody += smsMessage.getMessageBody();
                }
            } else {
                Bundle smsBundle = intent.getExtras();
                if (smsBundle != null) {
                    Object[] pdus = (Object[]) smsBundle.get("pdus");
                    if (pdus == null) {
                        // Display some error to the user
                        Log.e(TAG, "SmsBundle had no pdus key");
                        return;
                    }
                    SmsMessage[] messages = new SmsMessage[pdus.length];
                    for (int i = 0; i < messages.length; i++) {
                        messages[i] = SmsMessage.createFromPdu((byte[]) pdus[i]);
                        smsBody += messages[i].getMessageBody();
                    }
                    smsSender = messages[0].getOriginatingAddress();
                }
            }

            //if (smsSender.equals(serviceProviderNumber) && smsBody.startsWith(serviceProviderSmsCondition)) {
                if (smsReceivedListener != null) {
                    smsReceivedListener.onTextReceived(smsBody);
                }
            //}
        }
    }

    void setSmsReceivedListener(SmsReceivedListener smsReceivedListener) {
        this.smsReceivedListener = smsReceivedListener;
        Log.d("MIKO","setSmsReceivedListener");
    }

    public SmsReceivedListener getSmsReceivedListener() {
        return smsReceivedListener;
    }

    interface SmsReceivedListener {
        void onTextReceived(String text);
    }
}