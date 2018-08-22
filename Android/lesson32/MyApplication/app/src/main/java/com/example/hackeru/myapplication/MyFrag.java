package com.example.hackeru.myapplication;

import android.annotation.SuppressLint;
import android.app.Fragment;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.RenderProcessGoneDetail;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

public class MyFrag extends android.support.v4.app.Fragment {

    private String lbl;
    private RelativeLayout background;
    private TextView txt;
    private View view;
    private boolean isFirst=true;
    private Button btnSend;
    private EditText nameEdit;
    private TextView nameLbl;
    private Runnable listener;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, Bundle savedInstanceState) {
        View v = inflater.inflate(R.layout.my_frag, container, false);
        background=v.findViewById(R.id.mainFragLayout);
        txt=v.findViewById(R.id.lbl);
        btnSend=v.findViewById(R.id.sendBtn);
        nameEdit=v.findViewById(R.id.editName);
        nameLbl=v.findViewById(R.id.nameLbl);
        if(isFirst)
            nameLbl.setVisibility(View.GONE);
        else{
            btnSend.setVisibility(View.GONE);
            nameEdit.setVisibility(View.GONE);
        }
        if(isFirst && listener!=null)
            btnSend.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    listener.run();
                }
            });
        this.view=v;
        return v;
    }

    private void showLbl() {
        if (lbl != null)
            ((TextView) view.findViewById(R.id.lbl)).setText(lbl);
        Toast.makeText(view.getContext(), ""+lbl, Toast.LENGTH_SHORT).show();
    }

    public void setLbl(String lbl) {
        this.lbl = lbl;
        showLbl();
    }

    public void changeBackgroundColor(int color){
        background.setBackgroundResource(color);
    }

    public void changeTextColor(int color){
        txt.setTextColor(color);
    }

    public void setisFirst(boolean isFirst) {
        this.isFirst = isFirst;
    }

    public void setListener(Runnable listener) {
        this.listener = listener;
    }

    public void setNameLbl(String name){
        nameLbl.setText(name);
    }

    public String getNameLbl(){
        return nameEdit.getText().toString();
    }
}
