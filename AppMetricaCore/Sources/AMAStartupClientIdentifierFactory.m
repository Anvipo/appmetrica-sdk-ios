
#import "AMAStartupClientIdentifierFactory.h"
#import "AMAMetricaConfiguration.h"
#import "AMAMetricaPersistentConfiguration.h"
#import "AMAStartupClientIdentifier.h"

#if TARGET_OS_OSX

#else
#import <UIKit/UIKit.h>
#endif

@import AppMetricaIdentifiers;

@implementation AMAStartupClientIdentifierFactory

+ (AMAStartupClientIdentifier *)startupClientIdentifier
{
    AMAStartupClientIdentifier *identifier = [[AMAStartupClientIdentifier alloc] init];
    identifier.deviceID = [AMAMetricaConfiguration sharedInstance].persistent.deviceID;
    identifier.deviceIDHash = [AMAMetricaConfiguration sharedInstance].persistent.deviceIDHash;
    identifier.UUID = [AMAMetricaConfiguration sharedInstance].identifierProvider.appMetricaUUID;

#if TARGET_OS_OSX

#else
    identifier.IFV = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
#endif
    return identifier;
}

@end
