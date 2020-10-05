
package com.orbost.plugins;

import android.util.Log;

import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.LoadAdError;

import org.apache.cordova.CallbackContext;

class InterstitialListener extends AdListener {
    private final Interstitial executor;
    CallbackContext callbackContext;

    InterstitialListener(Interstitial executor, CallbackContext callbackContext) {
        this.executor = executor;
        this.callbackContext = callbackContext;
    }

    @Override
    public void onAdLoaded() {
        if (this.executor.plugin.autoshowInterstitial){
            executor.displayAdAuto(callbackContext);
        } else {
            callbackContext.success();
        }

        String js = new CordovaEventBuilder("ezadmob.interstitial.onAdLoaded").build();
        executor.loadJS(js);
    }

    @Override
    public void onAdFailedToLoad(LoadAdError adError) {
        // Code to be executed when an ad request fails.
        callbackContext.error("Interstitial not ready yet");

        String js = new CordovaEventBuilder("ezadmob.interstitial.onAdFailedToLoad").build();
        executor.loadJS(js);
    }

    @Override
    public void onAdLeftApplication() {
        String js = new CordovaEventBuilder("ezadmob.interstitial.onAdLeftApplication").build();
        executor.loadJS(js);
    }


    @Override
    public void onAdOpened() {
        String js = new CordovaEventBuilder("ezadmob.interstitial.onAdOpened").build();
        executor.loadJS(js);
    }

    @Override
    public void onAdClosed() {
        String js = new CordovaEventBuilder("ezadmob.interstitial.onAdClosed").build();
        executor.loadJS(js);
    }
}
