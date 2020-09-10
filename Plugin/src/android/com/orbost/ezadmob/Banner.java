package com.orbost.ezadmob;

import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
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

       if (action.equals("showOverlay")){
            this.showOverlay();
        }

        if (action.equals("showClipped")){
            this.showOverlay();
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

    private AdView adView;
    private RelativeLayout adViewLayout = null;
    private ViewGroup parentView;
    private boolean bannerShow = true;

    private String TEST_BANNER_ID = "ca-app-pub-3940256099942544/6300978111";

    private void showOverlay(){
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override public void run() {

                //CordovaInterface cordova = plugin.cordova;

                if (adView == null) {
                    adView = new AdView(cordova.getActivity());
                    adView.setAdUnitId(TEST_BANNER_ID);
                    adView.setAdSize(AdSize.SMART_BANNER);
                    adView.setAdListener(new BannerListener(Banner.this));
                }
                if (adView.getParent() != null) {
                    ((ViewGroup) adView.getParent()).removeView(adView);
                }

                AdRequest adRequest = new AdRequest.Builder().build();
                adView.loadAd(adRequest);

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
            }
        });
    }


    public void showClipped(){
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override public void run() {

                if (adView == null) {
                    adView = new AdView(cordova.getActivity());
                    adView.setAdUnitId(TEST_BANNER_ID);
                    adView.setAdSize(AdSize.SMART_BANNER);
                    adView.setAdListener(new BannerListener(Banner.this));
                }
                if (adView.getParent() != null) {
                    ((ViewGroup) adView.getParent()).removeView(adView);
                }

                AdRequest adRequest = new AdRequest.Builder().build();
                adView.loadAd(adRequest);


                ViewGroup wvParentView = (ViewGroup) getWebView().getParent();
                if (parentView == null) {
                    parentView = new LinearLayout(webView.getContext());
                }
                if (wvParentView != null && wvParentView != parentView) {
                    ViewGroup rootView = (ViewGroup)(getWebView().getParent());
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

            }
        });
    }

    private View getWebView() {
        CordovaWebView webView = this.webView;
        try {
            return (View) webView.getClass().getMethod("getView").invoke(webView);
        } catch (Exception e) {
            return (View) webView;
        }
    }

}
