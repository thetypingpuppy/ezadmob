#import "CDVAdmob.h"
#import <Cordova/CDVPlugin.h>

@interface ezadmob () <GADBannerViewDelegate,GADInterstitialDelegate>

@property(nonatomic, strong) GADBannerView *bannerView;
@property(nonatomic, strong) GADInterstitial *interstitialView;

@property(assign) bool bannerLoaded;
@property(assign) bool loadAndShowBannerCheck;
@property(assign) bool loadAndShowInterstitialCheck;

@end

@implementation ezadmob

// -- Banner Advert JS Linker Functions
// -----------------------------------------------------------------------------

- (void)LOAD_AND_SHOW_BANNER:(CDVInvokedUrlCommand*)command {
    [self loadAndShowBanner];
}

- (void)REMOVE_BANNER:(CDVInvokedUrlCommand*)command {
    [self removeBanner];
}

- (void)LOAD_BANNER:(CDVInvokedUrlCommand*)command {
    [self loadBanner]
}

- (void)DISPLAY_BANNER:(CDVInvokedUrlCommand*)command {
    [self showBanner]
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
}

- (void)loadBanner {
    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    self.bannerView.rootViewController = self;
    self.bannerView.delegate = self;
    
    [self.bannerView loadRequest:[GADRequest request]];
}

- (void)showBanner {
    if (self.bannerLoaded){
        [self addBannerViewToView:self.bannerView];
    }
}

- (void)addBannerViewToView:(UIView *)bannerView {
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bannerView];
    [self.view addConstraints:@[
        [NSLayoutConstraint constraintWithItem:bannerView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.bottomLayoutGuide
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:bannerView
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1
                                      constant:0]
    ]];
}


// -- Banner Advert Listener Functions -----------------------------------------------------------------------------

// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
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
    self.bannerLoaded = false;
}

// Tells the delegate that a full-screen view will be presented in response to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
  NSLog(@"adViewWillPresentScreen");
}

// Tells the delegate that the full-screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
  NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full-screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
  NSLog(@"adViewDidDismissScreen");
}

// Tells the delegate that a user click will open another app (such as the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
  NSLog(@"adViewWillLeaveApplication");
}


// -- Interstitial Advert Button Functions -----------------------------------------------------------------------------

- (void)_loadInterstitial:(UIButton *)sender {
    [self loadInterstitial];
}

- (void)_showInterstitial:(UIButton *)sender {
    [self showInterstitial];
}

- (void)_loadAndShowInterstitial:(UIButton *)sender {
    [self loadAndShowInterstitial];
}

// -- Interstitial Advert Control Functions -----------------------------------------------------------------------------

- (void) loadInterstitial {
    self.interstitialView = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    [self.interstitialView loadRequest:[GADRequest request]];
    self.interstitialView.delegate = self;
}

- (void) showInterstitial {
    if (self.interstitialView.isReady) {
        [self.interstitialView presentFromRootViewController:self];
    } else {
        NSLog(@"Ad wasn't ready");
    }
}

- (void) loadAndShowInterstitial {
    self.loadAndShowInterstitialCheck = true;
    [self loadInterstitial];
}

// -- Interstitial Advert Listener Functions -----------------------------------------------------------------------------

// Tells the delegate an ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"interstitialDidReceiveAd");
    if (self.loadAndShowInterstitialCheck){
        [self showInterstitial];
        self.loadAndShowInterstitialCheck = false;
    }
}

// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
    didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

// Tells the delegate that an interstitial will be presented.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillPresentScreen");
}

// Tells the delegate the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillDismissScreen");
}

// Tells the delegate the interstitial had been animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialDidDismissScreen");
}

// Tells the delegate that a user click will open another app (such as the App Store), backgrounding the current app.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"interstitialWillLeaveApplication");
}

@end
