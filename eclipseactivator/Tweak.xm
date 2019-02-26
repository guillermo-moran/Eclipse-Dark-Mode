/*
  .d8b.   .o88b. d888888b d888888b db    db  .d8b.  d888888b  .d88b.  d8888b.
 d8' `8b d8P  Y8 `~~88~~'   `88'   88    88 d8' `8b `~~88~~' .8P  Y8. 88  `8D
 88ooo88 8P         88       88    Y8    8P 88ooo88    88    88    88 88oobY'
 88~~~88 8b         88       88    `8b  d8' 88~~~88    88    88    88 88`8b
 88   88 Y8b  d8    88      .88.    `8bd8'  88   88    88    `8b  d8' 88 `88.
 YP   YP  `Y88P'    YP    Y888888P    YP    YP   YP    YP     `Y88P'  88   YD
*/

#import <libactivator/libactivator.h>

#include <notify.h>


#define PREFS_CHANGED_NOTIF "com.gmoran.eclipse.prefs-changed"

#define PREFS_FILE_PATH @"/var/mobile/Library/Preferences/com.gmoran.eclipse.plist"

extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);


static BOOL isTweakEnabled(void) {
    //NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:PREFS_FILE_PATH];
    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
	return (prefs) ? [prefs[@"enabled"] boolValue] : NO;
}

@interface EclipseActivatorListener : NSObject <LAListener> {}
@end

@implementation EclipseActivatorListener

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event
{
    
    NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:PREFS_FILE_PATH];
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithDictionary:prefs];
    
    UIAlertView* toggleAlert;
    
    if (isTweakEnabled()) {
        [dict setValue:[NSNumber numberWithBool:NO] forKey:@"enabled"];
        [dict setValue:[NSNumber numberWithBool:NO] forKey:@"replaceSplashScreens"];
        
        toggleAlert = [[UIAlertView alloc]
                                    initWithTitle:@"Eclipse Disabled"
                                    message:@"Eclipse is now disabled. Please quit all applications running in the background for changes to take effect."
                                    delegate:nil
                                    cancelButtonTitle:@"Ok"
                                    otherButtonTitles:nil];
    }
    else {
        [dict setValue:[NSNumber numberWithBool:YES] forKey:@"enabled"];
        [dict setValue:[NSNumber numberWithBool:YES] forKey:@"replaceSplashScreens"];
        
         toggleAlert = [[UIAlertView alloc]
                                    initWithTitle:@"Eclipse Enabled"
                                    message:@"Eclipse is now enabled. Please quit all applications running in the background for changes to take effect."
                                    delegate:nil
                                    cancelButtonTitle:@"Ok"
                                    otherButtonTitles:nil];
    }
    
    [dict writeToFile:PREFS_FILE_PATH atomically:YES];
    //notify_post(PREFS_CHANGED_NOTIF);
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR(PREFS_CHANGED_NOTIF), NULL, NULL, TRUE);
    
    [toggleAlert show];
    [toggleAlert release];
    [dict release];
    [prefs release];
    [event setHandled: YES];
}

+ (void)load
{
    [[LAActivator sharedInstance] registerListener:[self new] forName:@"com.gmoran.eclipse"];
}

@end
