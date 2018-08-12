package com.example.hackeru.fragement;

import android.app.DialogFragment;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

public class AreYouSure extends DialogFragment {

    private String name,question;
    private AreYouSureListener listener;
    private TextView nameLbl,qLbl;
    private Button yesBtn, noBtn;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_ays, container, false);
        nameLbl = view.findViewById(R.id.nameLbl);
        nameLbl.setText(name);
        qLbl = view.findViewById(R.id.qLbl);
        qLbl.setText(question);
        yesBtn=view.findViewById(R.id.yesBtn);
        noBtn=view.findViewById(R.id.noBtn);
        yesBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                listener.done(true);
                dismiss();
            }
        });
        noBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                listener.done(false);
                dismiss();
            }
        });
        return view;
    }

    public void setListener(AreYouSureListener listener) {
        this.listener = listener;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public interface AreYouSureListener {
        void done(boolean answer);
    }
}
