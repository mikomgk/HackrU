package com.example.miko.mynotification;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.support.annotation.RequiresApi;

public class NTFHandler {
    public static final String DEFAULT_CHANNEL_NAME = "My NTF";
    private Context context;
    private NotificationManager ntfManager;
    private String channelID;
    private Notification.Builder ntfBuilder;
    private Notification ntf;
    private int ntfID;

    public NTFHandler(Context context, int ntfID) {
        construct(context, MainActivity.DEFAULT_NTF_CHANNEL, ntfID);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
            createChannel(DEFAULT_CHANNEL_NAME, null);
    }

    public NTFHandler(Context context, int ntfID, String channelID, String channelName) {
        construct(context, channelID, ntfID);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
            createChannel(channelName, null);
    }

    public NTFHandler(Context context, int ntfID, String channelID, String channelName, int importance) {
        construct(context, channelID, ntfID);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
            createChannel(channelName, importance);
    }

    private void construct(Context context, String channelID, int ntfID) {
        this.context = context;
        this.ntfManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        this.channelID = channelID;
        this.ntfID = ntfID;
    }


    @RequiresApi(api = Build.VERSION_CODES.O)
    private void createChannel(String channelName, Integer importance) {
        if (importance == null)
            importance = NotificationManager.IMPORTANCE_DEFAULT;
        NotificationChannel myChannel = new NotificationChannel(channelID, channelName, importance);
        ntfManager.createNotificationChannel(myChannel);
    }

    public NTFHandler ntfCreator(CharSequence contentTitle, CharSequence contentText) {
        ntfBuilder = Build.VERSION.SDK_INT >= Build.VERSION_CODES.O
                ? new Notification.Builder(context, channelID)
                : new Notification.Builder(context);
        ntfBuilder
                .setContentTitle(contentTitle)
                .setContentText(contentText)
                .setSmallIcon(R.drawable.ic_launcher_foreground)
                .setLargeIcon(BitmapFactory.decodeResource(context.getResources(), R.drawable.ic_launcher_foreground))
                .setAutoCancel(true);
        return this;
    }

    public NTFHandler ntfSetContentIntent(Class<?> activityClass, String data) {
        Intent intent = new Intent(context, activityClass);
        intent.putExtra(NtfService.MY_DATA, data);
        ntfBuilder.setContentIntent(PendingIntent.getActivity(context, ntfID, intent, PendingIntent.FLAG_UPDATE_CURRENT));
        return this;
    }

    public NTFHandler ntfBuild() {
        ntf = ntfBuilder.build();
        return this;
    }

    public NTFHandler ntfNotify() {
        ntfManager.notify(ntfID, ntf);
        return this;
    }
}
