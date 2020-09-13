
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
        executor.displayAd(callbackContext);
    }

    @Override
    public void onAdFailedToLoad(LoadAdError adError) {
        // Code to be executed when an ad request fails.
        callbackContext.error("Interstitial not ready yet");
    }

    @Override
    public void onAdLeftApplication() {
        
    }


    @Override
    public void onAdOpened() {
        
    }

    @Override
    public void onAdClosed() {

    }
}
