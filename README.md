# ezadmob

## Installation

```
cordova plugin add C/path_to_plugin_folder --variable ADMOB_APP_ID=123456789012
```

## Initialisation
Before plugin can be used it needs initialisation through the declaration of the following config object:
```
config = {
    BANNER_ID : 'ca-app-pub-3940256099942544/6300978111',
    INTERSTITIAL_ID : 'ca-app-pub-3940256099942544/1033173712,
    BANNER_OVERLAP: false,
    AUTOSHOW_BANNER: false,
    AUTOSHOW_INTERSTITIAL: false};

 ezadmob.init(config);
```

## Banner Usage

#### Load & Display Banner
If `AUTOSHOW_BANNER = true`, the banner advert will automatically show as soon as it is loaded (received by Google Admob server).
```
ezadmob.loadBanner(successCallback, errorCallback);
```

#### Display Banner
If `AUTOSHOW_BANNER = false`, the following function is required to display the advert.
```
ezadmob.displayBanner(successCallback, errorCallback);
```

#### Remove Banner

```
ezadmob.removeBanner(successCallback, errorCallback);
```

## Interstitial Usage

#### Load & Display Interstitial Advert

If `AUTOSHOW_INTERSTITIAL = true`, the interstitial advert will automatically show  as soon as it is loaded (received by Google Admob server).
```
ezadmob.loadInterstitial(successCallback, errorCallback);
```

#### Display Interstitial
If `AUTOSHOW_INTERSTITIAL = false`, the following function is required to display the advert.
```
ezadmob.displayInterstitial(successCallback, errorCallback);
```

## Listeners

All Google Admob control listeners are accessible in cordova. 

Simply add listeners to your `index.js` or within `onDeviceReady()`.

### Banner Listeners

#### onAdLoaded
```
document.addEventListener('ezadmob.banner.onAdLoaded', function(event) {
    bannerAdLoaded = true;
});
```

#### onAdFailedToLoad
```
document.onAdFailedToLoad('ezadmob.banner.onAdFailedToLoad', function(event) {
    bannerAdLoaded = false;
});
```

#### onAdOpened
```
document.addEventListener('ezadmob.banner.onAdOpened', function(event) {
    bannerAdOpened = true;
});
```

#### onAdLeftApplication
```
document.addEventListener('ezadmob.banner.onAdLeftApplication', function(event) {
    bannerAdLeftApplication = true;
});
```

#### onAdClosed
```
document.addEventListener('ezadmob.banner.onAdClosed', function(event) {
    bannerAdClosed = true;
});
```


### Interstitial Listeners

#### onAdLoaded
```
document.addEventListener('ezadmob.interstitial.onAdLoaded', function(event) {
    interstitialAdLoaded = true;
});
```
#### onAdFailedToLoad
```
document.onAdFailedToLoad('ezadmob.interstitial.onAdFailedToLoad', function(event) {
    interstitialAdLoaded = false;
});
```
#### onAdOpened
```
document.addEventListener('ezadmob.interstitial.onAdOpened', function(event) {
    interstitialAdOpened = true;
});
```
#### onAdLeftApplication
```
document.addEventListener('ezadmob.interstitial.onAdLeftApplication', function(event) {
    interstitialAdLeftApplication = true;
});
```

#### onAdClosed
```
document.addEventListener('ezadmob.interstitial.onAdClosed', function(event) {
    interstitialAdClosed = true;
});
```

---
&copy; Orbost 2020

