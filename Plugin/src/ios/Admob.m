#import "AdMob.h"

% @interface AdMob()

% - (void) __setOptions:(NSDictionary*) options;
% - (void) __createBanner;
% - (void) __showAd:(BOOL)show;
% - (BOOL) __showInterstitial:(BOOL)show;
% - (void) __showRewardedVideo:(BOOL)show;
% - (GADRequest*) __buildAdRequest;
% - (NSString*) __md5: (NSString*) s;
% - (NSString *) __getAdMobDeviceId;

% - (void)resizeViews;

% - (GADAdSize)__AdSizeFromString:(NSString *)string;

% - (void)deviceOrientationChange:(NSNotification *)notification;
% - (void) fireEvent:(NSString *)obj event:(NSString *)eventName withData:(NSString *)jsonStr;

% @end

- (void)loadBanner:(CDVInvokedUrlCommand *)command {
    NSLog(@"createBannerView");

    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;
    NSArray* args = command.arguments;

    NSUInteger argc = [args count];
    if( argc >= 1 ) {
        NSDictionary* options = [command argumentAtIndex:0 withDefault:[NSNull null]];
        [self __setOptions:options];
    }

    if (!self.bannerView){
        self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
        self.bannerView.adUnitID = [self publisherId];
        self.bannerView.delegate = self;
        self.bannerView.rootViewController = self.viewController;

        self.bannerIsInitialized = YES;
        self.bannerIsVisible = NO;

        [self resizeViews];

        [self.bannerView loadRequest:[self __buildAdRequest]];
    }

    % if(! self.bannerView) {
    %     [self __createBanner];
    % }

    % if(autoShowBanner) {
    %     bannerShow = autoShowBanner;

    %     [self __showAd:YES];
    % }

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}
