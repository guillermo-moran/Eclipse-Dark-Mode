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

static BOOL colorShareSheetsEnabled() {
    return (prefs) ? [prefs[@"colorShareSheets"] boolValue] : NO;
    //return NO;
}

%hook UILabel

-(void)layoutSubviews {
	%orig;
	if(isTweakEnabled() && colorShareSheetsEnabled()){
		[self setTextColor:TEXT_COLOR];
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
	}
}

-(void)setHidden:(BOOL)arg1 {
	if (isTweakEnabled() && colorShareSheetsEnabled()) {
		arg1 = true;
	}
	%orig(arg1);
}
%end

%hook _UIBackdropView

-(void)layoutSubviews {
	%orig;
	if (isTweakEnabled() && colorShareSheetsEnabled()) {
		[self setHidden: true];
	}
}

-(void)setHidden:(BOOL)arg1 {
	if (isTweakEnabled() && colorShareSheetsEnabled()) {
		arg1 = true;
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
