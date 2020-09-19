
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

        String js = new CordovaEventBuilder("ezadmob.banner.onAdLoaded").build();
        executor.loadJS(js);
    }

    @Override
    public void onAdFailedToLoad(LoadAdError adError) {
        // Code to be executed when an ad request fails.
        callbackContext.error("Banner not ready yet");

        String js = new CordovaEventBuilder("ezadmob.banner.onAdFailedToLoad").build();
        executor.loadJS(js);
    }

    @Override
    public void onAdOpened() {
        // Code to be executed when an ad opens an overlay that
        // covers the screen.
        String js = new CordovaEventBuilder("ezadmob.banner.onAdOpened").build();
        executor.loadJS(js);
    }

    @Override
    public void onAdLeftApplication() {
        // Code to be executed when the user has left the app.
        String js = new CordovaEventBuilder("ezadmob.banner.onAdLeftApplication").build();
        executor.loadJS(js);
    }

    @Override
    public void onAdClosed() {
        // Code to be executed when when the user is about to return
        // to the app after tapping on an ad.
        String js = new CordovaEventBuilder("ezadmob.banner.onAdClosed").build();
        executor.loadJS(js);
    }


}