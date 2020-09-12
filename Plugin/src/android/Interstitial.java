package com.orbost.plugins;
import org.apache.cordova.CallbackContext;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.InterstitialAd;
import com.google.android.gms.ads.AdListener;
import org.apache.cordova.CordovaInterface;

public class Interstitial {
    
    private InterstitialAd interstitialAd;

    protected ezadmob plugin;

    public Interstitial(ezadmob plugin) {
        this.plugin = plugin;
    } 


    public void show(CallbackContext callbackContext){
        CordovaInterface cordova = plugin.cordova;

        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                // AdMobConfig config = plugin.config;
                CordovaInterface cordova = plugin.cordova;

                destroy();
                interstitialAd = new InterstitialAd(cordova.getActivity());
                interstitialAd.setAdUnitId(plugin.INTERSTITIAL_ID);
                interstitialAd.setAdListener(new InterstitialListener(Interstitial.this, callbackContext));

                AdRequest adRequest = new AdRequest.Builder().build();
                interstitialAd.loadAd(adRequest);
            }
        });
    }

    // Function to display advert, called when advert is loaded and available to show.
    public void displayAd(CallbackContext callbackContext){
        if (interstitialAd.isLoaded()) {
            interstitialAd.show();
            if (callbackContext != null) {
                callbackContext.success();
            }
        } else {
            if (callbackContext != null) {
                callbackContext.error("Interstitial not ready yet");
            }
        }
    }

    public void destroy() {
        if (interstitialAd != null) {
            interstitialAd.setAdListener(null);
            interstitialAd = null;
        }
    }
}
