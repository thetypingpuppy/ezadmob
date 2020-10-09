//
//  ViewController.m
//  admobTestiOS
//
//  Created by Brandon Corbett on 09/10/2020.
//  Copyright © 2020 Brandon Corbett. All rights reserved.
//

#import "ViewController.h"

@import GoogleMobileAds;

@interface ViewController () <GADBannerViewDelegate>

@property(nonatomic, strong) GADBannerView *bannerView;
@property(assign) bool bannerLoaded;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bannerLoaded = false;
    
    // Load banner view button
    UIButton *loadBannerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loadBannerButton addTarget:self
                         action:@selector(loadBannerButton:) forControlEvents:UIControlEventTouchUpInside];
    [loadBannerButton setTitle:@"Load Banner" forState:UIControlStateNormal];
    [loadBannerButton setFrame: CGRectMake(80, 210, 160, 40)];
    [self.view addSubview:loadBannerButton];
    
    // Remove banner view button
    UIButton *removeBannerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [removeBannerButton addTarget:self
                         action:@selector(removeBannerButton:) forControlEvents:UIControlEventTouchUpInside];
    [removeBannerButton setTitle:@"Remove Banner" forState:UIControlStateNormal];
    [removeBannerButton setFrame: CGRectMake(80, 250, 160, 40)];
    [self.view addSubview:removeBannerButton];
     
    // Show banner view button
    UIButton *showBannerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [showBannerButton addTarget:self
                         action:@selector(showBannerButton:) forControlEvents:UIControlEventTouchUpInside];
    [showBannerButton setTitle:@"Show Banner" forState:UIControlStateNormal];
    [showBannerButton setFrame: CGRectMake(80, 300, 160, 40)];
    [self.view addSubview:showBannerButton];
}

// -- Banner Advert Button Functions -----------------------------------------------------------------------------

- (void)loadBannerButton:(UIButton *)sender {
    [self loadBanner];
}

- (void)removeBannerButton:(UIButton *)sender {
    [self removeBanner];
}

- (void)showBannerButton:(UIButton *)sender {
    [self showBanner];
}

// -- Banner Advert Control Functions -----------------------------------------------------------------------------

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

// -- Interstitial Advert Control Functions -----------------------------------------------------------------------------

// -- Interstitial Advert Listener Functions -----------------------------------------------------------------------------


@end
