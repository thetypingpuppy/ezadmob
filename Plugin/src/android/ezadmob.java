package com.orbost.plugins;

import org.apache.cordova.CordovaPlugin;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;

import java.util.Iterator;

public class ezadmob extends CordovaPlugin {

    Banner banner = null;
    Interstitial interstitial = null;
    String BANNER_ID = "ca-app-pub-3940256099942544/6300978111";
    String INTERSTITIAL_ID = "ca-app-pub-3940256099942544/1033173712";
    boolean bannerOverlap = false;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (banner == null){
            banner = new Banner(this);
        }
        if (interstitial == null){
            interstitial = new Interstitial(this);
        }

        if (action.equals("INIT")) {
            JSONObject jsonObj = args.getJSONObject(0);
            JSONArray keys = jsonObj.names ();

            for (int i = 0; i < keys.length(); i++) {
                String key = keys.getString(i);
                if (key.equals("BANNER_ID")){
                    BANNER_ID = jsonObj.getString(key);
                }
                if (key.equals("INTERSTITIAL_ID")){
                    INTERSTITIAL_ID = jsonObj.getString(key);
                }
                if (key.equals("BANNER_OVERLAP")){
                    bannerOverlap = jsonObj.getBoolean(key);
                }
            }

        }

        if (action.equals("LOAD_BANNER")) {
            banner.loadBanner(callbackContext);
        }

        if (action.equals("REMOVE_BANNER")) {
            banner.removeAd(callbackContext);
        }

        if (action.equals("LOAD_INTERSTITIAL")) {
            interstitial.load(callbackContext);
        }

        if (action.equals("DISPLAY_INTERSTITIAL")) {
            interstitial.displayAd(callbackContext);
        }

        return true;
        
    }
}