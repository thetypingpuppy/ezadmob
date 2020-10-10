#import <Cordova/CDVPlugin.h>

@interface ezadmob : CDVPlugin

- (void)LOAD_AND_SHOW_BANNER:(CDVInvokedUrlCommand*)command;
- (void)REMOVE_BANNER:(CDVInvokedUrlCommand*)command;
- (void)LOAD_BANNER:(CDVInvokedUrlCommand*)command;
- (void)DISPLAY_BANNER:(CDVInvokedUrlCommand*)command;


@end
