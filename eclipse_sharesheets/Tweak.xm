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

#define NAV_COLOR                       [UIColor eclipseSelectedNavColor]
#define TEXT_COLOR                      [UIColor eclipseSelectedTextColor]
#define VIEW_COLOR                      [UIColor eclipseSelectedViewColor]


static BOOL isLightColor(UIColor* color) {


    //BOOL is = NO;

    CGFloat white = 0;
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 0;
    [color getWhite:&white alpha:&alpha];
    [color getRed:&red green:&green blue:&blue alpha:&alpha];

    //return ((white >= 0.5) && (red >= 0.5) && (green >= 0.5)  && (blue >= 0.5) && (alpha >= 0.4) && (![color isEqual:selectedTintColor()]));

    if ((red <= 0.5) || (green <= 0.5) || (blue <= 0.5)) {
        return NO;
    }
    else if (white >= 0.5 && alpha > 0.7) {
        return YES;
    }
    else {
        return NO;
    }
}

static NSDictionary *prefs = nil;

static void prefsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

    if (prefs) {
        prefs = nil;
        [prefs release];

    }

    prefs = [[NSDictionary alloc] initWithContentsOfFile:PREFS_FILE_PATH];

}

static BOOL isTweakEnabled() {
    // NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    // BOOL applicationIsEnabledInSettings = [[prefs objectForKey:[@"EnabledApps-" stringByAppendingString:bundleIdentifier]] boolValue];
    BOOL tweakEnabled = (prefs) ? [prefs[@"enabled"] boolValue] : NO;
    return tweakEnabled;
    //return NO;
}

static BOOL colorShareSheetsEnabled() {
    return (prefs) ? [prefs[@"colorShareSheets"] boolValue] : NO;
    //return NO;
}

// %hook UIView

// -(void)layoutSubviews {
//     %orig;
//     if (isTweakEnabled()) {
//         if (isLightColor(self.backgroundColor)) {
//                 [self setBackgroundColor: VIEW_COLOR];
//         }
//     }
// }
//
// %end

%hook UIButton

-(void)layoutSubviews {
    %orig;
    if(isTweakEnabled() && colorShareSheetsEnabled()){
        [self setBackgroundColor: VIEW_COLOR];
    }
}

%end

%hook UILabel

-(void)layoutSubviews {
	%orig;
	if(isTweakEnabled() && colorShareSheetsEnabled()){
		[self setTextColor:TEXT_COLOR];
        [[[[self superview] superview] superview] setBackgroundColor:VIEW_COLOR];

	}
}

-(void)setTextColor:(UIColor *)arg1 {
	if(isTweakEnabled() && colorShareSheetsEnabled()){
		arg1 = TEXT_COLOR;
	}
	%orig(arg1);
	}
%end

%hook UITextView

-(void)layoutSubviews {
	%orig;
	if(isTweakEnabled() && colorShareSheetsEnabled()){
		[self setTextColor:TEXT_COLOR];
        [[self superview] setBackgroundColor:VIEW_COLOR];

	}
}

-(void)setTextColor:(UIColor *)arg1 {
	if(isTweakEnabled() && colorShareSheetsEnabled()){
		arg1 = TEXT_COLOR;
	}
	%orig(arg1);
	}
%end

%hook UIVisualEffectView

-(void)layoutSubviews {
	%orig;
	if (isTweakEnabled() && colorShareSheetsEnabled()) {
		[self setHidden: true];
        [[self superview] setBackgroundColor:VIEW_COLOR];
        // UIView* overlay = [[UIView alloc] initWithFrame:self.frame];
        // overlay.backgroundColor = [UIColor redColor];
        // overlay.userInteractionEnabled = NO;
        // overlay.alpha = 1;
        // [self addSubview: overlay];
	}
}

// -(void)setHidden:(BOOL)arg1 {
// 	if (isTweakEnabled() && colorShareSheetsEnabled()) {
// 		arg1 = true;
// 	}
// 	%orig(arg1);
// }
%end

%hook _UIBackdropView

-(void)layoutSubviews {
	%orig;
	if (isTweakEnabled() && colorShareSheetsEnabled()) {
		// [self setHidden: true];
        // [[self superview] setBackgroundColor:VIEW_COLOR];
        // UIView* overlay = [[UIView alloc] initWithFrame:self.frame];
        // overlay.backgroundColor = [UIColor redColor];;
        // overlay.userInteractionEnabled = NO;
        // overlay.alpha = 1;
        // [self addSubview: overlay];

	}
}

// -(void)setHidden:(BOOL)arg1 {
// 	if (isTweakEnabled() && colorShareSheetsEnabled()) {
// 		arg1 = true;
// 	}
// 	%orig(arg1);
// }

%end

%ctor {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    prefsChanged(NULL, NULL, NULL, NULL, NULL); // initialize prefs
    registerNotification(prefsChanged, PREFS_CHANGED_NOTIF);


    %init(_ungrouped);

    [pool release];
}
