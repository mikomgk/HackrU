package com.example.miko.fragements;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ListView;

import com.example.miko.fragements.adapters.NamesAdapter;

public class NamesFragment extends Fragment {

    private String[] names={"cdc","cds","vfvfdv","fre"};
    private OnNameSelected onNameSelected;

    public void setOnNameSelected(OnNameSelected onNameSelected) {
        this.onNameSelected = onNameSelected;
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragement_name_list,container,false);

        final NamesAdapter adapter=new NamesAdapter(getContext(),names);
        ListView listView=view.findViewById(R.id.nameList);
        listView.setAdapter(adapter);

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int position, long id) {
                if(onNameSelected!=null)
                    onNameSelected.onNameSelectedListener(adapter.getItem(position));
            }
        });

        return view;
    }

    public interface OnNameSelected{
        void onNameSelectedListener(String name);
    }
}
