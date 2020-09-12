
package com.orbost.plugins;

import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;

import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.LoadAdError;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaWebView;

class BannerListener extends AdListener {

    private final Banner executor;
    CallbackContext callbackContext;
    BannerListener(Banner executor, CallbackContext callbackContext) {
        this.executor = executor;
        this.callbackContext = callbackContext;
    }

    @Override
    public void onAdLoaded() {
        // Code to be executed when an ad finishes loading.
        if (this.executor.plugin.bannerOverlap) {
            executor.displayOverlapAd(callbackContext);
        } else {
            executor.displayClippedAd(callbackContext);
        }
    }

    @Override
    public void onAdFailedToLoad(LoadAdError adError) {
        // Code to be executed when an ad request fails.
    }

    @Override
    public void onAdOpened() {
        // Code to be executed when an ad opens an overlay that
        // covers the screen.
    }

    @Override
    public void onAdLeftApplication() {
        // Code to be executed when the user has left the app.
    }

    @Override
    public void onAdClosed() {
        // Code to be executed when when the user is about to return
        // to the app after tapping on an ad.
    }


}