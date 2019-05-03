#import <sys/utsname.h>

// Link to MobileGestalt in your makefile!
// xxx_LIBRARIES = MobileGestalt
OBJC_EXTERN CFStringRef MGCopyAnswer(CFStringRef key) WEAK_IMPORT_ATTRIBUTE;

@interface DRMUtils : NSObject {}

- (NSString*)deviceModelIdentifier;
- (NSString*)deviceUDID;
- (int)packageWasPurchased;

@end
