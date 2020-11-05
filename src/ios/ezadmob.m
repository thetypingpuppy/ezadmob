#import "ezadmob.h"
#import <Cordova/CDVPlugin.h>
#import <malloc/malloc.h>

#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>

@import GoogleMobileAds;

@interface ezadmob () <GADBannerViewDelegate,GADInterstitialDelegate>

- (void)REQUEST_IDFA:(CDVInvokedUrlCommand*)command;

- (void)LOAD_AND_SHOW_BANNER:(CDVInvokedUrlCommand*)command;
- (void)REMOVE_BANNER:(CDVInvokedUrlCommand*)command;
- (void)LOAD_BANNER:(CDVInvokedUrlCommand*)command;
- (void)DISPLAY_BANNER:(CDVInvokedUrlCommand*)command;

- (void)loadAndShowBanner;
- (void)removeBanner;
- (void)loadBanner;
- (void)showBanner;
- (void)addBannerViewToView:(UIView *)bannerView;

- (void)adViewDidReceiveAd:(GADBannerView *)adView;
- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error;
- (void)adViewWillPresentScreen:(GADBannerView *)adView;
- (void)adViewWillLeaveApplication:(GADBannerView *)adView;

- (void)LOAD_INTERSTITIAL:(CDVInvokedUrlCommand*)command;
- (void)DISPLAY_INTERSTITIAL:(CDVInvokedUrlCommand*)command;
- (void)LOAD_AND_SHOW_INTERSTITIAL:(CDVInvokedUrlCommand*)command;
- (void)INIT:(CDVInvokedUrlCommand*)command;

- (void)loadInterstitial;
- (void)showInterstitial;
- (void)loadAndShowInterstitial;

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad;
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error;
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad;
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad;
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad ;

- (void)fireEvent:(NSString *)obj event:(NSString *)eventName withData:(NSString *)jsonStr;

@property(nonatomic, strong) GADBannerView* bannerView;
@property(nonatomic, strong) GADInterstitial* interstitialView;

@property(assign) bool bannerLoaded;
@property(assign) bool loadAndShowBannerCheck;
@property(assign) bool loadAndShowInterstitialCheck;

@property(nonatomic, strong) NSString* bannerID;
@property(nonatomic, strong) NSString* interstitialID;

@property(nonatomic, strong) CDVPluginResult* pluginResult;
@property(nonatomic, strong) NSString* callbackID;

@end

@implementation ezadmob

- (void)REQUEST_IDFA:(CDVInvokedUrlCommand*)command {
    [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        self.callbackID = command.callbackId;
        self.pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:self.pluginResult callbackId:self.callbackID];
    }];
}


// -- Banner Advert Cordova Linker Functions
// -----------------------------------------------------------------------------

- (void)LOAD_AND_SHOW_BANNER:(CDVInvokedUrlCommand*)command {
    self.callbackID = command.callbackId;
    [self loadAndShowBanner];
}

- (void)REMOVE_BANNER:(CDVInvokedUrlCommand*)command {
    self.callbackID = command.callbackId;
    [self removeBanner];
}

- (void)LOAD_BANNER:(CDVInvokedUrlCommand*)command {
    self.callbackID = command.callbackId;
    [self loadBanner];
}

- (void)DISPLAY_BANNER:(CDVInvokedUrlCommand*)command {
    self.callbackID = command.callbackId;
    [self showBanner];
}

// -- Banner Advert Control Functions
// -----------------------------------------------------------------------------

- (void)loadAndShowBanner {
    self.loadAndShowBannerCheck = true;
    [self loadBanner];
}

- (void)removeBanner {
    if (self.bannerView){
        [self.bannerView setDelegate:nil];
        [self.bannerView removeFromSuperview];
    }
    self.bannerView = nil;
    self.bannerLoaded = false;
    
    self.pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:self.pluginResult callbackId:self.callbackID];
}

- (void)loadBanner {
    if (self.bannerView){
        [self removeBanner];
    }
    
    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    self.bannerView.adUnitID = self.bannerID;
    self.bannerView.rootViewController = self.viewController;
    self.bannerView.delegate = self;
    
    [self.bannerView loadRequest:[GADRequest request]];
}

- (void)showBanner {
    if (self.bannerLoaded){
        [self addBannerViewToView:self.bannerView];
        self.pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    } else {
        self.pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Run loadBanner() first."];
    }
    
    [self.commandDelegate sendPluginResult:self.pluginResult callbackId:self.callbackID];
}

- (void)addBannerViewToView:(UIView *)bannerView {
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.webView addSubview:bannerView];
    [self.webView bringSubviewToFront:bannerView];
    [self.webView addConstraints:@[
        [NSLayoutConstraint constraintWithItem:bannerView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.webView.safeAreaLayoutGuide
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:bannerView
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.webView.safeAreaLayoutGuide
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1
                                      constant:0]
    ]];
}


// -- Banner Advert Listener Functions
// -----------------------------------------------------------------------------

// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
    
    [self fireEvent:@"" event:@"ezadmob.banner.onAdLoaded" withData:nil];
    
    self.pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:self.pluginResult callbackId:self.callbackID];
    
    self.bannerLoaded = true;
    if (self.loadAndShowBannerCheck){
        [self showBanner];
        self.loadAndShowBannerCheck = false;
    }
}

// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
    didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
    
    [self fireEvent:@"" event:@"ezadmob.banner.onAdFailedToLoad" withData:nil];
    
    self.pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Banner Ad failed to load, wait and try again."];
    [self.commandDelegate sendPluginResult:self.pluginResult callbackId:self.callbackID];
    
    self.bannerLoaded = false;
}

// Tells the delegate that a full-screen view will be presented in response to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
    [self fireEvent:@"" event:@"ezadmob.banner.onAdOpened" withData:nil];
}

// Tells the delegate that the full-screen view will be dismissed.
//- (void)adViewWillDismissScreen:(GADBannerView *)adView {
//    NSLog(@"adViewWillDismissScreen");
//}
//
//// Tells the delegate that the full-screen view has been dismissed.
//- (void)adViewDidDismissScreen:(GADBannerView *)adView {
//    NSLog(@"adViewDidDismissScreen");
//}

// Tells the delegate that a user click will open another app (such as the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
    [self fireEvent:@"" event:@"ezadmob.banner.onAdLeftApplication" withData:nil];
}


// -- Interstitial Advert Cordova Linker Functions
// -----------------------------------------------------------------------------

- (void)LOAD_INTERSTITIAL:(CDVInvokedUrlCommand*)command {
    [self loadInterstitial];
    self.callbackID = command.callbackId;
}

- (void)DISPLAY_INTERSTITIAL:(CDVInvokedUrlCommand*)command {
    [self showInterstitial];
    self.callbackID = command.callbackId;
}

- (void)LOAD_AND_SHOW_INTERSTITIAL:(CDVInvokedUrlCommand*)command {
    [self loadAndShowInterstitial];
    self.callbackID = command.callbackId;
}

// -- Interstitial Advert Control Functions
// -----------------------------------------------------------------------------

- (void)loadInterstitial {
    self.interstitialView = [[GADInterstitial alloc] initWithAdUnitID:self.interstitialID];
    [self.interstitialView loadRequest:[GADRequest request]];
    self.interstitialView.delegate = self;
}

- (void)showInterstitial {
    if (self.interstitialView.isReady) {
        [self.interstitialView presentFromRootViewController:self.viewController];
    } else {
        self.pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Interstitial Ad not ready, run loadInterstitial() first."];
    }
    [self.commandDelegate sendPluginResult:self.pluginResult callbackId:self.callbackID];
}

- (void)loadAndShowInterstitial {
    self.loadAndShowInterstitialCheck = true;
    [self loadInterstitial];
}

// -- Interstitial Advert Listener Functions
// -----------------------------------------------------------------------------

// Tells the delegate an ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"interstitialDidReceiveAd");
    [self fireEvent:@"" event:@"ezadmob.interstitial.onAdLoaded" withData:nil];
    
    self.pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:self.pluginResult callbackId:self.callbackID];
    
    if (self.loadAndShowInterstitialCheck){
        [self showInterstitial];
        self.loadAndShowInterstitialCheck = false;
    }
}

// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
    didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
    
    [self fireEvent:@"" event:@"ezadmob.interstitial.onAdFailedToLoad" withData:nil];
    
    self.pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Interstitial Ad failed to load, wait and try again."];
    [self.commandDelegate sendPluginResult:self.pluginResult callbackId:self.callbackID];
}

// Tells the delegate that an interstitial will be presented.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillPresentScreen");
    [self fireEvent:@"" event:@"ezadmob.interstitial.onAdOpened" withData:nil];
}

// Tells the delegate the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillDismissScreen");
    [self fireEvent:@"" event:@"ezadmob.interstitial.onAdClosed" withData:nil];
}

// Tells the delegate the interstitial had been animated off the screen.
//- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
//    NSLog(@"interstitialDidDismissScreen");
//    [self fireEvent:@"" event:@"ezadmob.interstitial.onAdLeftApplication" withData:nil];
//}

// Tells the delegate that a user click will open another app (such as the App Store), backgrounding the current app.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"interstitialWillLeaveApplication");
    [self fireEvent:@"" event:@"ezadmob.interstitial.onAdLeftApplication" withData:nil];
}

// -- Additional Cordova linker functions
// -----------------------------------------------------------------------------

- (void)fireEvent:(NSString *)obj event:(NSString *)eventName withData:(NSString *)jsonStr {
    NSString * js;
    if (obj && [obj isEqualToString:@"window"]){
        js = [NSString stringWithFormat:@"var evt=document.createEvent(\"UIEvents\");evt.initUIEvents(\"%@\",true,false,window,0);window.dispatchEvent(evt);", eventName];
    } else if (jsonStr && [jsonStr length]>0){
        js = [NSString stringWithFormat:@"javascript:cordova.fireDocumentEvent('%@','%@');", eventName, jsonStr];
    } else {
        js = [NSString stringWithFormat:@"javascript:cordova.fireDocumentEvent('%@');", eventName];
    }
    [self.commandDelegate evalJs:js];
}

- (void)INIT:(CDVInvokedUrlCommand*)command {
    self.pluginResult = nil;
    self.callbackID = command.callbackId;
    NSDictionary* arg = [command.arguments objectAtIndex:0];
    
    self.bannerID = @"ca-app-pub-3940256099942544/2934735716";
    self.interstitialID = @"ca-app-pub-3940256099942544/4411468910";
    
    for(id key in arg){
        if ([key isEqualToString:@"BANNER_ID"]){
            self.bannerID = [arg objectForKey:key];
        }
        if ([key isEqualToString:@"INTERSTITIAL_ID"]){
            self.interstitialID = [arg objectForKey:key];
        }
    }
}


@end
