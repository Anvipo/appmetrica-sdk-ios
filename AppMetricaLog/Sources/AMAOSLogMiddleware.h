
#import "AMALogMiddleware.h"

API_AVAILABLE(macos(10.12), ios(10.0), watchos(3.0), tvos(10.0))
@interface AMAOSLogMiddleware : NSObject <AMALogMiddleware>

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithCategory:(const char *)category;

@end
