#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"

#include <notify.h>

#define PREFS_FILE_PATH @"/var/mobile/Library/Preferences/com.gmoran.eclipse.plist"

#define PREFS_CHANGED_NOTIF "com.gmoran.eclipse.prefs-changed"

extern CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

static BOOL isTweakEnabled(void) {
    //NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:PREFS_FILE_PATH];
    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
	return (prefs) ? [prefs[@"enabled"] boolValue] : NO;
}

@interface EclipseFlipswitchSwitch : NSObject <FSSwitchDataSource>
@end

@implementation EclipseFlipswitchSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
    return isTweakEnabled();
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
    NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:PREFS_FILE_PATH];
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithDictionary:prefs];
    
    switch (newState) {
        case FSSwitchStateIndeterminate:
            break;
        case FSSwitchStateOn:
            [dict setValue:[NSNumber numberWithBool:YES] forKey:@"enabled"];
            [dict setValue:[NSNumber numberWithBool:YES] forKey:@"replaceSplashScreens"];
            break;
        case FSSwitchStateOff:
            [dict setValue:[NSNumber numberWithBool:NO] forKey:@"enabled"];
            [dict setValue:[NSNumber numberWithBool:NO] forKey:@"replaceSplashScreens"];
            break;
    }
    [dict writeToFile:PREFS_FILE_PATH atomically:YES];
    //notify_post(PREFS_CHANGED_NOTIF);
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR(PREFS_CHANGED_NOTIF), NULL, NULL, TRUE);
    [dict release];
    [prefs release];
    return;
}

- (NSString *)titleForSwitchIdentifier:(NSString *)switchIdentifier {
    return @"Eclipse";
}

@end