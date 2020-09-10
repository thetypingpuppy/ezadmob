
package com.orbost.ezadmob;

import android.util.Log;

import com.google.android.gms.ads.AdListener;

class BannerListener extends AdListener {

    private final Banner executor;
    BannerListener(Banner executor) {
        super();
        this.executor = executor;
    }

    @Override
    public void onAdLoaded() {
        // Code to be executed when an ad finishes loading.
    }

    @Override
    public void onAdFailedToLoad(int errorCode) {
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