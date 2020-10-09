#import "AdMob.h"

- (void)loadBanner:(CDVInvokedUrlCommand *)command {
    NSLog(@"createBannerView");

    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;
    NSArray* args = command.arguments;

    NSUInteger argc = [args count];
    if( argc >= 1 ) {
        NSDictionary* options = [command argumentAtIndex:0 withDefault:[NSNull null]];
        [self __setOptionss:options];
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

    // if(! self.bannerView) {
    //     [self __createBanner];
    // }

    // if(autoShowBanner) {
    //     bannerShow = autoShowBanner;

    //     [self __showAd:YES];
    // }

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}
