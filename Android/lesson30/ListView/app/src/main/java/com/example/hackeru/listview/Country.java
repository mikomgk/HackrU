package com.example.hackeru.listview;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

public class Country {

    private String name;
    private String dialCode;
    private String code;

    public Country(String name, String dialCode, String code) {
        this.name = name;
        this.dialCode = dialCode;
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDialCode() {
        return dialCode;
    }

    public void setDialCode(String dialCode) {
        this.dialCode = dialCode;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public static Country[] getCountriesArr(JSONArray countriesJSON){
        Country[] countries=new Country[countriesJSON.length()];
        JSONObject countryJSON=null;
        Country country;
        for (int i = 0; i < countriesJSON.length(); i++) {
            try {
                countryJSON=countriesJSON.getJSONObject(i);
                country=new Country(countryJSON.getString("name"),countryJSON.getString("dial_code"),countryJSON.getString("code"));
                countries[i]=country;
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        return countries;
    }
}
