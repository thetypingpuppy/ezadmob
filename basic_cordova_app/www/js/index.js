/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

// Wait for the deviceready event before using any of Cordova's device APIs.
// See https://cordova.apache.org/docs/en/latest/cordova/events/events.html#deviceready
document.addEventListener('deviceready', onDeviceReady, false);

document.addEventListener('ezadmob.banner.onAdLoaded', function(event) {
    bannerAdLoaded = true;
});

document.addEventListener('ezadmob.banner.onAdFailedToLoad', function(event) {
    bannerAdLoaded = false;
});

document.addEventListener('ezadmob.banner.onAdClosed', function(event) {
    bannerAdLoaded = false;
});

document.addEventListener('ezadmob.interstitial.onAdLoaded', function(event) {
    interstitialAdLoaded = true;
});

document.addEventListener('ezadmob.interstitial.onAdFailedToLoad', function(event) {
    interstitialAdLoaded = false;
});

document.addEventListener('ezadmob.interstitial.onAdClosed', function(event) {
    interstitialAdLoaded = false;
});


function onDeviceReady() {
    // Cordova is now initialized. Have fun!

    //Test ADMOB_APP_ID : ca-app-pub-3940256099942544~3347511713

    ezadmob.init({
        BANNER_ID : "ca-app-pub-3940256099942544/6300978111",
        INTERSTITIAL_ID : "ca-app-pub-3940256099942544/1033173712",
        BANNER_OVERLAP: false});

    document.getElementById("bannerLoadButton").addEventListener("click", bannerLoad);
    document.getElementById("bannerDisplayButton").addEventListener("click", bannerDisplay);
    document.getElementById("bannerRemoveButton").addEventListener("click", bannerRemove);
    document.getElementById("bannerLoadAndShowButton").addEventListener("click", bannerLoadAndShow);

    document.getElementById("interstitialLoadButton").addEventListener("click", interstitialLoad);
    document.getElementById("interstitialDisplayButton").addEventListener("click", interstitialDisplay);
    document.getElementById("interstitialLoadAndShowButton").addEventListener("click", interstitialLoadAndShow);

}

var bannerAdLoaded = false;
var interstitialAdLoaded = false;

function bannerLoad(){
    ezadmob.loadBanner(function() { console.log("No Errors"); }, function(err) { console.log(err); });
}

function bannerDisplay(){
    if (bannerAdLoaded){
        ezadmob.displayBanner(function() { console.log("No Errors"); }, function(err) { console.log(err); });
    }
}

function bannerRemove(){
    ezadmob.removeBanner(function() { bannerAdLoaded = false; console.log("No Errors"); }, function(err) { console.log(err); });
} 

function bannerLoadAndShow(){
    ezadmob.loadAndShowBanner(function() { console.log("No Errors"); }, function(err) { console.log(err); });
} 

function interstitialLoad(){
    ezadmob.loadInterstitial(function() { console.log("No Errors"); }, function(err) { console.log(err); });
} 

function interstitialDisplay(){
    if (interstitialAdLoaded){
        ezadmob.displayInterstitial(function() { console.log("No Errors"); }, function(err) { console.log(err); });
    }
} 

function interstitialLoadAndShow(){
    ezadmob.loadAndShowInterstitial(function() { console.log("No Errors"); }, function(err) { console.log(err); });
} 