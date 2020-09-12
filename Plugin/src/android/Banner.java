package com.orbost.plugins;

import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import org.apache.cordova.CallbackContext;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;
import com.google.android.gms.ads.LoadAdError;

import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;

public class Banner {

    private AdView adView;
    private RelativeLayout adViewLayout = null;
    private ViewGroup parentView;
    private boolean bannerShow = true;

    protected ezadmob plugin;

    public Banner(ezadmob plugin) {
        this.plugin = plugin;
    }

    public void loadBanner(CallbackContext callbackContext){
        CordovaInterface cordova = plugin.cordova;
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override public void run() {
                CordovaInterface cordova = plugin.cordova;

                if (adView == null) {
                    adView = new AdView(cordova.getActivity());
                    adView.setAdUnitId(plugin.BANNER_ID);
                    adView.setAdSize(AdSize.SMART_BANNER);

                    BannerListener bl = new BannerListener(Banner.this, callbackContext);
                    adView.setAdListener(bl);

                }
                if (adView.getParent() != null) {
                    ((ViewGroup) adView.getParent()).removeView(adView);
                }

                AdRequest adRequest = new AdRequest.Builder().build();
                adView.loadAd(adRequest);
            }
        });
    }

    public void displayOverlapAd(CallbackContext callbackContext){
        CordovaInterface cordova = plugin.cordova;
        CordovaWebView webView = plugin.webView;

        RelativeLayout.LayoutParams params2 = new RelativeLayout.LayoutParams(
                RelativeLayout.LayoutParams.MATCH_PARENT,
                RelativeLayout.LayoutParams.WRAP_CONTENT);
        //        params2.addRule(plugin.config.bannerAtTop ? RelativeLayout.ALIGN_PARENT_TOP : RelativeLayout.ALIGN_PARENT_BOTTOM);
        params2.addRule(RelativeLayout.ALIGN_PARENT_TOP);
        if (adViewLayout == null) {
            adViewLayout = new RelativeLayout(cordova.getActivity());
            RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.MATCH_PARENT);
            try {
                ((ViewGroup) (((View) webView.getClass().getMethod("getView").invoke(webView)).getParent())).addView(adViewLayout, params);
            } catch (Exception e) {
                ((ViewGroup) webView).addView(adViewLayout, params);
            }
        }

        adViewLayout.addView(adView, params2);
        adViewLayout.bringToFront();

        callbackContext.success();
    }

    public void displayClippedAd(CallbackContext callbackContext){
        CordovaWebView webView = plugin.webView;

        ViewGroup wvParentView = (ViewGroup) getWebView().getParent();
        if (parentView == null) {
            parentView = new LinearLayout(webView.getContext());
        }
        if (wvParentView != null && wvParentView != parentView) {
            ViewGroup rootView = (ViewGroup) (getWebView().getParent());
            wvParentView.removeView(getWebView());
            ((LinearLayout) parentView).setOrientation(LinearLayout.VERTICAL);
            parentView.setLayoutParams(new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT, 0.0F));
            getWebView().setLayoutParams(new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT, 1.0F));
            parentView.addView(getWebView());
            rootView.addView(parentView);
        }

        parentView.addView(adView);
        parentView.bringToFront();
        parentView.requestLayout();
        parentView.requestFocus();

        callbackContext.success();
    }


    public void removeAd(CallbackContext callbackContext) {
        // final CallbackContext delayCallback = callbackContext;
        CordovaInterface cordova = plugin.cordova;

        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (adView != null) {
                    ViewGroup parentView = (ViewGroup) adView.getParent();
                    if (parentView != null) {
                        parentView.removeView(adView);
                    }
                    adView.destroy();
                    adView = null;
                }
                callbackContext.success();
            }
        });
    }


    public void pauseAd() {
        if (adView != null) {
            adView.pause();
        }
    }

    public void resumeAd() {
        if (adView != null) {
            adView.resume();
        }
    }

    public void destroy() {
        if (adView != null) {
            adView.destroy();
            adView = null;
        }
        if (adViewLayout != null) {
            ViewGroup parentView = (ViewGroup) adViewLayout.getParent();
            if (parentView != null) {
                parentView.removeView(adViewLayout);
            }
            adViewLayout = null;
        }
    }

    private View getWebView() {
        CordovaWebView webView = plugin.webView;
        try {
            return (View) webView.getClass().getMethod("getView").invoke(webView);
        } catch (Exception e) {
            return (View) webView;
        }
    }

}
