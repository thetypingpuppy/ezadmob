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

function onDeviceReady() {
    // Cordova is now initialized. Have fun!

    ezadmob.init({
        BANNER_ID : "ca-app-pub-3940256099942544/6300978111",
        INTERSTITIAL_ID : "ca-app-pub-3940256099942544/1033173712",
        BANNER_OVERLAP: true});

    document.getElementById("bannerShowButton").addEventListener("click", bannerShow);
    document.getElementById("bannerHideButton").addEventListener("click", bannerHide);
    document.getElementById("interstitialShowButton").addEventListener("click", interstitialShow);
}

function bannerShow(){
    ezadmob.loadBanner(function() { console.log("No Errors"); }, function(err) { console.log(err); });
}

function bannerHide(){
    ezadmob.removeBanner(function() { console.log("No Errors"); }, function(err) { console.log(err); });
} 

function interstitialShow(){
    ezadmob.loadInterstitial(function() { console.log("No Errors"); }, function(err) { console.log(err); });
} 
