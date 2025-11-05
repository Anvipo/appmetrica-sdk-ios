
#import <AppMetricaCoreUtils/AppMetricaCoreUtils.h>

NS_ASSUME_NONNULL_BEGIN

@class AMARSAKey;

NS_SWIFT_NAME(RSACrypter)
API_AVAILABLE(ios(13.0), tvos(13.0))
@interface AMARSACrypter : NSObject <AMADataEncoding>

@property (nonatomic, strong, readonly) AMARSAKey *publicKey;
@property (nonatomic, strong, readonly) AMARSAKey *privateKey;

+ (NSString *)message;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithPublicKey:(AMARSAKey *)publicKey privateKey:(AMARSAKey *)privateKey;

@end

NS_ASSUME_NONNULL_END
