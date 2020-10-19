# ezadmob
Simplest Cordova plugin for implmenting Google Admob banner and interstitial adverts in both Android and iOS platforms.
- Compatible with latest Android +10 and iOS +13

## Installation
```
cordova plugin add https://github.com/thetypingpuppy/ezadmob.git --variable ADMOB_APP_ID_DROID=ca-app-pub-3940256099942544~334751171 --variable ADMOB_APP_ID_IOS=ca-app-pub-3940256099942544~1458002511
```

## Initialisation
Before plugin can be used it needs initialisation through the declaration of the following config object:
```javascript
config = {
    BANNER_ID : 'ca-app-pub-3940256099942544/6300978111',
    INTERSTITIAL_ID : 'ca-app-pub-3940256099942544/1033173712,
    BANNER_OVERLAP: false};

ezadmob.init(config);
```
It is useful to use an object to switch ID's automatically between deployment platforms:
```javascript
var admobid = {};
if (/(android)/i.test(navigator.userAgent)) {  // for android & amazon-fireos
    admobid = {
        banner: 'ca-app-pub-3940256099942544/6300978111',
        interstitial: 'ca-app-pub-3940256099942544/1033173712',
    }
} else if (/(ipod|iphone|ipad)/i.test(navigator.userAgent)) {  // for ios
    admobid = {
        banner: 'ca-app-pub-3940256099942544/2934735716',
        interstitial: 'ca-app-pub-3940256099942544/4411468910',
    }
}
ezadmob.init({
        BANNER_ID : admobid.banner,
        INTERSTITIAL_ID : admobid.interstitial,
        BANNER_OVERLAP: false});
    
```
Ref:cordova-plugin-admob-free

## Banner Usage

#### Load Banner
```javascript
ezadmob.loadBanner(successCallback, errorCallback);
```

#### Display Banner
```javascript
ezadmob.displayBanner(successCallback, errorCallback);
```

#### Load & Display Banner
```javascript
ezadmob.loadAndShowBanner(successCallback, errorCallback);
```

#### Remove Banner
```javascript
ezadmob.removeBanner(successCallback, errorCallback);
```

## Interstitial Usage

#### Load Interstitial Advert
```javascript
ezadmob.loadInterstitial(successCallback, errorCallback);
```

#### Display Interstitial
```javascript
ezadmob.displayInterstitial(successCallback, errorCallback);
```

#### Load & Display Interstitial Advert
```javascript
ezadmob.loadAndShowInterstitial(successCallback, errorCallback);
```

## Listeners

All Google Admob control listeners are accessible in Cordova. 

Simply add listeners to your `index.js` or within `onDeviceReady()`.

### Banner Listeners

#### onAdLoaded
```javascript
document.addEventListener('ezadmob.banner.onAdLoaded', function(event) {
    bannerAdLoaded = true;
});
```

#### onAdFailedToLoad
```javascript
document.onAdFailedToLoad('ezadmob.banner.onAdFailedToLoad', function(event) {
    bannerAdLoaded = false;
});
```

#### onAdOpened
```javascript
document.addEventListener('ezadmob.banner.onAdOpened', function(event) {
    bannerAdOpened = true;
});
```

#### onAdLeftApplication
```javascript
document.addEventListener('ezadmob.banner.onAdLeftApplication', function(event) {
    bannerAdLeftApplication = true;
});
```

#### onAdClosed
```javascript
document.addEventListener('ezadmob.banner.onAdClosed', function(event) {
    bannerAdClosed = true;
});
```


### Interstitial Listeners

#### onAdLoaded
```javascript
document.addEventListener('ezadmob.interstitial.onAdLoaded', function(event) {
    interstitialAdLoaded = true;
});
```
#### onAdFailedToLoad
```javascript
document.onAdFailedToLoad('ezadmob.interstitial.onAdFailedToLoad', function(event) {
    interstitialAdLoaded = false;
});
```
#### onAdOpened
```javascript
document.addEventListener('ezadmob.interstitial.onAdOpened', function(event) {
    interstitialAdOpened = true;
});
```
#### onAdLeftApplication
```javascript
document.addEventListener('ezadmob.interstitial.onAdLeftApplication', function(event) {
    interstitialAdLeftApplication = true;
});
```

#### onAdClosed
```javascript
document.addEventListener('ezadmob.interstitial.onAdClosed', function(event) {
    interstitialAdClosed = true;
});
```

---
&copy; Orbost 2020

