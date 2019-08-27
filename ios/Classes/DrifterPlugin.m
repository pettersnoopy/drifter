#import "DrifterPlugin.h"
#import <AdSupport/ASIdentifierManager.h>

@implementation DrifterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"me.wener.drifter" binaryMessenger:[registrar messenger]];
    DrifterPlugin* instance = [[DrifterPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getIdfa" isEqualToString:call.method]) {
        [self getIdfa:call result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

-(void)getIdfa:(FlutterMethodCall*)call result:(FlutterResult)result {
    if([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        NSUUID *identifier = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        result([identifier UUIDString]);
        return;
    }
    
    // Get and return IDFA
    return result(@"default-idfa");
}

@end
