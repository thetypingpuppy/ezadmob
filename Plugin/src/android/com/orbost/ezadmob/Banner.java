package com.orbost.ezadmob;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * This class performs sum called from JavaScript.
 */
public class Banner extends CordovaPlugin {
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("sum")) {
            Integer num1 = args.getInt(0);
            Integer num2 = args.getInt(1);
            this.sum(num1, num2, callbackContext);
            return true;
        }

        if (action.equals("show")){
            this.show();
        }

        return false;
    }

    private void sum(Integer num1, Integer num2, CallbackContext callbackContext) {
        if(num1 != null && num2 != null) {
            callbackContext.success(num1 + num2);
        } else {
            callbackContext.error("Expected two integer arguments.");
        }
    }

    // Display banner advert
    private void show(){

    }
}
