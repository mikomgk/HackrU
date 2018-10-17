package com.example.miko.mynotification;

import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class CoinsAdapter extends RecyclerView.Adapter<CoinViewHolder> {

    private Coin[] coins;

    public CoinsAdapter(String coinsJsonString) {
        List<Coin> coins = new ArrayList<>();
        try {
            JSONArray coinsJsonArr = (new JSONObject(coinsJsonString)).getJSONArray("data");
            for (int i = 0; i < 100; i++) {
                coins.add(new Coin(coinsJsonArr.getJSONObject(i)));
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
        this.coins = coins.toArray(new Coin[]{});
    }

    @NonNull
    @Override

    public CoinViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        LayoutInflater inflater = LayoutInflater.from(viewGroup.getContext());
        View view = inflater.inflate(R.layout.coin_item, viewGroup, false);
        return new CoinViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull CoinViewHolder coinViewHolder, int position) {
        Coin current = coins[position];
        coinViewHolder.id.setText(String.valueOf(current.id));
        coinViewHolder.name.setText(current.name);
        coinViewHolder.symbol.setText(current.symbol);
        coinViewHolder.websiteSlug.setText(current.websiteSlug);
    }

    @Override
    public int getItemCount() {
        return coins.length;
    }
}

class CoinViewHolder extends RecyclerView.ViewHolder {
    public final TextView id;
    public final TextView name;
    public final TextView symbol;
    public final TextView websiteSlug;

    public CoinViewHolder(@NonNull View itemView) {
        super(itemView);
        id = itemView.findViewById(R.id.coinId);
        name = itemView.findViewById(R.id.coinName);
        symbol = itemView.findViewById(R.id.coinSymbol);
        websiteSlug = itemView.findViewById(R.id.coinSlug);
    }
}

class Coin {
    int id;
    String name;
    String symbol;
    String websiteSlug;

    Coin(JSONObject coinJson) {
        try {
            this.id = coinJson.getInt("id");
            this.name = coinJson.getString("name");
            this.symbol = coinJson.getString("symbol");
            this.websiteSlug = coinJson.getString("website_slug");
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }
}
