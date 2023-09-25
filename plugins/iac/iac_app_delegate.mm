#import "iac_app_delegate.h"

#include "iac.h"

@implementation IACAppDelegate

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    const char* payload = [[url absoluteString] UTF8String];
    
    NSString *payloadNStr = [[NSString alloc] initWithUTF8String:payload];
    String payloadStr;
	payloadStr.parse_utf8([[payloadNStr copy] UTF8String]);

    if (IAC::get_singleton()) {
		IAC::get_singleton()->invocation(payloadStr);
	}

    return YES;
}


- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
    const char* payload = 0;

    if (launchOptions[UIApplicationLaunchOptionsURLKey]) {
        payload = [[[launchOptions valueForKey:UIApplicationLaunchOptionsURLKey] absoluteString] UTF8String];
    }

    if (IAC::get_singleton()) {
		IAC::get_singleton()->invocation(payload);
	}

    return YES;
}

@end