package com.orbost.plugins;

import org.apache.cordova.CordovaPlugin;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;

public class ezadmob extends CordovaPlugin {

    Banner banner = null;
    Interstitial interstitial = null;
    String BANNER_ID = "ca-app-pub-3940256099942544/6300978111";
    String INTERSTITIAL_ID = "ca-app-pub-3940256099942544/1033173712";

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (banner == null){
            banner = new Banner(this);
        }
        if (interstitial == null){
            interstitial = new Interstitial(this);
        }

        if (action.equals("INIT")) {
            // BANNER_ID = args.banner_id; 
            // INTERSTITIAL_ID = args.interstitial_id; 
        }

        if (action.equals("SHOW_OVERLAY_BANNER")) {
            banner.showOverlay(callbackContext);
        }

        if (action.equals("SHOW_CLIPPED_BANNER")) {
            banner.showClipped(callbackContext);
        }

        if (action.equals("REMOVE_BANNER")) {
            banner.removeAd(callbackContext);
        }

        if (action.equals("SHOW_INTERSTITIAL")) {
            interstitial.show(callbackContext);
        }

        return true;
        
    }
}