/*
 _______  _______  _       _________ _______  _______  _______
 (  ____ \(  ____ \( \      \__   __/(  ____ )(  ____ \(  ____ \
 | (    \/| (    \/| (         ) (   | (    )|| (    \/| (    \/
 | (__    | |      | |         | |   | (____)|| (_____ | (__
 |  __)   | |      | |         | |   |  _____)(_____  )|  __)
 | (      | |      | |         | |   | (            ) || (
 | (____/\| (____/\| (____/\___) (___| )      /\____) || (____/\
 (_______/(_______/(_______/\_______/|/       \_______)(_______/

 NIGHT MODE FOR IOS - Share Sheet Hook
 COPYRIGHT © 2019 GUILLERMO MORAN

 */

#include "../Utils/Interfaces.h"
#include "../Utils/UIColor+Eclipse.h"

#define VIEW_COLOR                      [UIColor eclipseSelectedViewColor]
#define NAV_COLOR                       [UIColor eclipseSelectedNavColor]
#define TEXT_COLOR                      [UIColor eclipseSelectedTextColor]

static NSDictionary *prefs = nil;

static void prefsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

    if (prefs) {
        prefs = nil;
        [prefs release];

    }

    prefs = [[NSDictionary alloc] initWithContentsOfFile:PREFS_FILE_PATH];

}

static BOOL isTweakEnabled() {
    return (prefs) ? [prefs[@"enabled"] boolValue] : NO;
    //return NO;
}

static BOOL alertsEnabled() {
    return (prefs) ? [prefs[@"alertsEnabled"] boolValue] : NO;
    //return NO;
}

static BOOL disableInSB() {
    return (prefs) ? [prefs[@"disableInSB"] boolValue] : NO;
    //return YES;
}

// %hook UIView
//
// -(void)layoutSubviews {
//     %orig;
//     if(isTweakEnabled() && !disableInSB()) {
//         [self setBackgroundColor: VIEW_COLOR];
//     }
// }
//
// -(void)setBackgroundColor:(UIColor *)arg1 {
//     BOOL enabled = isTweakEnabled() && !disableInSB();
//
//     if (enabled) {
//         CGRect frame = self.frame;
//
//         CGRect screenRect = [[UIScreen mainScreen] bounds];
//         CGFloat screenWidth = screenRect.size.width;
//
//         if(frame.size.width < screenWidth){
//             arg1 = VIEW_COLOR;
//         }
//     }
//
//     %orig(arg1);
// }
// %end

%hook UILabel
-(void)layoutSubviews {
    %orig;
    if(isTweakEnabled() && !disableInSB() && alertsEnabled()){
        [self setTextColor: TEXT_COLOR];
    }
}

-(void)setTextColor:(UIColor *)arg1 {
    if (isTweakEnabled() && !disableInSB() && alertsEnabled()) {
        arg1 = TEXT_COLOR;
    }
    %orig(arg1);
}
%end

%ctor {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    prefsChanged(NULL, NULL, NULL, NULL, NULL); // initialize prefs
    registerNotification(prefsChanged, PREFS_CHANGED_NOTIF);
    // %init(_ungrouped);
    [pool release];
}
