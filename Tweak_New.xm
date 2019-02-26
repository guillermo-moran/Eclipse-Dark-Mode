/*
 _______  _______  _       _________ _______  _______  _______
 (  ____ \(  ____ \( \      \__   __/(  ____ )(  ____ \(  ____ \
 | (    \/| (    \/| (         ) (   | (    )|| (    \/| (    \/
 | (__    | |      | |         | |   | (____)|| (_____ | (__
 |  __)   | |      | |         | |   |  _____)(_____  )|  __)
 | (      | |      | |         | |   | (            ) || (
 | (____/\| (____/\| (____/\___) (___| )      /\____) || (____/\
 (_______/(_______/(_______/\_______/|/       \_______)(_______/
 
 NIGHT MODE FOR IOS - UIKit Hooks
 COPYRIGHT © 2014 GUILLERMO MORAN
 
*/

#import <objc/runtime.h>

#include "Interfaces.h"
#include "UIColor+Eclipse.h"

#include <notify.h>

/*
d8888b. d8888b. d88888b d88888b .d8888.
88  `8D 88  `8D 88'     88'     88'  YP
88oodD' 88oobY' 88ooooo 88ooo   `8bo.
88~~~   88`8b   88~~~~~ 88~~~     `Y8b.
88      88 `88. 88.     88      db   8D
88      88   YD Y88888P YP      `8888Y'
*/

///



static BOOL shouldOverrideStatusBarStyle = YES;

static NSDictionary *prefs = nil;

extern "C" void BKSTerminateApplicationGroupForReasonAndReportWithDescription(int a, int b, int c, NSString *description);

static void quitAllApps() {
    
    SBUIController *sharedUI = [%c(SBUIController) sharedInstance];
    SBAppSwitcherController *appSwitcherCont = [sharedUI _appSwitcherController];
    id iconController =  MSHookIvar<id>(appSwitcherCont, "_iconController");
    
    NSMutableArray *displayItemList = MSHookIvar<NSMutableArray *>(iconController, "_appList");
    
    NSMutableArray *toKill = [[NSMutableArray alloc] init];
    
    
    for (SBDisplayLayout *displayLayout in displayItemList) {
        NSMutableArray *dispItems = [[NSMutableArray alloc] initWithArray:[displayLayout.displayItems copy]];
        
        SBDisplayItem *dispItem = dispItems[0];
        
        if (![dispItem.type isEqualToString:@"Homescreen"]) {
            
            [toKill addObject:dispItem];
            
        }
    }
    
    for (id killApp in toKill) {
        
        [appSwitcherCont _quitAppWithDisplayItem:killApp];
    }
     
    
}
    
extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

static void quitAppsRequest(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Please Wait"
                          message:@"Terminating All Applications..."
                          delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:nil];
    [alert show];
    
    quitAllApps();
    
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

static void wallpaperChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    
    
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR(PREFS_CHANGED_NOTIF), NULL, NULL, TRUE);
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Eclipse 2"
    message:@"Please respring your device for changes to take effect."
    delegate:nil
    cancelButtonTitle:@"OK"
    otherButtonTitles: nil];
    [alert show];
    
}



static void prefsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    
	// reload prefs
	[prefs release];
    
    //Delete old prefs file
    
	if ((prefs = [[NSDictionary alloc] initWithContentsOfFile:PREFS_FILE_PATH]) == nil) {
        
        NSLog(@"CREATING PREFERENCE FILE");
            
        prefs = @{@"enabled": @NO,
                  @"themeNPView": @NO,
                  @"colorDetailText": @YES,
                  @"translucentNavbars": @NO,
                  @"replaceSplashScreens": @NO,
                  @"disableInSB": @NO,
                  @"cellSeparatorsEnabled": @NO,
                  @"tintSMSBubbles": @NO,
                  
                  //Selections
                  @"selectedTint": @0,
                  @"selectedTheme": @0,
                  @"selectedNavColor": @0,
                  
                  @"selectedKeyboardColor": @0,
                  @"selectedSplashScreenColor": @0,
                  @"selectedDockColor": @0,
                  @"selectedCCColor": @0,
                  
                  //Colors
                  @"customColorsEnabled": @NO,
                  @"customNavBarHex":@"",
                  @"customThemeHex":@"",
                  @"customTintHex":@"",
                  @"customStatusbarHex":@"",
                  @"customTextHex":@"",
                  
                  
                  @"darkenWallpapers": @NO};
        
		[prefs writeToFile:PREFS_FILE_PATH atomically:YES];
		prefs = [[NSDictionary alloc] initWithContentsOfFile:PREFS_FILE_PATH];
	}
}


static BOOL isTweakEnabled(void) {
	return (prefs) ? [prefs[@"enabled"] boolValue] : NO;
    
}

static BOOL shouldColorDetailText(void) {
	return (prefs) ? [prefs[@"colorDetailText"] boolValue] : YES;
}

static BOOL translucentNavbarEnabled(void) {
	return (prefs) ? [prefs[@"translucentNavbars"] boolValue] : YES;
}


static BOOL customColorEnabled(void) {
    return (prefs) ? [prefs[@"customColorsEnabled"] boolValue] : YES;
}
 

static BOOL cellSeparatorsEnabled(void) {
    return (prefs) ? [prefs[@"cellSeparatorsEnabled"] boolValue] : YES;
}

static BOOL tintSMSBubbles(void) {
    return (prefs) ? [prefs[@"tintSMSBubbles"] boolValue] : YES;
}

//Custom Colors
static BOOL customNavColorEnabled(void) {
    //return (prefs) ? [prefs[@"customNavColorsEnabled"] boolValue] : YES;
    return (prefs) ? [prefs[@"customColorsEnabled"] boolValue] : YES;
}

static BOOL customThemeColorEnabled(void) {
    //return (prefs) ? [prefs[@"customThemeColorsEnabled"] boolValue] : YES;
    return (prefs) ? [prefs[@"customColorsEnabled"] boolValue] : YES;
}

static BOOL customTintColorEnabled(void) {
    //return (prefs) ? [prefs[@"customTintColorsEnabled"] boolValue] : YES;
    return (prefs) ? [prefs[@"customColorsEnabled"] boolValue] : YES;
}

static BOOL customStatusbarColorEnabled(void) {
    //return (prefs) ? [prefs[@"customStatusbarColorsEnabled"] boolValue] : YES;
    return (prefs) ? [prefs[@"customColorsEnabled"] boolValue] : YES;
}

static BOOL customTextColorEnabled(void) {
    //return (prefs) ? [prefs[@"customTextColorsEnabled"] boolValue] : YES;
    return (prefs) ? [prefs[@"customColorsEnabled"] boolValue] : YES;
}

//Installed Checks

static BOOL isMessageCustomiserInstalled() {
     return [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/CustomMessagesColour.dylib"];
    
}

//Experimental Features
static BOOL darkenKeyboard(void) {
	return (prefs) ? [prefs[@"darkenKeyboard"] boolValue] : NO;
}


static BOOL isEnabled = isTweakEnabled();



//Useful Macros

#define colorWithHexString(h,a) [UIColor colorWithHexString:h alpha:a]
#define darkerColorForColor(c) [UIColor darkerColorForColor:c]


//Selections

static int selectedTheme(void) {
    int selectedTheme = [[prefs objectForKey:@"selectedTheme"] intValue];
    return selectedTheme;
}

static int selectedNavColor(void) {
    int selectedTheme = [[prefs objectForKey:@"selectedNavColor"] intValue];
    return selectedTheme;
}

static int selectedKeyboardColor(void) {
    int selectedTheme = [[prefs objectForKey:@"selectedKeyboardColor"] intValue];
    return selectedTheme;
}

//HEX Colors

/*
 @"customColorEnabled": @NO,
 @"customNavBarHex":@"",
 @"customThemeHex":@"",
 @"customTintHex":@"",
 @"customStatusbarHex":@"",
*/

static UIColor* hexNavColor(void) {
    
    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    NSString* hex = [prefs objectForKey:@"customNavBarHex"];
    
    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;
    
    
    //UIColor *color = colorFromDefaultsWithKey(@"com.gmoran.eclipse", @"customNavBarHex", @"#0A0A0A");
    //return color;
}

static UIColor* hexThemeColor(void) {
    
    NSString* hex = [prefs objectForKey:@"customThemeHex"];
    
    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;
    
    
    //UIColor *color = colorFromDefaultsWithKey(@"com.gmoran.eclipse", @"customThemeHex", @"#1E1E1E");
    //return color;
}

static UIColor* hexTintColor(void) {

    NSString* hex = [prefs objectForKey:@"customTintHex"];
    hex = [hex stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;
    
    
    //UIColor *color = colorFromDefaultsWithKey(@"com.gmoran.eclipse", @"customTintHex", @"#00A3EB");
    //return color;
}

static UIColor* hexStatusbarColor(void) {
    
    NSString* hex = [prefs objectForKey:@"customStatusbarHex"];
    hex = [hex stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;
    
     
    //UIColor *color = colorFromDefaultsWithKey(@"com.gmoran.eclipse", @"customStatusbarHex", @"#E6E6E6");
    //return color;
}

static UIColor* hexTextColor(void) {
    
    NSString* hex = [prefs objectForKey:@"customTextHex"];
    
    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;
    
    
    //UIColor *color = colorFromDefaultsWithKey(@"com.gmoran.eclipse", @"customTextHex", @"#E6E6E6");
    //return color;
}

/* -------------------------- */

static UIColor* textColor(void) {
    if (customTextColorEnabled()) {
        if (hexTextColor()) {
            return hexTextColor();
        }
    }
    
    return [UIColor colorWithRed:230.0/255.0f green:230.0/255.0f blue:230.0/255.0f alpha:1.0f];
}

static UIColor* selectedTableColor(void) {
    int number = [[prefs objectForKey:@"selectedTheme"] intValue];
    
    if (customThemeColorEnabled()) {
        if (hexThemeColor()) {
            return hexThemeColor();
        }
    }
    
    if (number == -1) {
        return MIDNIGHT_TABLE_COLOR;
    }
    
    else if (number == 0) {
        return NIGHT_TABLE_COLOR;
    }
    else if (number == 1) {
        return GRAPHITE_TABLE_COLOR;
    }
    else if (number == 2) {
        return SILVER_TABLE_COLOR;
    }
    else if (number == 3) {
        return CRIMSON_TABLE_COLOR;
    }
    else if (number == 4) {
        return ROSE_PINK_TABLE_COLOR;
    }
    else if (number == 5) {
        return GRAPE_TABLE_COLOR;
    }
    else if (number == 6) {
        return WINE_TABLE_COLOR;
    }
    else if (number == 7) {
        return VIOLET_TABLE_COLOR;
    }
    else if (number == 8) {
        return SKY_TABLE_COLOR;
    }
    else if (number == 9) {
        return LAPIS_TABLE_COLOR;
    }
    else if (number == 10) {
        return NAVY_TABLE_COLOR;
    }
    else if (number == 11) {
        return DUSK_TABLE_COLOR;
    }
    else if (number == 12) {
        return JUNGLE_TABLE_COLOR;
    }
    else if (number == 13) {
        return BAMBOO_TABLE_COLOR;
    }
    else if (number == 14) {
        return SAFFRON_TABLE_COLOR;
    }
    else if (number == 15) {
        return CITRUS_TABLE_COLOR;
    }
    else if (number == 16) {
        return AMBER_TABLE_COLOR;
    }
    
    else {
        return NIGHT_TABLE_COLOR;
    }

}

static UIColor* selectedViewColor(void) {
    int number = [[prefs objectForKey:@"selectedTheme"] intValue];
    
    if (customThemeColorEnabled()) {
        if (hexThemeColor()) {
            return darkerColorForColor(hexThemeColor());
        }
    }
    
    if (number == -1) {
        return MIDNIGHT_VIEW_COLOR;
    }
    else if (number == 0) {
        return NIGHT_VIEW_COLOR;
    }
    else if (number == 1) {
        return GRAPHITE_VIEW_COLOR;
    }
    else if (number == 2) {
        return SILVER_VIEW_COLOR;
    }
    else if (number == 3) {
        return CRIMSON_VIEW_COLOR;
    }
    else if (number == 4) {
        return ROSE_PINK_VIEW_COLOR;
    }
    else if (number == 5) {
        return GRAPE_VIEW_COLOR;
    }
    else if (number == 6) {
        return WINE_VIEW_COLOR;
    }
    else if (number == 7) {
        return VIOLET_VIEW_COLOR;
    }
    else if (number == 8) {
        return SKY_VIEW_COLOR;
    }
    else if (number == 9) {
        return LAPIS_VIEW_COLOR;
    }
    else if (number == 10) {
        return NAVY_VIEW_COLOR;
    }
    else if (number == 11) {
        return DUSK_VIEW_COLOR;
    }
    else if (number == 12) {
        return JUNGLE_VIEW_COLOR;
    }
    else if (number == 13) {
        return BAMBOO_VIEW_COLOR;
    }
    else if (number == 14) {
        return SAFFRON_VIEW_COLOR;
    }
    else if (number == 15) {
        return CITRUS_VIEW_COLOR;
    }
    else if (number == 16) {
        return AMBER_VIEW_COLOR;
    }
    
    
    else {
        return NIGHT_VIEW_COLOR;
    }

}

static UIColor* selectedBarColor(void) {
    int number = [[prefs objectForKey:@"selectedNavColor"] intValue];
    
    if (customNavColorEnabled()) {
        if (hexNavColor()) {
            return hexNavColor();
        }
    }
    
    if (number == -1) {
        return MIDNIGHT_BAR_COLOR;
    }
    else if (number == 0) {
        return NIGHT_BAR_COLOR;
    }
    else if (number == 1) {
        return GRAPHITE_BAR_COLOR;
    }
    else if (number == 2) {
        return SILVER_BAR_COLOR;
    }
    else if (number == 3) {
        return CRIMSON_BAR_COLOR;
    }
    else if (number == 4) {
        return ROSE_PINK_BAR_COLOR;
    }
    else if (number == 5) {
        return GRAPE_BAR_COLOR;
    }
    else if (number == 6) {
        return WINE_BAR_COLOR;
    }
    else if (number == 7) {
        return VIOLET_BAR_COLOR;
    }
    else if (number == 8) {
        return SKY_BAR_COLOR;
    }
    else if (number == 9) {
        return LAPIS_BAR_COLOR;
    }
    else if (number == 10) {
        return NAVY_BAR_COLOR;
    }
    else if (number == 11) {
        return DUSK_BAR_COLOR;
    }
    else if (number == 12) {
        return JUNGLE_BAR_COLOR;
    }
    else if (number == 13) {
        return BAMBOO_BAR_COLOR;
    }
    else if (number == 14) {
        return SAFFRON_BAR_COLOR;
    }
    else if (number == 15) {
        return CITRUS_BAR_COLOR;
    }
    else if (number == 16) {
        return AMBER_BAR_COLOR;
    }
    
    
    else {
        return NIGHT_BAR_COLOR;
    }

}


#define TABLE_COLOR selectedTableColor() //Used for TableView

#define NAV_COLOR selectedBarColor() //Used for NavBars, Toolbars, TabBars

#define VIEW_COLOR selectedViewColor() //Used for TableCells, UIViews

//Advanced Settings

static UIColor* keyboardColor(void) {
    int number = selectedKeyboardColor();
    
    /*
    if (customColorEnabled()) {
        if (hexNavColor()) {
            return hexNavColor();
        }
    }
     */
    
    if (number == -2) {
        return VIEW_COLOR;
    }
    
    else if (number == -1) {
        return MIDNIGHT_TABLE_COLOR;
    }
    
    else if (number == 0) {
        return NIGHT_TABLE_COLOR;
    }
    else if (number == 1) {
        return GRAPHITE_TABLE_COLOR;
    }
    else if (number == 2) {
        return SILVER_TABLE_COLOR;
    }
    else if (number == 3) {
        return CRIMSON_TABLE_COLOR;
    }
    else if (number == 4) {
        return ROSE_PINK_TABLE_COLOR;
    }
    else if (number == 5) {
        return GRAPE_TABLE_COLOR;
    }
    else if (number == 6) {
        return WINE_TABLE_COLOR;
    }
    else if (number == 7) {
        return VIOLET_TABLE_COLOR;
    }
    else if (number == 8) {
        return SKY_TABLE_COLOR;
    }
    else if (number == 9) {
        return LAPIS_TABLE_COLOR;
    }
    else if (number == 10) {
        return NAVY_TABLE_COLOR;
    }
    else if (number == 11) {
        return DUSK_TABLE_COLOR;
    }
    else if (number == 12) {
        return JUNGLE_TABLE_COLOR;
    }
    else if (number == 13) {
        return BAMBOO_TABLE_COLOR;
    }
    else if (number == 14) {
        return SAFFRON_TABLE_COLOR;
    }
    else if (number == 15) {
        return CITRUS_TABLE_COLOR;
    }
    else if (number == 16) {
        return AMBER_TABLE_COLOR;
    }
    
    else {
        return TABLE_COLOR;
    }
}

//Other Colors

//#define ALT_TEXT_COLOR [UIColor colorWithRed:180.0/255.0f green:180.0/255.0f blue:180.0/255.0f alpha:1.0f] //Replaces text colors

#define TEXT_COLOR textColor()

//#define TABLE_SEPARATOR_COLOR [UIColor colorWithRed:60.0/255.0f green:60.0/255.0f blue:60.0/255.0f alpha:1.0f] //Table Separators

static UIColor* tableSeparatorColor(void) {
    if (cellSeparatorsEnabled()) {
        return [UIColor colorWithRed:60.0/255.0f green:60.0/255.0f blue:60.0/255.0f alpha:1.0f];
    }
    else {
        return [UIColor darkerColorForSelectionColor:TABLE_COLOR];
    }
}

#define TABLE_SEPARATOR_COLOR TABLE_COLOR



static UIColor* selectedStatusbarTintColor(void) {
    int number = [[prefs objectForKey:@"statusbarTint"] intValue];
    
    if (customStatusbarColorEnabled()) {
        if (hexStatusbarColor()) {
            return hexStatusbarColor();
        }
    }
    
    if (number == 0) {
        //return textColor(); //White
        return WHITE_COLOR;
    }
    else if (number == 1) {
        return BABY_BLUE_COLOR;
    }
    else if (number == 2) {
        return DARK_ORANGE_COLOR;
    }
    else if (number == 3) {
        return PINK_COLOR;
    }
    else if (number == 4) {
        return GREEN_COLOR;
    }
    else if (number == 5) {
        return PURPLE_COLOR;
    }
    else if (number == 6) {
        return RED_COLOR;
    }
    else if (number == 7) {
        return YELLOW_COLOR;
    }
    
    else {
        //return textColor(); //White
        return WHITE_COLOR;
    }

}


static UIColor* selectedTintColor(void) {
   
    int number = [[prefs objectForKey:@"selectedTint"] intValue];
    
    if (customTintColorEnabled()) {
        if (hexTintColor()) {
            return hexTintColor();
        }
    }
    
    if (number == 0) {
        return BABY_BLUE_COLOR;
    }
    if (number == 1) {
        return WHITE_COLOR;
    }
    if (number == 2) {
        return DARK_ORANGE_COLOR;
    }
    if (number == 3) {
        return PINK_COLOR;
    }
    if (number == 4) {
        return GREEN_COLOR;
    }
    if (number == 5) {
        return PURPLE_COLOR;
    }
    if (number == 6) {
        return RED_COLOR;
    }
    if (number == 7) {
        return YELLOW_COLOR;
    }
    if (number == 8) {
        
        
        NSArray* availableColors = @[BABY_BLUE_COLOR, WHITE_COLOR, PINK_COLOR, DARK_ORANGE_COLOR, GREEN_COLOR, PURPLE_COLOR, RED_COLOR, YELLOW_COLOR];
        
        UIColor* rand = availableColors.count == 0 ? nil : availableColors[arc4random_uniform(availableColors.count)];
        
        return rand;
    }
    else {
        return BABY_BLUE_COLOR;
    }

    
}

static void setTintColors() {
    [[UINavigationBar appearance] setTintColor:selectedTintColor()];
    [[UISlider appearance] setMinimumTrackTintColor:selectedTintColor()];
    [[UIToolbar appearance] setTintColor:selectedTintColor()];
    [[UITabBar appearance] setTintColor:selectedTintColor()];
    
    [[UITextView appearance] setTintColor:selectedTintColor()];
    [[UITextField appearance] setTintColor:selectedTintColor()];
    
    [[UITableView appearance] setTintColor:selectedTintColor()];
    
}

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

static BOOL isTextDarkColor(UIColor* color) {
    
    /*
    CGFloat white = 0;
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    [color getWhite:&white alpha:nil];
    [color getRed:&red green:&green blue:&blue alpha:nil];
    
   return ((white <= 0.5) && (red <= 0.5) && (green <= 0.5)  && (blue <= 0.5) && (![color isEqual:selectedTintColor()]));
     */
    
    if ([UIColor color:color isEqualToColor:[UIColor blackColor] withTolerance:0.7] && (![color isEqual:selectedTintColor()])) {
        return YES;
    }
    else {
        return NO;
    }
    
}

//Uniformity Support


static void darkenUIElements() {

    
    setTintColors();
    /*
    //[[UINavigationBar appearance] setBarTintColor:NAV_COLOR];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    [[UIToolbar appearance] setBarTintColor:NAV_COLOR];
    //[[UIToolbar appearance] setBarStyle:UIBarStyleBlack];
    
    [[UITabBar appearance] setBarTintColor:NAV_COLOR];
    [[UITabBar appearance] setBarStyle:UIBarStyleBlack];
    
    [[UISwitch appearance] setTintColor:[selectedTintColor() colorWithAlphaComponent:0.6]];
    [[UISwitch appearance] setOnTintColor:[selectedTintColor() colorWithAlphaComponent:0.3]];
    //[[UISwitch appearance] setThumbTintColor:TEXT_COLOR];
    */
    
}




/*
 _   _             _             _   _
 | \ | |           (_)           | | (_)
 |  \| | __ ___   ___  __ _  __ _| |_ _  ___  _ __
 | . ` |/ _` \ \ / / |/ _` |/ _` | __| |/ _ \| '_ \
 | |\  | (_| |\ V /| | (_| | (_| | |_| | (_) | | | |
 |_| \_|\__,_| \_/ |_|\__, |\__,_|\__|_|\___/|_| |_|
                       __/ |
                      |___/
 */

%hook UINavigationBar

-(void)drawRect:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        [self setBarStyle:UIBarStyleBlack];
        [self setBarTintColor:NAV_COLOR];
    }
}

-(void)_commonNavBarInit {
    %orig;
    if (isEnabled) {
        [self setBarStyle:UIBarStyleBlack];
        [self setBarTintColor:NAV_COLOR];
    }
    
}

%end

%hook UIToolbar

-(void)drawRect:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        [self setBarStyle:UIBarStyleBlack];
        [self setBarTintColor:NAV_COLOR];
    }
}

-(void)layoutSubviews {
    %orig;
    
    if (isEnabled) {
        [self setBarStyle:UIBarStyleBlack];
        [self setBarTintColor:NAV_COLOR];
    }
}

%end

%hook UITabBar

-(void)drawRect:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        [self setBarStyle:UIBarStyleBlack];
        [self setBarTintColor:NAV_COLOR];
    }
}

-(void)_doCommonTabBarInit {
    %orig;
    if (isEnabled) {
        [self setBarStyle:UIBarStyleBlack];
        [self setBarTintColor:NAV_COLOR];
    }
}

%end




/*
  _    _ _______      ___
 | |  | |_   _\ \    / (_)
 | |  | | | |  \ \  / / _  _____      __
 | |  | | | |   \ \/ / | |/ _ \ \ /\ / /
 | |__| |_| |_   \  /  | |  __/\ V  V /
  \____/|_____|   \/   |_|\___| \_/\_/
*/

/*
  _______    _     _
 |__   __|  | |   | |
    | | __ _| |__ | | ___  ___
    | |/ _` | '_ \| |/ _ \/ __|
    | | (_| | |_) | |  __/\__ \
    |_|\__,_|_.__/|_|\___||___/
*/

/*
  _    _ _____ _           _          _
 | |  | |_   _| |         | |        | |
 | |  | | | | | |     __ _| |__   ___| |
 | |  | | | | | |    / _` | '_ \ / _ \ |
 | |__| |_| |_| |___| (_| | |_) |  __/ |
  \____/|_____|______\__,_|_.__/ \___|_|
*/

/*
   _____     _ _
  / ____|   | | |
 | |     ___| | |___
 | |    / _ \ | / __|
 | |___|  __/ | \__ \
  \_____\___|_|_|___/
 
*/

/*
 db    db d888888b  .d8b.  d8888b. d8888b.
 88    88   `88'   d8' `8b 88  `8D 88  `8D
 88    88    88    88ooo88 88oodD' 88oodD'
 88    88    88    88~~~88 88~~~   88~~~
 88b  d88   .88.   88   88 88      88
 ~Y8888P' Y888888P YP   YP 88      88
 */

#define idIsEqual(id) [[self displayIdentifier] isEqualToString:id]

static BOOL UniformityInstalled() {
    return [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/Uniformity.dylib"];
}

@interface UIApplication(Eclipse)
-(id)displayIdentifier;
-(void)checkRunningApp;
    @end

%group UIApp

%hook UIApplication

%new
-(void)checkRunningApp {
    /*
    //Third Party Application
    if (idIsEqual(@"us.mxms.relay")) {
        //%init(RelayApp);
    }
    if (idIsEqual(@"com.vine.iphone")) {
        //VineApp
    }
    if (idIsEqual(@"com.tumblr.tumblr")) {
        %init(TumblrApp);
    }
    if (idIsEqual(@"com.tapbots.Tweetbot3")) {
        %init(TweetbotApp);
    }
    if (idIsEqual(@"ph.telegra.Telegraph")) {
        %init(TelegramApp);
    }
    if (idIsEqual(@"com.kik.chat")) {
        %init(KikApp);
    }
    if (idIsEqual(@"com.atebits.Tweetie2")) {
        %init(TwitterApp);
    }
    if (idIsEqual(@"com.burbn.instagram")) {
        %init(InstagramApp);
    }
    if (idIsEqual(@"net.whatsapp.WhatsApp")) {
        %init(WhatsappApp);
    }
    //Added 6/4/14
    if (idIsEqual(@"com.toyopagroup.picaboo")) {
        %init(SnapchatApp);
    }
    if (idIsEqual(@"com.soundcloud.TouchApp")) {
        %init(SoundcloudApp);
    }
    //Added 9/19/14
    if (idIsEqual(@"com.facebook.Messenger")) {
        %init(FBMessenger);
    }
    //Added 9/28
    if (idIsEqual(@"ch.threema.iapp")) {
        %init(ThreemaApp);
    }
    //Added 10/1
    if (idIsEqual(@"com.cardify.tinder")) {
        %init(TinderApp);
    }
    
    //Stock Applications
    
    if (idIsEqual(@"com.apple.mobilephone")) {
        %init(PhoneApp);
        
        //dlopen("/Library/MobileSubstrate/DynamicLibraries/SleekPhone.dylib", RTLD_NOW);
    }
    if (idIsEqual(@"com.apple.mobilemail")) {
        %init(MailApp);
        shouldOverrideStatusBarStyle = YES;
    }
    if (idIsEqual(@"com.apple.mobilesafari")) {
        %init(SafariApp);
        shouldOverrideStatusBarStyle = YES;
    }
    if (idIsEqual(@"com.apple.Passbook")) {
        %init(PassbookApp);
    }
    if (idIsEqual(@"com.apple.reminders")) {
        %init(RemindersApp);
    }
    if (idIsEqual(@"com.apple.Music")) {
        %init(MusicApp);
    }
    if (idIsEqual(@"com.apple.mobilenotes")) {
        //isEnabled = NO;
        %init(NotesApp);
    }
    if (idIsEqual(@"com.apple.AppStore")) {
        %init(AppstoreApp);
    }
    if (idIsEqual(@"com.apple.mobilecal")) {
        %init(CalendarApp);
        %init(CalendarFix);
    }
    if (idIsEqual(@"com.apple.MobileAddressBook")) {
        %init(ContactsApp);
    }
    if (idIsEqual(@"com.apple.MobileStore")) {
        %init(MobileStoreApp);
    }
    if (idIsEqual(@"com.apple.calculator")) {
        isEnabled = NO;
    }
    */
    
}

-(id)init {
    id hi = %orig;
    //Check if Application is on the blacklist
    BOOL isBlackListed = [[prefs objectForKey:[@"BlackListed-" stringByAppendingString:[self displayIdentifier]]] boolValue];
    
    BOOL shouldAutoReplaceColors = [[prefs objectForKey:[@"AutoColorReplacement-" stringByAppendingString:[self displayIdentifier]]] boolValue];
    
    
    if ((isTweakEnabled() && isBlackListed)) {
        isEnabled = NO; //On the blacklist, do not darken
    }
    if (isTweakEnabled() && !isBlackListed) {
        isEnabled = isTweakEnabled(); //Darken
    }
    
    if (idIsEqual(@"com.apple.springboard")) {
        shouldOverrideStatusBarStyle = NO;
        isEnabled = NO;
    }
    //If Tweak enabled:
    if (isEnabled) {
        
        %init(_ungrouped);
        [self checkRunningApp];
        darkenUIElements();
        
        if (shouldAutoReplaceColors && !idIsEqual(@"com.apple.Preferences")) {
            
            //%init(AutoReplaceColor);
        }
        
        if (UniformityInstalled()) {
            dlopen("/Library/MobileSubstrate/DynamicLibraries/Uniformity.dylib", RTLD_NOW);
        }
        
    }
    
    
    return hi;
}

%end
%end




%ctor {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	prefsChanged(NULL, NULL, NULL, NULL, NULL); // initialize prefs
	// register to receive changed notifications
	registerNotification(prefsChanged, PREFS_CHANGED_NOTIF);
    registerNotification(wallpaperChanged, WALLPAPER_CHANGED_NOTIF);
    registerNotification(quitAppsRequest, QUIT_APPS_NOTIF);
    %init(UIApp);
	[pool release];
}


