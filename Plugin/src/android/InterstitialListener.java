
package com.orbost.plugins;

import android.util.Log;

import com.google.android.gms.ads.AdListener;

class InterstitialListener extends AdListener {
    private final Interstitial executor;

    InterstitialListener(Interstitial executor) {
        this.executor = executor;
    }

    @Override
    public void onAdFailedToLoad(int errorCode) {
        
    }

    @Override
    public void onAdLeftApplication() {
        
    }

    @Override
    public void onAdLoaded() {
        
    }

    @Override
    public void onAdOpened() {
        
    }

    @Override
    public void onAdClosed() {

    }
}
