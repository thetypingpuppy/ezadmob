#import <Cordova/CDVPlugin.h>

@interface Admob : CDVPlugin

@property(nonatomic, retain) GADBannerView *bannerView;
@property(nonatomic, retain) GADInterstitial *interstitialView;

@property (nonatomic, retain) NSString* BANNER_ID;
@property (nonatomic, retain) NSString* INTERSTITIAL_ID;
@property (assign) boolean bannerOverlap;


- (void)init:(CDVInvokedUrlCommand*)command;

- (void)loadAndShowBanner:(CDVInvokedUrlCommand*)command;
- (void)loadBanner:(CDVInvokedUrlCommand*)command;
- (void)displayBanner:(CDVInvokedUrlCommand*)command;
- (void)removeBanner:(CDVInvokedUrlCommand*)command;

- (void)loadAndShowInterstitial:(CDVInvokedUrlCommand*)command;
- (void)loadInterstitial:(CDVInvokedUrlCommand*)command;
- (void)displayInterstitial:(CDVInvokedUrlCommand*)command;

@end