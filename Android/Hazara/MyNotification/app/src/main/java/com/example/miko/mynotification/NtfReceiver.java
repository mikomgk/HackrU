package com.example.miko.mynotification;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

public class NtfReceiver extends BroadcastReceiver {

    private static final int NTF_ONE = 1;

    @Override
    public void onReceive(Context context, Intent intent) {
        String data = intent.getStringExtra(NtfService.MY_DATA);
        if (data != null) {
            (new NTFHandler(context, NTF_ONE))
                    .ntfCreator("My Notification", "coins arrived")
                    .ntfSetContentIntent(NtfActivity.class, data)
                    .ntfBuild()
                    .ntfNotify();
        }
    }
}
