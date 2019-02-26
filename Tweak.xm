                                                                                                                                                                                                                                                /*
 _______  _______  _       _________ _______  _______  _______
 (  ____ \(  ____ \( \      \__   __/(  ____ )(  ____ \(  ____ \
 | (    \/| (    \/| (         ) (   | (    )|| (    \/| (    \/
 | (__    | |      | |         | |   | (____)|| (_____ | (__
 |  __)   | |      | |         | |   |  _____)(_____  )|  __)
 | (      | |      | |         | |   | (            ) || (
 | (____/\| (____/\| (____/\___) (___| )      /\____) || (____/\
 (_______/(_______/(_______/\_______/|/       \_______)(_______/
 
 NIGHT MODE FOR IOS - VERSION 1.4
 COPYRIGHT © 2014 GUILLERMO MORAN
 
*/

#import <objc/runtime.h>

#include <notify.h>

//Firmware Checks
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IsiPad UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

/*
d8888b. d8888b. d88888b d88888b .d8888.
88  `8D 88  `8D 88'     88'     88'  YP
88oodD' 88oobY' 88ooooo 88ooo   `8bo.
88~~~   88`8b   88~~~~~ 88~~~     `Y8b.
88      88 `88. 88.     88      db   8D
88      88   YD Y88888P YP      `8888Y'
*/

///

#define IS_BETA_BUILD NO

#define STATUS_BAR_STYLE UIStatusBarStyleLightContent

static BOOL shouldOverrideStatusBarStyle = YES;

static NSDictionary *prefs = nil;


#define registerNotification(c, n) CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (c), CFSTR(n), NULL, CFNotificationSuspensionBehaviorCoalesce);

#define PREFS_CHANGED_NOTIF "com.gmoran.eclipse.prefs-changed"
#define WALLPAPER_CHANGED_NOTIF "com.gmoran.eclipse.wallpaper-changed"
#define QUIT_APPS_NOTIF "com.gmoran.eclipse.quit-apps"

#define PREFS_FILE_PATH @"/var/mobile/Library/Preferences/com.gmoran.eclipse.plist"

@interface SBUIController : NSObject{} @end

@interface SBAppSliderController : NSObject {}
-(void)_quitAppAtIndex:(int)i;
@end


extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

static void quitAppsRequest(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    
    SBUIController *sharedUI = [%c(SBUIController) sharedInstance];
	SBAppSliderController *appSliderCont = [sharedUI _appSliderController];
    
    NSMutableArray *appList = MSHookIvar<NSMutableArray *>(appSliderCont, "_appList");
    
    for (NSString *identifier in appList) {
        if (![identifier isEqualToString:@"com.apple.springboard"]) {
            
            [appSliderCont _quitAppAtIndex:[appList indexOfObject:identifier]];
        }
    }
}

static void wallpaperChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    
    
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR(PREFS_CHANGED_NOTIF), NULL, NULL, TRUE);
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Eclipse"
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
                  @"selectedTint": @0,
                  @"selectedTheme": @0,
                  @"selectedNavColor": @0,
                  @"translucentNavbars": @0,
                  @"replaceSplashScreens": @NO,
                  @"disableInSB": @NO,
                  
                  //Colors
                  @"customColorsEnabled": @NO,
                  @"customNavBarHex":@"",
                  @"customThemeHex":@"",
                  @"customTintHex":@"",
                  @"customStatusbarHex":@"",
                  @"customTextHex":@"",
                  
                  //Experimental Options
                  @"darkenWallpapers": @NO,
                  @"whiteLabels": @NO};
        
		[prefs writeToFile:PREFS_FILE_PATH atomically:YES];
		prefs = [[NSDictionary alloc] initWithContentsOfFile:PREFS_FILE_PATH];
	}
}


static BOOL isTweakEnabled(void) {
	return (prefs) ? [prefs[@"enabled"] boolValue] : NO;
}

static BOOL disableInSB(void) {
	return (prefs) ? [prefs[@"disableInSB"] boolValue] : NO;
}

static BOOL replaceSplashScreens(void) {
	return (prefs) ? [prefs[@"replaceSplashScreens"] boolValue] : NO;
}

static BOOL darkenWallpapers(void) {
	return (prefs) ? [prefs[@"darkenWallpapers"] boolValue] : NO;
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

//Installed Checks

static BOOL isMessageCustomiserInstalled() {
     return [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/CustomMessagesColour.dylib"];
    
}

//Experimental Features
static BOOL darkenKeyboard(void) {
	return (prefs) ? [prefs[@"darkenKeyboard"] boolValue] : NO;
}

/*
static BOOL whiterLabels(void) {
	return (prefs) ? [prefs[@"whiteLabels"] boolValue] : NO;
}
 */


//static BOOL experimentalViewDarkeningEnabled(void) {
	//return (prefs) ? [prefs[@"experimentalViewDarkeningEnabled"] boolValue] : NO;
//}

static BOOL isEnabled = isTweakEnabled();



/*
  .o88b.  .d88b.  db       .d88b.  d8888b. .d8888.
 d8P  Y8 .8P  Y8. 88      .8P  Y8. 88  `8D 88'  YP
 8P      88    88 88      88    88 88oobY' `8bo.
 8b      88    88 88      88    88 88`8b     `Y8b.
 Y8b  d8 `8b  d8' 88booo. `8b  d8' 88 `88. db   8D
  `Y88P'  `Y88P'  Y88888P  `Y88P'  88   YD `8888Y'
 */

//Declare this here, not UIColor, for warning's purposes

@interface UIColor(Eclipse)

//+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
//+ (UIColor *)darkerColorForColor:(UIColor *)c;
+ (UIColor *)darkerColorForSelectionColor:(UIColor *)c;
+ (BOOL)color:(UIColor *)color1 isEqualToColor:(UIColor *)color2 withTolerance:(CGFloat)tolerance;

@end


static UIColor* colorWithHexString(NSString* hexStr, CGFloat alpha) {
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    hexStr = [hexStr uppercaseString];
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

static UIColor* darkerColorForColor(UIColor* c) {
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a]) {
        
        return [UIColor colorWithRed:MAX(r - 0.04, 0.0) green:MAX(g - 0.04, 0.0)
                                blue:MAX(b - 0.04, 0.0) alpha:a];
    }
    return c;
}


//Table Colors

#define MIDNIGHT_TABLE_COLOR [UIColor colorWithRed:30.0f/255.0f green:30.0f/255.0f blue:30.0f/255.0f alpha:1.0]

#define NIGHT_TABLE_COLOR [UIColor colorWithRed:40.0/255.0f green:40.0/255.0f blue:40.0/255.0f alpha:1.0f]

#define DARK_BLUE_TABLE_COLOR [UIColor colorWithRed:0/255.0f green:57/255.0f blue:94/255.0f alpha:1.0f]

#define CRIMSON_TABLE_COLOR [UIColor colorWithRed:78/255.0f green:1/255.0f blue:0/255.0f alpha:1.0f]

#define RASPBERRY_TABLE_COLOR [UIColor colorWithRed:73/255.0f green:1/255.0f blue:64/255.0f alpha:1.0f]

#define FUCHSIA_TABLE_COLOR [UIColor colorWithRed:123/255.0f green:1/255.0f blue:64/255.0f alpha:1.0f]

#define AMAZON_TABLE_COLOR [UIColor colorWithRed:0/255.0f green:64/255.0f blue:0/255.0f alpha:1.0f]

#define OLIVE_TABLE_COLOR [UIColor colorWithRed:91.0f/255.0f green:105.0f/255.0f blue:0.0f/255.0f alpha:1.0]

#define CERISE_TABLE_COLOR [UIColor colorWithRed:255.0f/255.0f green:113.0f/255.0f blue:159.0f/255.0f alpha:1.0]

#define MALCHITE_TABLE_COLOR [UIColor colorWithRed:34.0f/255.0f green:123.0f/255.0f blue:29.0f/255.0f alpha:1.0]



//View Colors

#define MIDNIGHT_VIEW_COLOR [UIColor colorWithRed:27.0f/255.0f green:27.0f/255.0f blue:27.0f/255.0f alpha:1.0]

#define NIGHT_VIEW_COLOR [UIColor colorWithRed:37.0/255.0f green:37.0/255.0f blue:37.0/255.0f alpha:1.0f]

#define DARK_BLUE_VIEW_COLOR [UIColor colorWithRed:0/255.0f green:47/255.0f blue:84/255.0f alpha:1.0f]

#define CRIMSON_VIEW_COLOR [UIColor colorWithRed:69/255.0f green:1/255.0f blue:0/255.0f alpha:1.0f]

#define RASPBERRY_VIEW_COLOR [UIColor colorWithRed:63/255.0f green:1/255.0f blue:64/255.0f alpha:1.0f]

#define FUCHSIA_VIEW_COLOR [UIColor colorWithRed:111/255.0f green:1/255.0f blue:64/255.0f alpha:1.0f]

#define AMAZON_VIEW_COLOR [UIColor colorWithRed:0/255.0f green:58/255.0f blue:0/255.0f alpha:1.0f]

#define OLIVE_VIEW_COLOR [UIColor colorWithRed:91.0f/255.0f green:99.0f/255.0f blue:0.0f/255.0f alpha:1.0]

#define CERISE_VIEW_COLOR [UIColor colorWithRed:255.0f/255.0f green:83.0f/255.0f blue:138.0f/255.0f alpha:1.0]

#define MALCHITE_VIEW_COLOR [UIColor colorWithRed:39.0f/255.0f green:138.0f/255.0f blue:33.0f/255.0f alpha:1.0]



//Nav Colors

#define MIDNIGHT_BAR_COLOR [UIColor colorWithRed:10.0f/255.0f green:10.0f/255.0f blue:10.0f/255.0f alpha:1.0]

#define NIGHT_BAR_COLOR [UIColor colorWithRed:30.0/255.0f green:30.0/255.0f blue:30.0/255.0f alpha:1.0f]

#define DARK_BLUE_BAR_COLOR [UIColor colorWithRed:0/255.0f green:38/255.0f blue:68/255.0f alpha:1.0f]

#define CRIMSON_BAR_COLOR [UIColor colorWithRed:52/255.0f green:1/255.0f blue:0/255.0f alpha:1.0f]

#define RASPBERRY_BAR_COLOR [UIColor colorWithRed:48/255.0f green:1/255.0f blue:64/255.0f alpha:1.0f]

#define FUCHSIA_BAR_COLOR [UIColor colorWithRed:89/255.0f green:1/255.0f blue:64/255.0f alpha:1.0f]

#define AMAZON_BAR_COLOR [UIColor colorWithRed:0/255.0f green:35/255.0f blue:0/255.0f alpha:1.0f]

#define OLIVE_BAR_COLOR [UIColor colorWithRed:83.0f/255.0f green:86.0f/255.0f blue:0.0f/255.0f alpha:1.0]

#define CERISE_BAR_COLOR [UIColor colorWithRed:160.0f/255.0f green:41.0f/255.0f blue:80.0f/255.0f alpha:1.0]

#define MALCHITE_BAR_COLOR [UIColor colorWithRed:26.0f/255.0f green:90.0f/255.0f blue:22.0f/255.0f alpha:1.0]

//Selections

static int selectedTheme(void) {
    int selectedTheme = [[prefs objectForKey:@"selectedTheme"] intValue];
    return selectedTheme;
}

static int selectedNavColor(void) {
    int selectedTheme = [[prefs objectForKey:@"selectedNavColor"] intValue];
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
    NSString* hex = [prefs objectForKey:@"customNavBarHex"];
    
    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;
}

static UIColor* hexThemeColor(void) {
    NSString* hex = [prefs objectForKey:@"customThemeHex"];
    
    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;
}

static UIColor* hexTintColor(void) {
    NSString* hex = [prefs objectForKey:@"customTintHex"];
    
    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;
}

static UIColor* hexStatusbarColor(void) {
    NSString* hex = [prefs objectForKey:@"customStatusbarHex"];
    
    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;
}

static UIColor* hexTextColor(void) {
    NSString* hex = [prefs objectForKey:@"customTextHex"];
    
    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;
}

/* -------------------------- */

static UIColor* textColor(void) {
    //int number = selectedTheme();
    /*
    if (number == 7 || number == 8) {
        return [UIColor colorWithRed:230.0/255.0f green:230.0/255.0f blue:230.0/255.0f alpha:1.0f];
    }
    else {
        if (whiterLabels()) {
            return [UIColor colorWithRed:230.0/255.0f green:230.0/255.0f blue:230.0/255.0f alpha:1.0f];
        }
        else {
            return [UIColor colorWithRed:180.0/255.0f green:180.0/255.0f blue:180.0/255.0f alpha:1.0f];
        }
    } */
    
    if (customColorEnabled()) {
        if (hexTextColor()) {
            return hexTextColor();
        }
        else {
            return [UIColor colorWithRed:230.0/255.0f green:230.0/255.0f blue:230.0/255.0f alpha:1.0f];
        }
    }
    return [UIColor colorWithRed:230.0/255.0f green:230.0/255.0f blue:230.0/255.0f alpha:1.0f];
}

static UIColor* selectedTableColor(void) {
    int number = selectedTheme();
    
    if (customColorEnabled()) {
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
        return DARK_BLUE_TABLE_COLOR;
    }
    else if (number == 2) {
        return CRIMSON_TABLE_COLOR;
    }
    else if (number == 3) {
        return RASPBERRY_TABLE_COLOR;
    }
    else if (number == 4) {
        return FUCHSIA_TABLE_COLOR;
    }
    else if (number == 5) {
        return AMAZON_TABLE_COLOR;
    }
    else if (number == 6) {
        return OLIVE_TABLE_COLOR;
    }
    else if (number == 7) {
        return CERISE_TABLE_COLOR;
    }
    else if (number == 8) {
        return MALCHITE_TABLE_COLOR;
    }
    else {
        return NIGHT_TABLE_COLOR;
    }
}

static UIColor* selectedViewColor(void) {
    int number = selectedTheme();
    
    if (customColorEnabled()) {
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
        return DARK_BLUE_VIEW_COLOR;
    }
    else if (number == 2) {
        return CRIMSON_VIEW_COLOR;
    }
    else if (number == 3) {
        return RASPBERRY_VIEW_COLOR;
    }
    else if (number == 4) {
        return FUCHSIA_VIEW_COLOR;
    }
    else if (number == 5) {
        return AMAZON_VIEW_COLOR;
    }
    else if (number == 6) {
        return OLIVE_VIEW_COLOR;
    }
    else if (number == 7) {
        return CERISE_VIEW_COLOR;
    }
    else if (number == 8) {
        return MALCHITE_VIEW_COLOR;
    }

    else {
        return NIGHT_VIEW_COLOR;
    }
}

static UIColor* selectedBarColor(void) {
    int number = selectedNavColor();
    
    if (customColorEnabled()) {
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
        return DARK_BLUE_BAR_COLOR;
    }
    else if (number == 2) {
        return CRIMSON_BAR_COLOR;
    }
    else if (number == 3) {
        return RASPBERRY_BAR_COLOR;
    }
    else if (number == 4) {
        return FUCHSIA_BAR_COLOR;
    }
    else if (number == 5) {
        return AMAZON_BAR_COLOR;
    }
    else if (number == 6) {
        return OLIVE_BAR_COLOR;
    }
    else if (number == 7) {
        return CERISE_BAR_COLOR;
    }
    else if (number == 8) {
        return MALCHITE_BAR_COLOR;
    }
    else {
        return NIGHT_BAR_COLOR;
    }
}

#define TABLE_COLOR selectedTableColor() //Used for TableView

#define NAV_COLOR selectedBarColor() //Used for NavBars, Toolbars, TabBars

#define VIEW_COLOR selectedViewColor() //Used for TableCells, UIViews

//Other Colors

//#define ALT_TEXT_COLOR [UIColor colorWithRed:180.0/255.0f green:180.0/255.0f blue:180.0/255.0f alpha:1.0f] //Replaces text colors

#define TEXT_COLOR textColor()

#define TABLE_SEPARATOR_COLOR [UIColor colorWithRed:60.0/255.0f green:60.0/255.0f blue:60.0/255.0f alpha:1.0f] //Table Separators


#define ACCENT_ORANGE_COLOR [UIColor colorWithRed:102/255.0f green:47/255.0f blue:35/255.0f alpha:1.0f] //UISwitch "ON" Color

#define ACCENT_BLUE_COLOR [UIColor colorWithRed:35/255.0f green:47/255.0f blue:102/255.0f alpha:1.0f] //UISwitch "OFF" Color

/*
 d888888b d888888b d8b   db d888888b
 `~~88~~'   `88'   888o  88 `~~88~~'
    88       88    88V8o 88    88
    88       88    88 V8o88    88
    88      .88.   88  V888    88
    YP    Y888888P VP   V8P    YP
*/

#define BABY_BLUE_COLOR [UIColor colorWithRed:0/255.0f green:163/255.0f blue:235/255.0f alpha:1.0f]

#define WHITE_COLOR [UIColor whiteColor]

#define PINK_COLOR [UIColor colorWithRed:255/255.0f green:74/255.0f blue:85/255.0f alpha:1.0f]

#define DARK_ORANGE_COLOR [UIColor colorWithRed:255/255.0f green:102/255.0f blue:0/255.0f alpha:1.0f]

#define GREEN_COLOR [UIColor colorWithRed:46/255.0f green:225/255.0f blue:79/255.0f alpha:1.0f]

#define PURPLE_COLOR [UIColor colorWithRed:179/255.0f green:1/255.0f blue:255/255.0f alpha:1.0f]

#define RED_COLOR [UIColor colorWithRed:188/255.0f green:39/255.0f blue:0/255.0f alpha:1.0f]

#define YELLOW_COLOR [UIColor colorWithRed:255/255.0f green:234/255.0f blue:0/255.0f alpha:1.0f]


static UIColor* selectedStatusbarTintColor(void) {
    
    int number = [[prefs objectForKey:@"statusbarTint"] intValue];
    
    if (customColorEnabled()) {
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
    /*
    if (selectedTheme() == 7 || selectedTheme() == 8) {
        return WHITE_COLOR;
    }
    */
    int number = [[prefs objectForKey:@"selectedTint"] intValue];
    
    if (customColorEnabled()) {
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
         
        /*
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        
        return color;
         */
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
    /*
    //Experimental
     
    [[UIApplication sharedApplication] keyWindow].tintColor = selectedTintColor();
    
    //[[UIView appearance] setTintColor:selectedTintColor()]; //Buggy?
    [[UITableView appearance] setTintColor:selectedTintColor()];
    [[UITableViewCell appearance] setTintColor:selectedTintColor()];
    [[UIButton appearance] setTintColor:selectedTintColor()];
     */
    
    //[[UIButton appearance] setTintColor:selectedTintColor()];
    
}

static BOOL isLightColor(UIColor* color) {
    
    if (SYSTEM_VERSION_GREATER_THAN(@"7.0.6")) {
        
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
        else if (white >= 0.5 && alpha >= 0.4) {
            return YES;
        }
        else {
            return NO;
        }
    }
     
    else {
        CGFloat white = 0;
        CGFloat alpha = 0;
        [color getWhite:&white alpha:&alpha];
        if (white >= 0.5 && alpha >= 0.4) {
            return YES;
        }
        else {
            return NO;
        }
    }
}

static BOOL isTextLightColor(UIColor* color) {
    CGFloat white = 0;
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    [color getWhite:&white alpha:nil];
    [color getRed:&red green:&green blue:&blue alpha:nil];
    
   return ((white <= 0.5) && (red <= 0.5) && (green <= 0.5)  && (blue <= 0.5) && (![color isEqual:selectedTintColor()]));
}

//Uniformity Support


static void darkenUIElements() {

    setTintColors();
    
    //[[UINavigationBar appearance] setBarTintColor:NAV_COLOR];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    //[[UISearchBar appearance] setBarTintColor:NAV_COLOR];
    //[[UISearchBar appearance] setBarStyle:UIBarStyleBlack];
    
    [[UIToolbar appearance] setBarTintColor:NAV_COLOR];
    //[[UIToolbar appearance] setBarStyle:UIBarStyleBlack];
    
    [[UITabBar appearance] setBarTintColor:NAV_COLOR];
    [[UITabBar appearance] setBarStyle:UIBarStyleBlack];
    
    [[UISwitch appearance] setTintColor:[selectedTintColor() colorWithAlphaComponent:0.6]];
    [[UISwitch appearance] setOnTintColor:[selectedTintColor() colorWithAlphaComponent:0.3]];
    //[[UISwitch appearance] setThumbTintColor:TEXT_COLOR];
    
    
}

/*
  .d8b.  db      d88888b d8888b. d888888b .d8888.
 d8' `8b 88      88'     88  `8D `~~88~~' 88'  YP
 88ooo88 88      88ooooo 88oobY'    88    `8bo.
 88~~~88 88      88~~~~~ 88`8b      88      `Y8b.
 88   88 88booo. 88.     88 `88.    88    db   8D
 YP   YP Y88888P Y88888P 88   YD    YP    `8888Y'
*/


//BiteSMS
%hook BSQRModalItem

-(id)_contentView {
    UIView* view = %orig;
    if (isTweakEnabled()) {
        for (UIView* ugh in view.subviews) {
            if ([ugh respondsToSelector:@selector(setTextColor:)]) {
                [ugh setTextColor:TEXT_COLOR];
            }
            for (UITextView* textView in ugh.subviews) {
                if ([textView respondsToSelector:@selector(setTextColor:)]) {
                    [textView setTextColor:TEXT_COLOR];
                }
            }
        }
    }
    return view;
}

%end

@interface _UITextFieldRoundedRectBackgroundViewNeue : UIImageView {
    
}
-(void)setFillColor:(id)arg1 ;
@end

%hook _UITextFieldRoundedRectBackgroundViewNeue

-(id)fillColor {
    if (isEnabled) {
        return [UIColor clearColor];
    }
    return %orig;
}

-(id)initWithFrame:(CGRect)arg1 {
    id ok = %orig;
    if (isEnabled) {
        [self setFillColor:[UIColor clearColor]];
    }
    return ok;
}
%end

@interface _UIBackdropViewSettings : NSObject {}

-(int)style;
-(void)setStyle:(int)arg1 ;

@end


%hook _UIBackdropViewSettings

-(id)colorTint {
    UIColor* color = %orig;
    
    id _backdrop = MSHookIvar<id>(self, "_backdrop");
    
    //if ([[_backdrop superview] isKindOfClass:[UIActionSheet class]] && [self style] != 2060) {
    
    
    /* ==== INFORMATION ====
     
     _UIBackdropViewSettingsAdaptiveLight = 2060 || iOS 7 Control Center
     
     _UIBackdropViewSettingsUltraLight = 2010 || App Store, iTunes, Action Sheets, and Share Sheets
     
     _UIBackdropViewSettingsLight = 0, 1000, 1003, 2020, 10090, 10100 || Dock, Spotlight, Folders
     
     */
    
    
    
    if (isEnabled && [self class] == %c(_UIBackdropViewSettingsUltraLight)) {
        
        color = [NAV_COLOR colorWithAlphaComponent:0.9];
        [_backdrop setAlpha:0.9];
    }
    
    
    if (isEnabled && darkenKeyboard() && [_backdrop isKindOfClass:objc_getClass("UIKBBackdropView")]) {
        color = [NAV_COLOR colorWithAlphaComponent:0.9];
        [_backdrop setAlpha:0.9];
    }
    
    
    
    return color;
}

%end


%hook _UIModalItemAlertContentView

-(void)layout {
    %orig;
    
    if (isTweakEnabled()) {
        UIView* _2ButtonsSeparators = MSHookIvar<UIView*>(self, "_2ButtonsSeparators");
        _2ButtonsSeparators.backgroundColor = selectedTintColor();
        
        UIView* _tableViewTopSeparator = MSHookIvar<UIView*>(self, "_tableViewTopSeparator");
        _tableViewTopSeparator.backgroundColor = selectedTintColor();
        
    
        
        
    }
    
}

%end

%hook _UIModalItemAlertBackgroundView

-(void)layoutSubviews {
    %orig;
    if (isTweakEnabled()) {
        id _effectView = MSHookIvar<id>(self, "_effectView");
        UIImageView* _fillingView = MSHookIvar<UIImageView*>(self, "_fillingView");
        
        [_effectView setHidden:YES];
        
        _fillingView.image = nil;
        _fillingView.backgroundColor = NAV_COLOR;
        
    }
    
}

%end

%hook _UIModalItemContentView

-(id)titleLabel {
    UILabel* label = %orig;
    
    if (isTweakEnabled()) {
        label.textColor = selectedTintColor();
    }
    return label;
}

-(id)subtitleLabel {
    UILabel* label = %orig;
    
    if (isTweakEnabled()) {
        label.textColor = TEXT_COLOR;
    }
    return label;
}

-(id)messageLabel {
    UILabel* label = %orig;
    
    if (isTweakEnabled()) {
        label.textColor = TEXT_COLOR;
    }
    return label;
}

%end

/*
 d8b   db  .d8b.  db    db      d888888b d888888b d88888b .88b  d88. .d8888.
 888o  88 d8' `8b 88    88        `88'   `~~88~~' 88'     88'YbdP`88 88'  YP
 88V8o 88 88ooo88 Y8    8P         88       88    88ooooo 88  88  88 `8bo.
 88 V8o88 88~~~88 `8b  d8'         88       88    88~~~~~ 88  88  88   `Y8b.
 88  V888 88   88  `8bd8'         .88.      88    88.     88  88  88 db   8D
 VP   V8P YP   YP    YP         Y888888P    YP    Y88888P YP  YP  YP `8888Y'
*/

%hook UINavigationBar

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        shouldOverrideStatusBarStyle = YES;
       
        [self setBarTintColor:NAV_COLOR];
        [self setBarStyle:UIBarStyleBlackTranslucent];
    }
}

-(void)drawRect:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        
        
        shouldOverrideStatusBarStyle = YES;
        
        [self setBarTintColor:NAV_COLOR];
        [self setBarStyle:UIBarStyleBlackTranslucent];
    }
}

-(void)setBounds:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        shouldOverrideStatusBarStyle = YES;
        
        [self setBarTintColor:NAV_COLOR];
        [self setBarStyle:UIBarStyleBlackTranslucent];
    }
}

-(void)setBarTintColor:(UIColor*)color {
    if (isEnabled) {
        color = NAV_COLOR;
        if (translucentNavbarEnabled()) {
            [self setAlpha:0.9];
        }
    }
    %orig(color);
}
 



%end

%hook UITabBar

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        self.backgroundColor = NAV_COLOR; //Fuck you, Whatsapp.
    }
}

-(void)setBarTintColor:(id)arg1 {
    if (isEnabled) {
        %orig(NAV_COLOR);
        return;
    }
    %orig;
}

%end



%hook UIToolbar



-(void)setBarStyle:(int)arg1 {
    if (isEnabled && !(IsiPad)) {
        [self setBarTintColor:NAV_COLOR];
        return;
    }
    %orig;
}


-(void)setBarTintColor:(id)arg1 {
    if (isEnabled && !(IsiPad)) {
        %orig(NAV_COLOR);
        return;
    }
    %orig;
}


-(void)setTranslucent:(BOOL)arg1 {
    if (isEnabled && !(IsiPad)) {
        %orig(NO);
        return;
    }
    return %orig;
}
-(BOOL)isTranslucent {
    if (isEnabled && !(IsiPad)) {
        return NO;
    }
    return %orig;
}
 

%end




/*
 db    db d888888b  .o88b.  .d88b.  db       .d88b.  d8888b.
 88    88   `88'   d8P  Y8 .8P  Y8. 88      .8P  Y8. 88  `8D
 88    88    88    8P      88    88 88      88    88 88oobY'
 88    88    88    8b      88    88 88      88    88 88`8b
 88b  d88   .88.   Y8b  d8 `8b  d8' 88booo. `8b  d8' 88 `88.
 ~Y8888P' Y888888P  `Y88P'  `Y88P'  Y88888P  `Y88P'  88   YD
*/

%hook UIColor

+(UIColor*)systemGreenColor {
    if (isEnabled && (selectedTintColor() != WHITE_COLOR)) {
        return selectedTintColor();
    }
    return %orig;
}

+(UIColor*)systemBlueColor {
    if (isEnabled && (selectedTintColor() != WHITE_COLOR)) {
        return selectedTintColor();
    }
    return %orig;
}


%new
+ (UIColor *)darkerColorForSelectionColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a]) {
        
        return [UIColor colorWithRed:MAX(r - 0.5, 0.0) green:MAX(g - 0.5, 0.0)
                                blue:MAX(b - 0.5, 0.0) alpha:a];
    }
    return c;
}

%new
//#define TOLERANCE 2
+ (BOOL)color:(UIColor *)color1 isEqualToColor:(UIColor *)color2 withTolerance:(CGFloat)tolerance {
    
    //tolerance = TOLERANCE;
    
    CGFloat r1, g1, b1, a1, r2, g2, b2, a2;
    [color1 getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [color2 getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    return
    fabs(r1 - r2) <= tolerance &&
    fabs(g1 - g2) <= tolerance &&
    fabs(b1 - b2) <= tolerance &&
    fabs(a1 - a2) <= tolerance;
}

%end

/*
 db   d8b   db  .d8b.  db      db
 88   I8I   88 d8' `8b 88      88
 88   I8I   88 88ooo88 88      88
 Y8   I8I   88 88~~~88 88      88
 `8b d8'8b d8' 88   88 88booo. 88booo.
  `8b8' `8d8'  YP   YP Y88888P Y88888P
 
 
 d8888b.  .d8b.  d8888b. d88888b d8888b.
 88  `8D d8' `8b 88  `8D 88'     88  `8D
 88oodD' 88ooo88 88oodD' 88ooooo 88oobY'
 88~~~   88~~~88 88~~~   88~~~~~ 88`8b
 88      88   88 88      88.     88 `88.
 88      YP   YP 88      Y88888P 88   YD
 */

@interface SBFStaticWallpaperView : NSObject {}
-(UIImage *)colorizeImage:(UIImage *)image withColor:(UIColor *)color;
@end

%hook SBFStaticWallpaperView

%new
-(UIImage *)colorizeImage:(UIImage *)image withColor:(UIColor *)color {
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -area.size.height);
    
    CGContextSaveGState(context);
    CGContextClipToMask(context, area, image.CGImage);
    
    [color set];
    CGContextFillRect(context, area);
    
    CGContextRestoreGState(context);
    
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    
    CGContextDrawImage(context, area, image.CGImage);
    
    UIImage *colorizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return colorizedImage;
}

-(id)initWithFrame:(CGRect)arg1 wallpaperImage:(id)arg2 {
    
    if (darkenWallpapers()) {
        
        return %orig(arg1, [self colorizeImage:arg2 withColor:[UIColor colorWithWhite:0 alpha:0.5]]);
    }
    else {
        return %orig;
    }
    
}

%end

/*
 d88888b db    db d88888b .88b  d88. d8888b. d888888b
 88'     `8b  d8' 88'     88'YbdP`88 88  `8D `~~88~~'
 88ooooo  `8bd8'  88ooooo 88  88  88 88oodD'    88
 88~~~~~  .dPYb.  88~~~~~ 88  88  88 88~~~      88
 88.     .8P  Y8. 88.     88  88  88 88         88
 Y88888P YP    YP Y88888P YP  YP  YP 88         YP
*/

%hook SBVolumeHUDView //Disable Tweak inside Volume HUD

-(id)init {
    id init = %orig;
    isEnabled = NO;
    return init;
}

%end

%hook SBBulletinViewController //Disable Tweak inside Notification Center

-(void)viewWillAppear:(BOOL)arg1 {
    isEnabled = NO;
    %orig;
}

-(void)viewWillDisappear:(BOOL)arg1 {
    isEnabled = isTweakEnabled();
    %orig;
}

%end

%hook SBScreenFlash //Change Screenshot Color

-(void)flashColor:(UIColor*)color {
    if (isEnabled) {
        %orig(ACCENT_BLUE_COLOR);
        return;
    }
    %orig;
}

%end

/*
  .o88b.  .d88b.  db      db           db    db d888888b d88888b db   d8b   db
 d8P  Y8 .8P  Y8. 88      88           88    88   `88'   88'     88   I8I   88
 8P      88    88 88      88           Y8    8P    88    88ooooo 88   I8I   88
 8b      88    88 88      88           `8b  d8'    88    88~~~~~ Y8   I8I   88
 Y8b  d8 `8b  d8' 88booo. 88booo.       `8bd8'    .88.   88.     `8b d8'8b d8'
  `Y88P'  `Y88P'  Y88888P Y88888P         YP    Y888888P Y88888P  `8b8' `8d8'
 */

/*
 
 Collection View in Videos is 0 alpha BGColor. Figure it out, asshole.
 
%hook UICollectionView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        
        if (isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]] && ![self isKindOfClass:%c(HBFPBackgroundView)]) {
            
            [self setBackgroundColor:VIEW_COLOR];
        }
    }
}

%end
 */

/*
 db    db d888888b db    db d888888b d88888b db   d8b   db
 88    88   `88'   88    88   `88'   88'     88   I8I   88
 88    88    88    Y8    8P    88    88ooooo 88   I8I   88
 88    88    88    `8b  d8'    88    88~~~~~ Y8   I8I   88
 88b  d88   .88.    `8bd8'    .88.   88.     `8b d8'8b d8'
 ~Y8888P' Y888888P    YP    Y888888P Y88888P  `8b8' `8d8'
*/

@interface UIView(Eclipse)
-(void)override;
@end

%hook UIView

//HBFPBackgroundView == FlagPaint

%new
-(void)override {
    
    if (isEnabled) {
        
        if (isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]] && ![self isKindOfClass:%c(HBFPBackgroundView)]) {
            
            [self setBackgroundColor:VIEW_COLOR];
        }
    }
}

-(id)backgroundColor {
    id color = %orig;
    if (isEnabled) {
        
        if (isLightColor(color) && ![color isEqual:[UIColor clearColor]] && ![self isKindOfClass:%c(HBFPBackgroundView)]) {
            
            return VIEW_COLOR;
        }
    }
    return %orig;
    
}

-(id)initWithCoder:(CGRect)arg1 {
    id ok = %orig;
    [self override];
    return ok;
}

-(id)init {
    id ok = %orig;
    [self override];
    return ok;
}

-(id)initWithFrame:(CGRect)arg1 {
    id ok = %orig;
    [self override];
    return ok;
}

-(id)initWithSize:(CGSize)arg1 {
    id ok = %orig;
    [self override];
    return ok;
}

-(void)setBackgroundColor:(UIColor*)color {
    if (isEnabled) {
        if (isLightColor(color)) {
            color = VIEW_COLOR;
        }
    }
    %orig(color);
}

-(void)layoutSubviews {
    
    %orig;
    
    if (isEnabled) {
        
        if (!isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]] && ![self isKindOfClass:%c(HBFPBackgroundView)]) {
            
            for(UIView *v in self.subviews){
                
                if([v isKindOfClass:[UILabel class]]){
                    
                    if (isTextLightColor(((UILabel *)v).textColor)) {
                        ((UILabel *)v).tag = 52961101;
                        ((UILabel *)v).backgroundColor = [UIColor clearColor];
                        [((UILabel *)v) setTextColor: TEXT_COLOR];
                    }
                }
            }
        }
    }
}

-(void)didAddSubview:(id)v {
    %orig;
    
    if (isEnabled) {
        
        if (!isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]] && ![self isKindOfClass:%c(HBFPBackgroundView)]) {
            
            if([v isKindOfClass:[UILabel class]]){
                
                if (isTextLightColor(((UILabel *)v).textColor)) {
                    ((UILabel *)v).tag = 52961101;
                    ((UILabel *)v).backgroundColor = [UIColor clearColor];
                    [((UILabel *)v) setTextColor: TEXT_COLOR];
                }
            }
        }
    }
}
%end
 
/*
 d888888b db    db d888888b db    db d888888b d88888b db   d8b   db
 `~~88~~' `8b  d8' `~~88~~' 88    88   `88'   88'     88   I8I   88
    88     `8bd8'     88    Y8    8P    88    88ooooo 88   I8I   88
    88     .dPYb.     88    `8b  d8'    88    88~~~~~ Y8   I8I   88
    88    .8P  Y8.    88     `8bd8'    .88.   88.     `8b d8'8b d8'
    YP    YP    YP    YP       YP    Y888888P Y88888P  `8b8' `8d8'
*/

%hook UITextView

-(id)init {
    id  wow = %orig;
    
    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {
            
            if (![self.superview isKindOfClass:[UIImageView class]]) {
                
                id balloon = objc_getClass("CKBalloonTextView");
                
                if ([self class] == balloon) {
                    return wow;
                }
                else {
                    [self setBackgroundColor:[UIColor clearColor]];
                    [self setTextColor:TEXT_COLOR];
                }
            }
        }
    }
    return wow;
}

-(id)initWithFrame:(CGRect)arg1 {
    id  wow = %orig;
    
    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {
            
            if (![self.superview isKindOfClass:[UIImageView class]]) {
                
                id balloon = objc_getClass("CKBalloonTextView");
                
                if ([self class] == balloon) {
                    return wow;
                }
                else {
                    [self setBackgroundColor:[UIColor clearColor]];
                    [self setTextColor:TEXT_COLOR];
                }
            }
        }
    }
    return wow;
}

-(id)initWithCoder:(id)arg1 {
    id  wow = %orig;
    
    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {
            
            if (![self.superview isKindOfClass:[UIImageView class]]) {
                
                id balloon = objc_getClass("CKBalloonTextView");
                
                if ([self class] == balloon) {
                    return wow;
                }
                else {
                    [self setBackgroundColor:[UIColor clearColor]];
                    [self setTextColor:TEXT_COLOR];
                }
            }
        }
    }
    return wow;
}

-(id)initWithFrame:(CGRect)arg1 font:(id)arg2 {
    
    id  wow = %orig;
    
    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {
            
            if (![self.superview isKindOfClass:[UIImageView class]]) {
                
                id balloon = objc_getClass("CKBalloonTextView");
                
                if ([self class] == balloon) {
                    return wow;
                }
                else {
                    [self setBackgroundColor:[UIColor clearColor]];
                    [self setTextColor:TEXT_COLOR];
                }
            }
        }
    }
    return wow;
}

-(id)initWithFrame:(CGRect)arg1 textContainer:(id)arg2 {
    id  wow = %orig;
    
    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {
            
            if (![self.superview isKindOfClass:[UIImageView class]]) {
                
                id balloon = objc_getClass("CKBalloonTextView");
                
                if ([self class] == balloon) {
                    return wow;
                }
                else {
                    [self setBackgroundColor:[UIColor clearColor]];
                    [self setTextColor:TEXT_COLOR];
                }
            }
        }
    }
    return wow;
}





-(id)backgroundColor {
    UIColor* color = %orig;
    if (isEnabled) {
        if (!isLightColor(color)) {
            
            color = [UIColor clearColor];
        }
    }
    return color;
}

-(id)textColor {
    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {
            
            if (![self.superview isKindOfClass:[UIImageView class]]) {
                
                return TEXT_COLOR;
                
            }
        }
    }
    return %orig;
}
-(void)setFrame:(CGRect)arg1 {
    %orig;
    
    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {
            
            if (![self.superview isKindOfClass:[UIImageView class]]) {
                
                id balloon = objc_getClass("CKBalloonTextView");
                
                if ([self class] == balloon) {
                    return;
                }
                else {
                    [self setBackgroundColor:[UIColor clearColor]];
                    [self setTextColor:TEXT_COLOR];
                }
            }
        }
    }
}

//These methods cause hanging

/*
-(void)setFrame:(CGRect)arg1 {
}
 */
/*
-(void)setBounds:(CGRect)arg1 {
}
*/

/*
-(void)layoutSubviews {
}
 */

%end

/*
 d888888b db    db d888888b d88888b d888888b d88888b db      d8888b.
 `~~88~~' `8b  d8' `~~88~~' 88'       `88'   88'     88      88  `8D
    88     `8bd8'     88    88ooo      88    88ooooo 88      88   88
    88     .dPYb.     88    88~~~      88    88~~~~~ 88      88   88
    88    .8P  Y8.    88    88        .88.   88.     88booo. 88  .8D
    YP    YP    YP    YP    YP      Y888888P Y88888P Y88888P Y8888D'
*/

%hook UISearchBar

-(void)drawRect:(CGRect)rect {
    %orig;
    if (isEnabled) {
        [self setBarTintColor:NAV_COLOR];
    }
}

%end

%hook UITextField

%new
-(void)override {
    if (isEnabled) {
        
        //[self setKeyboardAppearance:UIKeyboardAppearanceDark];
        if (!isLightColor(self.backgroundColor)) {
            
            //[self setBackgroundColor:[VIEW_COLOR colorWithAlphaComponent:0.4]];
            
        }
        
        [self setTextColor:TEXT_COLOR];
        self.textColor = TEXT_COLOR;
    }
}
/*
 - (void)drawPlaceholderInRect:(CGRect)rect {
 [DARKER_ORANGE_COLOR setFill];
 [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:12]];
 }
 */

//-(void)setKeyboardAppearance:(int)arg1 ;

-(id)initWithFrame:(CGRect)arg1 {
    id christmasPresents = %orig;
    [self override];
    return christmasPresents;
}


 -(id)initWithCoder:(id)arg1 {
     id christmasPresents = %orig;
     [self override];
     return christmasPresents;
 }

-(id)init {
    id christmasPresents = %orig;
    [self override];
    return christmasPresents;
}
/*
 -(void)setKeyboardAppearance:(int)arg1 {
 if (isEnabled) {
 %orig(UIKeyboardAppearanceDark);
 return;
 }
 %orig;
 }
 */

-(void)setTextColor:(id)arg1 {
    if (isEnabled) {
        if (![self isKindOfClass:%c(SBSearchField)]) {
            
            if (!isLightColor(self.backgroundColor)) {
                //[self setBackgroundColor:[VIEW_COLOR colorWithAlphaComponent:0.4]];
            }
            
            %orig(TEXT_COLOR);
            return;
        }
    }
    %orig;
}
 

-(id)textColor {
    UIColor* color = %orig;
    if (isEnabled) {
        
        if (![self isKindOfClass:%c(SBSearchField)]) {
            
            if (!isLightColor(self.backgroundColor)) {
                
                //[self setBackgroundColor:[VIEW_COLOR colorWithAlphaComponent:0.4]];
            }
            color = TEXT_COLOR;
            
        }
    }
    return color;
}
 

-(void)drawRect:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        if (![self isKindOfClass:%c(SBSearchField)]) {
            
            if (!isLightColor(self.backgroundColor)) {
                [self setBackgroundColor:[VIEW_COLOR colorWithAlphaComponent:0.4]];
            }
            
                
            [self setTextColor:TEXT_COLOR];
            self.textColor = TEXT_COLOR;
            
        }
    }
}


%end

/*
 db    db d888888b db       .d8b.  d8888b. d88888b db
 88    88   `88'   88      d8' `8b 88  `8D 88'     88
 88    88    88    88      88ooo88 88oooY' 88ooooo 88
 88    88    88    88      88~~~88 88~~~b. 88~~~~~ 88
 88b  d88   .88.   88booo. 88   88 88   8D 88.     88booo.
 ~Y8888P' Y888888P Y88888P YP   YP Y8888P' Y88888P Y88888P
*/



@interface UILabel(Eclipse)
-(void)override;
@end

%hook UILabel

-(void)drawRect:(CGRect)arg1 {
    %orig;
    
    if (isEnabled) {
        if (!isLightColor(self.superview.backgroundColor)) {
            
            if (isTextLightColor(self.textColor)) {
                //self.tag = 52961101;
                self.backgroundColor = [UIColor clearColor];
                self.textColor = TEXT_COLOR;
            }
        }
    }
}

-(void)setFrame:(CGRect)arg1 {
    %orig;
    
    if (isEnabled) {
        if (!isLightColor(self.superview.backgroundColor)) {
            
            if (isTextLightColor(self.textColor)) {
                //self.tag = 52961101;
                self.backgroundColor = [UIColor clearColor];
                self.textColor = TEXT_COLOR;
            }
        }
    }
}

-(void)didMoveToSuperview {
    %orig;
    
    if (isEnabled) {
        if (!isLightColor(self.superview.backgroundColor)) {
            
            if (isTextLightColor(self.textColor)) {
                //self.tag = 52961101;
                self.backgroundColor = [UIColor clearColor];
                [self setTextColor: TEXT_COLOR];
            }
        }
    }
}



-(void)setTextColor:(id)color {
    if (isEnabled) {
        if (self.tag == 52961101) {
            color = TEXT_COLOR;
            %orig(color);
            return;
        }
        if (!isLightColor(self.superview.backgroundColor)) {
            
            if (isTextLightColor(color)) {
                //self.tag = 52961101;
                self.backgroundColor = [UIColor clearColor];
                color = TEXT_COLOR;
            }
        }
    }
    
    %orig(color);
}

%end
 
/*
%hook UILabel

-(void)drawRect:(CGRect)arg1 {
    %orig;
    
    if (isEnabled) {
        if ([UIColor color:self.superview.backgroundColor isEqualToColor:VIEW_COLOR withTolerance:1.0] || [UIColor color:self.superview.backgroundColor isEqualToColor:VIEW_COLOR withTolerance:1.0]) {
            
            if (isTextLightColor(self.textColor)) {
                //self.tag = 52961101;
                self.backgroundColor = [UIColor clearColor];
                self.textColor = TEXT_COLOR;
            }
        }
    }
}

-(void)setFrame:(CGRect)arg1 {
    %orig;
    
    if (isEnabled) {
        if ([UIColor color:self.superview.backgroundColor isEqualToColor:VIEW_COLOR withTolerance:1.0] || [UIColor color:self.superview.backgroundColor isEqualToColor:VIEW_COLOR withTolerance:1.0]) {
            
            if (isTextLightColor(self.textColor)) {
                //self.tag = 52961101;
                self.backgroundColor = [UIColor clearColor];
                self.textColor = TEXT_COLOR;
            }
        }
    }
}

-(void)didMoveToSuperview {
    %orig;
    
    if (isEnabled) {
        if ([UIColor color:self.superview.backgroundColor isEqualToColor:VIEW_COLOR withTolerance:1.0] || [UIColor color:self.superview.backgroundColor isEqualToColor:VIEW_COLOR withTolerance:1.0]) {
            
            if (isTextLightColor(self.textColor)) {
                //self.tag = 52961101;
                self.backgroundColor = [UIColor clearColor];
                [self setTextColor: TEXT_COLOR];
            }
        }
    }
}



-(void)setTextColor:(id)color {
    if (isEnabled) {
        if (self.tag == 52961101) {
            color = TEXT_COLOR;
            %orig(color);
            return;
        }
        if ([UIColor color:self.superview.backgroundColor isEqualToColor:VIEW_COLOR withTolerance:1.0] || [UIColor color:self.superview.backgroundColor isEqualToColor:VIEW_COLOR withTolerance:1.0]) {
            
            if (isTextLightColor(color)) {
                //self.tag = 52961101;
                self.backgroundColor = [UIColor clearColor];
                color = TEXT_COLOR;
            }
        }
    }
    
    %orig(color);
}

%end
 */

/*
 d888888b  .d8b.  d8888b. db      d88888b
 `~~88~~' d8' `8b 88  `8D 88      88'
    88    88ooo88 88oooY' 88      88ooooo
    88    88~~~88 88~~~b. 88      88~~~~~
    88    88   88 88   8D 88booo. 88.
    YP    YP   YP Y8888P' Y88888P Y88888P
*/

#define TABLE_BG_COLOR [UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:1.0f] //Default Table BG Color

static CGColorSpaceRef tableBGColorSpace = CGColorGetColorSpace([TABLE_BG_COLOR CGColor]);

#define CELL_WHITE [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f] //Fuck You Apple. (Some apps don't use whiteColor)

static CGColorSpaceRef cellWhiteColorSpace = CGColorGetColorSpace([CELL_WHITE CGColor]);

#define IPAD_CELL_WHITE [UIColor colorWithRed:0.145098 green:0.145098 blue:0.145098 alpha:1.0f]

static CGColorSpaceRef iPadCellWhiteColorSpace = CGColorGetColorSpace([IPAD_CELL_WHITE CGColor]);


static CGColorSpaceRef whiteColorSpace = CGColorGetColorSpace([[UIColor whiteColor] CGColor]);


%hook UITableView


%new
-(void)override {
    
    if (isEnabled) {
        
        CGColorSpaceRef origColorSpace = CGColorGetColorSpace([self.backgroundColor CGColor]);
        
        if (origColorSpace == tableBGColorSpace || origColorSpace == whiteColorSpace || origColorSpace == cellWhiteColorSpace) {
            
            
            self.sectionIndexBackgroundColor = [UIColor clearColor];
            
            
            [self setSeparatorColor:TABLE_SEPARATOR_COLOR];
            self.separatorColor = TABLE_SEPARATOR_COLOR;
            
            [self setSectionIndexTrackingBackgroundColor:[UIColor clearColor]];
            self.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
            
            [self setSectionIndexColor:selectedTintColor()];
            self.sectionIndexColor = selectedTintColor();
           
        
            [self setBackgroundColor: TABLE_COLOR];
            self.backgroundColor = TABLE_COLOR;
            
        }
    }
}


-(id)initWithFrame:(CGRect)arg1 {
    id itsTenPM = %orig;
    [self override];
    return itsTenPM;
}


-(id)initWithCoder:(id)arg1 {
    id itsTenPM = %orig;
    [self override];
    return itsTenPM;
}

 

-(id)init {
    id itsTenPM = %orig;
    [self override];
    return itsTenPM;
}
 


-(void)setBackgroundColor:(id)arg1 {
    
    if (isEnabled) {
        CGColorSpaceRef argColorSpace = CGColorGetColorSpace([arg1 CGColor]);
        
        if (argColorSpace == tableBGColorSpace || [arg1 isEqual:[UIColor whiteColor]] ) {
            
            
            [self setSeparatorColor:TABLE_SEPARATOR_COLOR];
            [self setSectionIndexTrackingBackgroundColor:[UIColor clearColor]];
            
            [self setSectionIndexColor:selectedTintColor()];
            
            self.sectionIndexBackgroundColor = [UIColor clearColor];
            //[self setTableHeaderBackgroundColor:TABLE_COLOR];
            
            
            %orig(TABLE_COLOR);
            return;
        }
        
        %orig;
        return;
    }
    %orig;
}

-(id)backgroundColor {
    
    id bgc = %orig;
    
    if (isEnabled) {
        
        CGColorSpaceRef origColorSpace = CGColorGetColorSpace([bgc CGColor]);
        
        if (origColorSpace == tableBGColorSpace || origColorSpace == whiteColorSpace || origColorSpace == cellWhiteColorSpace) {
            
            
            self.sectionIndexBackgroundColor = [UIColor clearColor];
            
            [self setSeparatorColor:TABLE_SEPARATOR_COLOR];
            self.separatorColor = TABLE_SEPARATOR_COLOR;
            
            [self setSectionIndexTrackingBackgroundColor:[UIColor clearColor]];
            self.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
            
            
            [self setSectionIndexColor:selectedTintColor()];
            self.sectionIndexColor = selectedTintColor();
             
            
            //[self sectionBorderColor];
            bgc = TABLE_COLOR;
        }
        return bgc;
    }
    return bgc;
}


/*
-(void)layoutSubviews {
    %orig;
    
    if (isEnabled) {
        self.sectionIndexBackgroundColor = [UIColor clearColor];
        
        
        [self setSeparatorColor:TABLE_SEPARATOR_COLOR];
        //self.separatorColor = TABLE_SEPARATOR_COLOR;
        
        [self setSectionIndexTrackingBackgroundColor:[UIColor clearColor]];
        //self.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
        
        [self setSectionIndexColor:selectedTintColor()];
        //self.sectionIndexColor = selectedTintColor();
        
        //This actually came in handy... Wow.
        if ([UIColor color:self.backgroundColor isEqualToColor:[UIColor whiteColor] withTolerance:2] && ![UIColor color:self.backgroundColor isEqualToColor:[UIColor clearColor] withTolerance:0.2]) {
            [self setBackgroundColor:TABLE_COLOR];
        }
        
    }
    
    
}
 */

-(id)sectionBorderColor {
    if (isEnabled) {
        return [UIColor clearColor];
    }
    return %orig;
}

-(id)separatorColor {
    if (isEnabled) {
        return TABLE_SEPARATOR_COLOR;
    }
    return %orig;
}

-(id)sectionIndexTrackingBackgroundColor {
    if (isEnabled) {
        return [UIColor clearColor];
    }
    return %orig;
}
-(void)setSectionIndexTrackingBackgroundColor:(id)arg1 {
    if (isEnabled) {
        %orig ([UIColor clearColor]);
        return;
    }
    %orig;
}

-(void)setSectionIndexColor:(id)arg1 {
    if (isEnabled) {
        self.sectionIndexBackgroundColor = [UIColor clearColor];
        
        arg1 = selectedTintColor();
    }
    %orig(arg1);
}

-(void)setTableHeaderBackgroundColor:(id)arg1 {
    if (isEnabled) {
        self.sectionIndexBackgroundColor = [UIColor clearColor];
        arg1 = TABLE_COLOR;
    }
    %orig(arg1);
}
-(id)tableHeaderBackgroundColor {
    if (isEnabled) {
        return TABLE_COLOR;
    }
    return %orig;
}
 


%end

//Table Index

%hook UITableViewIndex

-(id)initWithFrame:(CGRect)arg1 {
    id k = %orig;
    
    if (isEnabled) {
        [self setIndexTrackingBackgroundColor:[UIColor clearColor]];
        [self setIndexBackgroundColor:[UIColor clearColor]];
    }
    
    return k;
}

%end

/*
 db   db d88888b db    db d8888b.  d888b
 88   88 88'     88    88 88  `8D 88' Y8b
 88ooo88 88ooo   Y8    8P 88oooY' 88
 88~~~88 88~~~   `8b  d8' 88~~~b. 88  ooo
 88   88 88       `8bd8'  88   8D 88. ~8~
 YP   YP YP         YP    Y8888P'  Y888P
*/

%hook _UITableViewHeaderFooterViewBackground

-(id)initWithFrame:(CGRect)arg1 {
    id bgView = %orig;
    if (isEnabled && ([[self backgroundColor] isEqual:[UIColor clearColor]])) {
        [self setBackgroundColor:VIEW_COLOR];
    }
   
    return bgView;
}

%end



/*
  .o88b. d88888b db      db      .d8888.
 d8P  Y8 88'     88      88      88'  YP
 8P      88ooooo 88      88      `8bo.
 8b      88~~~~~ 88      88        `Y8b.
 Y8b  d8 88.     88booo. 88booo. db   8D
  `Y88P' Y88888P Y88888P Y88888P `8888Y'
*/


%hook UIGroupTableViewCellBackground

- (id)_fillColor {
    if (isEnabled) {
        return VIEW_COLOR;
    }
    return %orig;
}

- (id)_separatorColor {
    if (isEnabled) {
        return TABLE_SEPARATOR_COLOR;
    }
    return %orig;
}

%end

@interface UITableViewCell(Eclipse)
-(void)override;
-(BOOL)isLightColor:(id)clr;
-(void)setSelectionTintColor:(id)arg1;
@end

%hook UITableViewCell

/*
%new
-(BOOL)isLightColor:(UIColor*)clr {
    
    CGColorSpaceRef argColorSpace = CGColorGetColorSpace([clr CGColor]);
    
    CGFloat white = 0;
    CGFloat alpha = 0;
    [clr getWhite:&white alpha:&alpha];
    
    if (white <= 0.3 && alpha > 0)  {
        
        return YES;
    }
    else if (argColorSpace == cellWhiteColorSpace) {
        
        return YES;
    }
    else if (argColorSpace == iPadCellWhiteColorSpace) {
        
        return YES;
    }
    else {
        return NO;
    }
    
}
*/

%new
-(void)override {
    
    if (isEnabled) {
        if (!isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]]) {
            [self setBackgroundColor:VIEW_COLOR];
            
        }
    }
}

-(id)_detailTextLabel {
    UILabel* label = %orig;
    
    if (isEnabled) {
        if (shouldColorDetailText()) {
            [label setTextColor:selectedTintColor()];
        }
        else {
            [label setTextColor:TEXT_COLOR];
        }
    }
    return label;
}

-(id)init {
    id iRanOutOfNamesForThisID = %orig;
    [self override];
    return iRanOutOfNamesForThisID;
}


-(void)setBackgroundColor:(id)arg1 {
    
    if (isEnabled) {
        
        if (!isLightColor(arg1) && ![arg1 isEqual:[UIColor clearColor]]) {
            //[self.textLabel setTextColor:TEXT_COLOR];
            arg1 = VIEW_COLOR;
        }
    }
    %orig(arg1);
}


-(id)backgroundColor {
    
    id kitties = %orig;
    
    if (isEnabled) {
        
        if (!isLightColor(kitties) && ![kitties isEqual:[UIColor clearColor]]) {
            //[((UITableViewCell*)self).textLabel setTextColor:TEXT_COLOR];
            kitties = VIEW_COLOR;
        }
    }
    return kitties;
}
 

/*
-(void)setSelectionTintColor:(id)arg1 {
    if (isEnabled) {
        arg1 = ACCENT_BLUE_COLOR;
    }
    %orig(arg1);
}
 */
-(id)selectionTintColor {
    if (isEnabled) {
        return [UIColor darkerColorForSelectionColor:selectedTintColor()];
    }
    return %orig;
}

%end

//Cell Edit Control

%hook UITableViewCellEditControl

-(id)backgroundColor {
    if (isEnabled) {
        return VIEW_COLOR;
    }
    return %orig;
}

%end


/*
 db   dD d88888b db    db d8888b.  .d88b.   .d8b.  d8888b. d8888b.
 88 ,8P' 88'     `8b  d8' 88  `8D .8P  Y8. d8' `8b 88  `8D 88  `8D
 88,8P   88ooooo  `8bd8'  88oooY' 88    88 88ooo88 88oobY' 88   88
 88`8b   88~~~~~    88    88~~~b. 88    88 88~~~88 88`8b   88   88
 88 `88. 88.        88    88   8D `8b  d8' 88   88 88 `88. 88  .8D
 YP   YD Y88888P    YP    Y8888P'  `Y88P'  YP   YP 88   YD Y8888D'
*/


%hook UITextInputTraits


-(int)keyboardAppearance {
    if (isEnabled && darkenKeyboard()) {
        return 0;
    }
    return %orig;
}

%end

%hook UIKBRenderConfig

-(BOOL)lightKeyboard {
    if (isEnabled && darkenKeyboard()) {
        return NO;
    }
    return %orig;
}


%end
 

%hook UIKeyboard

-(id)initWithFrame:(CGRect)arg1 {
    id meow = %orig;
    if (isEnabled && darkenKeyboard()) {
        [self setBackgroundColor:TABLE_COLOR];
    }
    return meow;
}

%end

 

/*
%hook UIKBRenderConfig

-(BOOL)lightKeyboard {
    if (isEnabled && darkenKeyboard()) {
        return NO;
    }
    return %orig;
}

-(float)blurRadius {
    return 100;
}

-(float)keycapOpacity {
    return 0;
}
-(float)keyborderOpacity {
    return 0;
}

-(float)blurSaturation {
    return 100;
}

%end
*/
/*
 .d8888. d888888b  .d8b.  d888888b db    db .d8888. d8888b.  .d8b.  d8888b.
 88'  YP `~~88~~' d8' `8b `~~88~~' 88    88 88'  YP 88  `8D d8' `8b 88  `8D
 `8bo.      88    88ooo88    88    88    88 `8bo.   88oooY' 88ooo88 88oobY'
 `  Y8b.    88    88~~~88    88    88    88   `Y8b. 88~~~b. 88~~~88 88`8b
 db   8D    88    88   88    88    88b  d88 db   8D 88   8D 88   88 88 `88.
 `8888Y'    YP    YP   YP    YP    ~Y8888P' `8888Y' Y8888P' YP   YP 88   YD
 */

%hook UIStatusBar

-(id)foregroundColor {
    UIColor* color = %orig;
    if (isEnabled && shouldOverrideStatusBarStyle) {
        color = selectedStatusbarTintColor();
    }
    return color;
}
%end



/*
 d8888b. db   db  .d88b.  d8b   db d88888b
 88  `8D 88   88 .8P  Y8. 888o  88 88'
 88oodD' 88ooo88 88    88 88V8o 88 88ooooo
 88~~~   88~~~88 88    88 88 V8o88 88~~~~~
 88      88   88 `8b  d8' 88  V888 88.
 88      YP   YP  `Y88P'  VP   V8P Y88888P
*/

@interface PhoneViewController : UIViewController{}
@end

%group PhoneApp


%hook TSSuperBottomBarButton

-(id)init {
    id meh = %orig;
    if (isEnabled) {
        [self setBackgroundColor:selectedTintColor()];
    }
    return meh;
}

%end


%hook PhoneViewController

- (void)viewDidLoad {
    %orig;
    if (isEnabled) {
        [self.view setBackgroundColor:selectedTintColor()];
    }
}

%end


%hook PHHandsetDialerView

- (id)dialerColor {
    if (isEnabled) {
        return VIEW_COLOR;
    }
    return %orig;
}

%end



%hook TPNumberPadButton

+(id)imageForCharacter:(unsigned)arg1 highlighted:(BOOL)arg2 whiteVersion:(BOOL)arg3 {
    
    if (isEnabled) {
        return %orig(arg1, arg2, YES);
    }
    return %orig;
}

%end
%end

//Disable in Emergency Dial

 %hook PHEmergencyHandsetDialerView
 
 
 - (id)initWithFrame:(struct CGRect)arg1 {
 isEnabled = NO;
 id meow = %orig;
 isEnabled = isTweakEnabled();
 return meow;
 
 }
 
 %end



/*
  .d8b.  d8888b. d8888b. d8888b. d88888b .d8888. .d8888. d8888b. db   dD
 d8' `8b 88  `8D 88  `8D 88  `8D 88'     88'  YP 88'  YP 88  `8D 88 ,8P'
 88ooo88 88   88 88   88 88oobY' 88ooooo `8bo.   `8bo.   88oooY' 88,8P
 88~~~88 88   88 88   88 88`8b   88~~~~~   `Y8b.   `Y8b. 88~~~b. 88`8b
 88   88 88  .8D 88  .8D 88 `88. 88.     db   8D db   8D 88   8D 88 `88.
 YP   YP Y8888D' Y8888D' 88   YD Y88888P `8888Y' `8888Y' Y8888P' YP   YD
*/

%group ContactsApp

%hook UITextView

-(void)drawRect:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {
            
            if (![self.superview isKindOfClass:[UIImageView class]]) {
                
                id balloon = objc_getClass("CKBalloonTextView");
                
                if ([self class] == balloon) {
                    return;
                }
                else {
                    [self setBackgroundColor:[UIColor clearColor]];
                    [self setTextColor:TEXT_COLOR];
                }
            }
        }
    }
}

%end
%end

//DO NOT GROUP THIS.


//iOS 7.1+
%hook ABStyleProvider

- (id)membersBackgroundColor {
    if (isEnabled) {
        return VIEW_COLOR;
    }
    return %orig;
}

- (id)memberNameTextColor {
    return TEXT_COLOR;
}

- (id)membersHeaderContentViewBackgroundColor {
    if (isEnabled) {
        return NAV_COLOR;
    }
    return %orig;
}


%end

%hook ABContactView

-(id)backgroundColor {
    if (isEnabled) {
        return TABLE_COLOR;
    }
    return %orig;
}

%end

/*
 .d8888. .88b  d88. .d8888.
 88'  YP 88'YbdP`88 88'  YP
 `8bo.   88  88  88 `8bo.
   `Y8b. 88  88  88   `Y8b.
 db   8D 88  88  88 db   8D
 `8888Y' YP  YP  YP `8888Y'
*/

//Do not group (text bubbles in compose views system-wide)

%hook CKConversationListCell

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        id _dateLabel = MSHookIvar<id>(self, "_dateLabel");
        id _summaryLabel = MSHookIvar<id>(self, "_summaryLabel");
        
        if (shouldColorDetailText()) {
            [_dateLabel setTextColor:selectedTintColor()];
            [_summaryLabel setTextColor:selectedTintColor()];
        }
        else {
            [_dateLabel setTextColor:TEXT_COLOR];
            [_summaryLabel setTextColor:TEXT_COLOR];
        }
    }
    
}

%end

%hook CKTextBalloonView

-(void)setCanUseOpaqueMask:(BOOL)canit {
    if (isEnabled) {
        %orig(NO);
        return;
    }
    %orig;
}


%end

%hook CKImageBalloonView

-(void)setCanUseOpaqueMask:(BOOL)canit {
    if (isEnabled) {
        %orig(NO);
        return;
    }
    %orig;
}

%end
 

%hook CKColoredBalloonView

-(BOOL)wantsGradient {
    if (isEnabled) {
        if (isMessageCustomiserInstalled()) {
            dlopen("/Library/MobileSubstrate/DynamicLibraries/CustomMessagesColour.dylib", RTLD_NOW);
        }
        else {
            return NO;
        }
    }
    return %orig;
}

-(void)setCanUseOpaqueMask:(BOOL)arg1 {
    if (isEnabled) {
        %orig(NO);
        return;
    }
    %orig;
}

%end
/*
@interface _UITextFieldRoundedRectBackgroundViewNeue : NSObject
-(void)setFillColor:(UIColor*)color ;
@end
 */

%hook CKMessageEntryView

-(id)coverView {
    _UITextFieldRoundedRectBackgroundViewNeue* coverView = %orig;
    if (isEnabled) {
        //_UITextFieldRoundedRectBackgroundViewNeue* coverView = MSHookIvar<_UITextFieldRoundedRectBackgroundViewNeue*>(self, "_coverView");
        [coverView setFillColor:VIEW_COLOR];
    }
    return coverView;
}

-(void)layoutSubviews {
    %orig;
    _UITextFieldRoundedRectBackgroundViewNeue* _coverView = MSHookIvar<_UITextFieldRoundedRectBackgroundViewNeue*>(self, "_coverView");
    
    [_coverView setFillColor:VIEW_COLOR];
    
}

%end

%hook CKMessageEntryContentView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        id textView = MSHookIvar<id>(self, "_textView");
        [textView setTextColor:TEXT_COLOR];
    }
}

%end



/*
 .88b  d88.  .d8b.  d888888b db
 88'YbdP`88 d8' `8b   `88'   88
 88  88  88 88ooo88    88    88
 88  88  88 88~~~88    88    88
 88  88  88 88   88   .88.   88booo.
 YP  YP  YP YP   YP Y888888P Y88888P
*/

%group MailApp

%hook MFMessageWebLayer

static NSString* css = @"font-face { font-family: 'Chalkboard'; src: local('ChalkboardSE-Regular'); } body { background-color: none; color: #C7C7C7; font-family: Chalkboard;} a { color: #3E98BD; text-decoration: none;}";

-(void)setFrame:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        [self setOpaque:NO];
        
    }
}

- (void)_webthread_webView:(id)arg1 didFinishDocumentLoadForFrame:(id)arg2 {
    if (isEnabled) {
        [self setUserStyleSheet:css];
    }
    %orig;
    
}

- (void)_webthread_webView:(id)arg1 didFinishLoadForFrame:(id)arg2 {
    if (isEnabled) {
        [self setUserStyleSheet:css];
    }
    %orig;
}

- (void)webView:(id)arg1 didFinishLoadForFrame:(id)arg2 {
    if (isEnabled) {
        [self setUserStyleSheet:css];
    }
    %orig;
}

- (void)webThreadWebView:(id)arg1 resource:(id)arg2 didFinishLoadingFromDataSource:(id)arg3 {
    if (isEnabled) {
        [self setUserStyleSheet:css];
    }
    %orig;
}

%end


%hook MFSubjectWebBrowserView


-(void)loadHTMLString:(id)arg1 baseURL:(id)arg2 {
    
    if (isEnabled) {
        arg1 = [arg1 stringByReplacingOccurrencesOfString:@"color: #000"
                                               withString:@"color: #C7C7C7"];
        [self setOpaque:NO];
    }
    
    
    %orig(arg1, arg2);
}

%end

%hook _CellStaticView

- (void)layoutSubviews {
    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
    }
}

%end

%end

//Do not group (Body compose view)

%hook MFMailComposeView

-(id)bodyTextView {
    id view = %orig;
    if (isEnabled) {
        [view setTextColor:TEXT_COLOR];
    }
    return view;
}

%end


/*
.d8888.  .d8b.  d88888b  .d8b.  d8888b. d888888b 
88'  YP d8' `8b 88'     d8' `8b 88  `8D   `88'   
`8bo.   88ooo88 88ooo   88ooo88 88oobY'    88    
  `Y8b. 88~~~88 88~~~   88~~~88 88`8b      88    
db   8D 88   88 88      88   88 88 `88.   .88.   
`8888Y' YP   YP YP      YP   YP 88   YD Y888888P
*/

@interface _UIBackdropView : UIView
@end

@interface NavigationBarBackdrop : _UIBackdropView
@end

@interface DimmingButton : UIButton
-(UIImage *)maskImage:(UIImage*)image withColor:(UIColor *)color;
@end


%group SafariApp

%hook DimmingButton

%new
-(UIImage *)maskImage:(UIImage*)image withColor:(UIColor *)color
{
    CGImageRef maskImage = image.CGImage;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGRect bounds = CGRectMake(0,0,width,height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextClipToMask(bitmapContext, bounds, maskImage);
    CGContextSetFillColorWithColor(bitmapContext, color.CGColor);
    CGContextFillRect(bitmapContext, bounds);
    
    CGImageRef cImage = CGBitmapContextCreateImage(bitmapContext);
    UIImage *coloredImage = [UIImage imageWithCGImage:cImage];
    
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(cImage);
    
    return coloredImage;
}


- (void)layoutSubviews {
    %orig;

    if (isEnabled) {
        for (UIImageView* imageView in [self subviews]) {
            UIImage* newImage = [self maskImage:imageView.image withColor:selectedTintColor()];
            
            imageView.image = newImage;
            return;
            
        }
    }
}
     
 

%end

@interface NavigationBarReaderButton : NSObject
-(UIImage *)maskImage:(UIImage*)image withColor:(UIColor *)color;
@end

%hook NavigationBarReaderButton


%new
-(UIImage *)maskImage:(UIImage*)image withColor:(UIColor *)color
{
    CGImageRef maskImage = image.CGImage;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGRect bounds = CGRectMake(0,0,width,height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextClipToMask(bitmapContext, bounds, maskImage);
    CGContextSetFillColorWithColor(bitmapContext, color.CGColor);
    CGContextFillRect(bitmapContext, bounds);
    
    CGImageRef cImage = CGBitmapContextCreateImage(bitmapContext);
    UIImage *coloredImage = [UIImage imageWithCGImage:cImage];
    
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(cImage);
    
    return coloredImage;
}

- (id)initWithFrame:(struct CGRect)arg1 {
    id button = %orig;
    UIImageView* imgView = MSHookIvar<UIImageView*>(self, "_glyphView");
    imgView.image = [self maskImage:imgView.image withColor:selectedTintColor()];
    
    UIImageView* selectedImgView = MSHookIvar<UIImageView*>(self, "_glyphKnockoutView");
    selectedImgView.image = [self maskImage:selectedImgView.image withColor:selectedTintColor()];
    
    return button;
}

%end

%hook NavigationBar

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        
        NavigationBarBackdrop* backdropView = MSHookIvar<NavigationBarBackdrop*>(self, "_backdrop");
        
        UIView* view = [[UIView alloc] init];
        view.frame = backdropView.frame;
        [view setBackgroundColor:NAV_COLOR];
        [backdropView addSubview:view];
        
    }
}

%end

%hook TabBarItemView

-(void)_layoutCloseButton {
    %orig;
    
    if (isEnabled && IsiPad) {
        UIButton* closeButton = MSHookIvar<UIButton*>(self, "_closeButton");
        [closeButton setTintColor:selectedTintColor()];
    }
}


%end

%hook BrowserToolbar

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        _UIBackdropView* backdropView = MSHookIvar<_UIBackdropView*>(self, "_backgroundView");
        
        
        if(IsiPad) {
        }
        else {
            UIView* view = [[UIView alloc] init];
            view.frame = backdropView.frame;
            [view setBackgroundColor:NAV_COLOR];
            [backdropView addSubview:view];
        }
        
        //backdropView.hidden = YES;
        
        
        
    }
}

%end

%end

/*
 d8888b.  .d8b.  .d8888. .d8888. d8888b.  .d88b.   .d88b.  db   dD
 88  `8D d8' `8b 88'  YP 88'  YP 88  `8D .8P  Y8. .8P  Y8. 88 ,8P'
 88oodD' 88ooo88 `8bo.   `8bo.   88oooY' 88    88 88    88 88,8P
 88~~~   88~~~88   `Y8b.   `Y8b. 88~~~b. 88    88 88    88 88`8b
 88      88   88 db   8D db   8D 88   8D `8b  d8' `8b  d8' 88 `88.
 88      YP   YP `8888Y' `8888Y' Y8888P'  `Y88P'   `Y88P'  YP   YD
*/

%group PassbookApp

%hook WLEasyToHitCustomView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        for (UIView* button in [self subviews]) {
            if ([button isKindOfClass:[UIButton class]]) {
                [button setBackgroundColor:[UIColor clearColor]];
            }
        }
    }
}

%end

%end

/*
 d8888b. d88888b .88b  d88. d888888b d8b   db d8888b. d88888b d8888b. .d8888.
 88  `8D 88'     88'YbdP`88   `88'   888o  88 88  `8D 88'     88  `8D 88'  YP
 88oobY' 88ooooo 88  88  88    88    88V8o 88 88   88 88ooooo 88oobY' `8bo.
 88`8b   88~~~~~ 88  88  88    88    88 V8o88 88   88 88~~~~~ 88`8b     `Y8b.
 88 `88. 88.     88  88  88   .88.   88  V888 88  .8D 88.     88 `88. db   8D
 88   YD Y88888P YP  YP  YP Y888888P VP   V8P Y8888D' Y88888P 88   YD `8888Y'
*/

%group RemindersApp

%hook RemindersSearchView

#warning Reminders needs work
-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIView* searchView = MSHookIvar<UIView*>(self, "_searchResultsView");
    }
    
}

%end

%hook RemindersCardBackgroundView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setAlpha:0.9];
        for (UIView* view in [self subviews]) {
            
            //[view setAlpha:0.7];
            [view setBackgroundColor:[VIEW_COLOR colorWithAlphaComponent:0.8]];
        }
    }
}

%end

%end

/*
 .88b  d88. db    db .d8888. d888888b  .o88b.
 88'YbdP`88 88    88 88'  YP   `88'   d8P  Y8
 88  88  88 88    88 `8bo.      88    8P
 88  88  88 88    88   `Y8b.    88    8b
 88  88  88 88b  d88 db   8D   .88.   Y8b  d8
 YP  YP  YP ~Y8888P' `8888Y' Y888888P  `Y88P'
*/

static BOOL BlurredMusicAppInstalled() {
    return [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/BlurredMusicApp.dylib"];
}

static BOOL ColorFlowInstalled() {
    return [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/ColorFlow.dylib"];
}

static BOOL AriaInstalled() {
    return [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/Aria.dylib"];
}


static BOOL playsNice() {

    
    if (BlurredMusicAppInstalled()) {
        dlopen("/Library/MobileSubstrate/DynamicLibraries/BlurredMusicApp.dylib", RTLD_NOW);
        return NO;
    }
    if (ColorFlowInstalled()) {
         dlopen("/Library/MobileSubstrate/DynamicLibraries/ColorFlow.dylib", RTLD_NOW);
        return NO;
    }
    if (AriaInstalled()) {
         dlopen("/Library/MobileSubstrate/DynamicLibraries/Aria.dylib", RTLD_NOW);
        return NO;
    }
    return YES;
}

%group MusicApp

%hook MPUVignetteBackgroundView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        for (UIImageView* imageView in [self subviews]) {
            imageView.hidden = YES;
        }
    }
}

%end

%hook MPUNowPlayingIndicatorView

-(id)initWithFrame:(CGRect)arg1 {
    id hook = %orig;
    
    if (isEnabled && playsNice()) {
        [self setBackgroundColor: NAV_COLOR];
    }
    return hook;
}

%end

%hook MPUTableViewController

-(void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3 {
    %orig;
    if (isEnabled) {
        [arg2 setBackgroundColor:VIEW_COLOR];
    }
    
}

%end

%hook MusicNowPlayingTransportControls

-(id)tintColorForPart:(unsigned long long)arg1 {
    id tint = %orig;
    
    if (isEnabled && playsNice()) {
        tint = TEXT_COLOR;
        
    }
    return tint;
}
%end

@interface MusicNowPlayingPlaybackControlsView : UIView{}
@end

%hook MusicNowPlayingPlaybackControlsView

-(void)layoutSubviews {
    %orig;
    
    if (isEnabled && playsNice()) {
        [self setBackgroundColor:VIEW_COLOR];
        [self setTintColor:selectedTintColor()];
        
        UISlider* volumeSlider = MSHookIvar<UISlider*>(self, "_volumeSlider");
        [volumeSlider setMinimumTrackTintColor:selectedTintColor()];
    }
}

%end

%hook MusicMiniPlayerMusicTransportControls

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        for (UIButton* button in [self subviews]) {
            [button setTintColor:TEXT_COLOR];
        }
    }
}

%end

%end

/*
 d8b   db  .d88b.  d888888b d88888b .d8888.
 888o  88 .8P  Y8. `~~88~~' 88'     88'  YP
 88V8o 88 88    88    88    88ooooo `8bo.
 88 V8o88 88    88    88    88~~~~~   `Y8b.
 88  V888 `8b  d8'    88    88.     db   8D
 VP   V8P  `Y88P'     YP    Y88888P `8888Y'
*/

%group NotesApp

%hook UIColor
//such hacky

+(id)colorWithWhite:(float)arg1 alpha:(float)arg2 {
    
    id color = %orig;
    
    if (isEnabled) {
        if (arg1 < .5) {
            return TEXT_COLOR;
        }
    }
    return %orig;
}
%end

%hook NotesTextureView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self removeFromSuperview];
    }
}

%end

%end

/*
  .d8b.  d8888b. d8888b. .d8888. d888888b  .d88b.  d8888b. d88888b
 d8' `8b 88  `8D 88  `8D 88'  YP `~~88~~' .8P  Y8. 88  `8D 88'
 88ooo88 88oodD' 88oodD' `8bo.      88    88    88 88oobY' 88ooooo
 88~~~88 88~~~   88~~~     `Y8b.    88    88    88 88`8b   88~~~~~
 88   88 88      88      db   8D    88    `8b  d8' 88 `88. 88.
 YP   YP 88      88      `8888Y'    YP     `Y88P'  88   YD Y88888P
*/

%group AppstoreApp

%hook SKUITableViewCell

-(void)layoutSubviews {
    %orig;
    [self setBackgroundColor:VIEW_COLOR];
}

%end

%hook SKUITextBoxView

-(void)setFrame:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        id cs = MSHookIvar<id>(self, "_colorScheme");
        cs = [[objc_getClass("SKUIColorScheme") alloc] init];
        [cs setPrimaryTextColor:TEXT_COLOR];
        [cs setSecondaryTextColor:TEXT_COLOR];
        [self setColorScheme:cs];
        [cs release];
        
    }
}

%end

%hook SKUIProductPageHeaderLabel

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setTextColor:TEXT_COLOR];
    }
}

%end
%end

//Calendar

%group CalendarApp
%hook UIColor

//such hacky

+(id)whiteColor {
    if (isEnabled) {
        return VIEW_COLOR;
    }
    return %orig;
}

+(id)blackColor {
    if (isEnabled) {
        return TEXT_COLOR;
    }
    return %orig;
}

+(id)colorWithWhite:(float)arg1 alpha:(float)arg2 {
    UIColor* color = %orig;
    if (![color isEqual:TEXT_COLOR] && (isLightColor(color)) && (IsiPad)) {
        return VIEW_COLOR;
    }
    return color;
}

%end
%end

%group CalendarFix
%hook UIStatusBar

-(id)foregroundColor {
    UIColor* color = %orig;
    if (isEnabled) {
        if ([selectedStatusbarTintColor() isEqual:WHITE_COLOR]) {
            color = [UIColor lightGrayColor];
        }
        else {
            color = selectedStatusbarTintColor();
        }
    }
    return color;
}
%end
%end


/*
 _____         _                    _
 |____ |       | |                  | |
     / /_ __ __| |  _ __   __ _ _ __| |_ _   _
     \ \ '__/ _` | | '_ \ / _` | '__| __| | | |
 .___/ / | | (_| | | |_) | (_| | |  | |_| |_| |
 \____/|_|  \__,_| | .__/ \__,_|_|   \__|\__, |
                   | |                    __/ |
                   |_|                   |___/
*/



/*
  .o88b.  .d88b.  db    db d8888b. d888888b  .d8b.
 d8P  Y8 .8P  Y8. 88    88 88  `8D   `88'   d8' `8b
 8P      88    88 88    88 88oobY'    88    88ooo88
 8b      88    88 88    88 88`8b      88    88~~~88
 Y8b  d8 `8b  d8' 88b  d88 88 `88.   .88.   88   88
`  Y88P'  `Y88P'  ~Y8888P' 88   YD Y888888P YP   YP
 */

%hook CouriaController

-(void)present {
    isEnabled = NO;
    %orig;
}

-(void)dismiss {
    isEnabled = isTweakEnabled();
    %orig;
}

%end

/*
 db   d8b   db db   db  .d8b.  d888888b .d8888.  .d8b.  d8888b. d8888b.
 88   I8I   88 88   88 d8' `8b `~~88~~' 88'  YP d8' `8b 88  `8D 88  `8D
 88   I8I   88 88ooo88 88ooo88    88    `8bo.   88ooo88 88oodD' 88oodD'
 Y8   I8I   88 88~~~88 88~~~88    88      `Y8b. 88~~~88 88~~~   88~~~
 `8b d8'8b d8' 88   88 88   88    88    db   8D 88   88 88      88
  `8b8' `8d8'  YP   YP YP   YP    YP    `8888Y' YP   YP 88      88
 */

%group WhatsappApp

/*
%hook UIColor

+(id)systemBlueColor {
    if (isEnabled) {
        return [UIColor clearColor]; //Stupid Edit Cell Fix - Don't know what this has to do...  but ok.
    }
    return %orig;
}
%end
 */

%hook WAInputTextView

- (id)initWithFrame:(struct CGRect)arg1 {
    id kek = %orig;
    if (isEnabled) {
        [self setTextColor:TEXT_COLOR];
    }
    
    return kek;
}

%end

%hook WAChatBar

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIButton* _sendButton = MSHookIvar<UIButton*>(self, "_sendButton");
        UIButton* _attachMediaButton = MSHookIvar<UIButton*>(self, "_attachMediaButton");
        UIButton* _cameraButton = MSHookIvar<UIButton*>(self, "_cameraButton");
        UIButton* _pttButton = MSHookIvar<UIButton*>(self, "_pttButton");
        
        [_sendButton setTintColor:selectedTintColor()];
        [_attachMediaButton setTintColor:selectedTintColor()];
        [_cameraButton setTintColor:selectedTintColor()];
        [_pttButton setTintColor:selectedTintColor()];
    }
    
}

%end

%hook WAMessageFooterView

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UILabel* _timestampLabel = MSHookIvar<UILabel*>(self, "_timestampLabel");
        [_timestampLabel setTextColor:RED_COLOR];
    }
}

%end

%hook WAEventBubbleView

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UILabel* labelEvent = MSHookIvar<UILabel*>(self, "_labelEvent");
        [labelEvent setTextColor:RED_COLOR];
    }
}

%end

%hook WADateBubbleView

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UILabel* titleLabel = MSHookIvar<UILabel*>(self, "_titleLabel");
        [titleLabel setTextColor:RED_COLOR];
    }
    
    
}

%end

%hook WAChatButton

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setTintColor:selectedTintColor()];
    }
}

%end

%hook WAChatSessionCell

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UILabel* messageLabel = MSHookIvar<UILabel*>(self, "_messageLabel");
        if (shouldColorDetailText()) {
            [messageLabel setTextColor:selectedTintColor()];
        }
        else {
            [messageLabel setTextColor:TEXT_COLOR];
        }
    }
}

%end

%hook WAContactNameLabel

- (id)textColor {
    if (isEnabled) {
        [self setBackgroundColor:[UIColor clearColor]];
        return TEXT_COLOR;
    }
    return %orig;
}

- (void)setTextColor:(id)fp8 {
    if (isEnabled) {
        %orig(TEXT_COLOR);
        [self setBackgroundColor:[UIColor clearColor]];
        return;
    }
    %orig;
}

%end

%hook _WANoBlurNavigationBar

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIView* bgView = MSHookIvar<UIView*>(self, "_grayBackgroundView");
        [bgView setBackgroundColor:NAV_COLOR];
    }
    
}

- (id)initWithFrame:(struct CGRect)arg1 {
    id bar = %orig;
    if (isEnabled) {
        UIView* bgView = MSHookIvar<UIView*>(self, "_grayBackgroundView");
        [bgView setBackgroundColor:NAV_COLOR];
    }
    return bar;
}

%end

%end



/*
 d888888b d8b   db .d8888. d888888b  .d8b.   d888b  d8888b.  .d8b.  .88b  d88.
 `88'   888o  88 88'  YP `~~88~~' d8' `8b 88' Y8b 88  `8D d8' `8b 88'YbdP`88
 88    88V8o 88 `8bo.      88    88ooo88 88      88oobY' 88ooo88 88  88  88
 88    88 V8o88   `Y8b.    88    88~~~88 88  ooo 88`8b   88~~~88 88  88  88
 .88.   88  V888 db   8D    88    88   88 88. ~8~ 88 `88. 88   88 88  88  88
 Y888888P VP   V8P `8888Y'    YP    YP   YP  Y888P  88   YD YP   YP YP  YP  YP
 */

@interface IGStringStyle : NSObject
@property(retain, nonatomic) UIColor *defaultColor;
@end

%group InstagramApp

%hook IGCommentThreadViewController

- (void)viewWillLayoutSubviews {
    %orig;
    
    if (isEnabled) {
        UIView* _textViewContainer = MSHookIvar<UIView*>(self, "_textViewContainer");
        
        for (UIImageView* kek in _textViewContainer.subviews) {
            if ([kek respondsToSelector:@selector(setImage:)]) {
                [kek setImage:nil];
            }
        }
    }
    
}
%end

%hook IGSimpleButton

- (void)layoutSubviews {
    %orig;
    
    if (isEnabled) {
        UIImageView* _backgroundImageView = MSHookIvar<UIImageView*>(self, "_backgroundImageView");
        
        [_backgroundImageView setAlpha:0.1];
    }
}

%end

%hook IGTabControl

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIView* _bgView= MSHookIvar<UIImageView*>(self, "_bgView");
        [_bgView setAlpha:0.1];
        
    }
}

%end

%hook UITextFieldBorderView

-(void)layoutSubviews {
    %orig;
    
    if (isEnabled) {
        [self setAlpha:0.05];
    }
}

%end

%hook IGNavSearchBar

- (void)layoutSubviews {
    %orig;
    
    if (isEnabled) {
        UIImageView* _editingStateBackgroundView = MSHookIvar<UIImageView*>(self, "_editingStateBackgroundView");
        
        [_editingStateBackgroundView setAlpha:0.1];
    }
}

%end

%hook IGStyledString //Instagram Text Rendering
- (void)appendString:(id)arg1 {
    if (isEnabled) {
        IGStringStyle* style = MSHookIvar<id>(self, "_style");
        style.defaultColor = TEXT_COLOR;
    }
    
    %orig;
}

%end

%end

/*
 d888888b db   d8b   db d888888b d888888b d888888b d88888b d8888b.
 `~~88~~' 88   I8I   88   `88'   `~~88~~' `~~88~~' 88'     88  `8D
    88    88   I8I   88    88       88       88    88ooooo 88oobY'
    88    Y8   I8I   88    88       88       88    88~~~~~ 88`8b
    88    `8b d8'8b d8'   .88.      88       88    88.     88 `88.
    YP     `8b8' `8d8'  Y888888P    YP       YP    Y88888P 88   YD
 */

%group TwitterApp

%hook ABCustomHitTestView

-(id)backgroundColor {
    return RED_COLOR;
}

%end

%hook TFNCustomHitTestView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
    }
}

%end

%hook TFNCellDrawingView

- (void)setBackgroundColor:(id)arg1 {
    if (isEnabled) {
        arg1 = VIEW_COLOR;
    }
    %orig(arg1);
}

%end

%hook T1TweetDetailsAttributedStringItem //1.4.3 fix

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
    }
}

%end



%hook UIColor //Twitter Colors

//Cell
+ (id)tfn_cellSeparatorColor {
    if (isEnabled) {
        return NAV_COLOR;
    }
    return %orig;
}

//Text
+ (id)twitterColorTextUsername {
    if (isEnabled) {
        return TEXT_COLOR;
    }
    return %orig;
}
+ (id)twitterColorTextFullName {
    if (isEnabled) {
        return selectedTintColor();
    }
    return %orig;
}
+ (id)twitterColorText {
    if (isEnabled) {
        return TEXT_COLOR;
    }
    return %orig;
}
+ (id)twitterColorTextLinkSubtle {
    if (isEnabled) {
        return selectedTintColor();
    }
    return %orig;
}
+ (id)twitterColorTextLink {
    if (isEnabled) {
        return selectedTintColor();
    }
    return %orig;
}


%end

%end


/*
 db   dD d888888b db   dD
 88 ,8P'   `88'   88 ,8P'
 88,8P      88    88,8P
 88`8b      88    88`8b
 88 `88.   .88.   88 `88.
 YP   YD Y888888P YP   YD
 */

%group KikApp

%hook HybridSmileyLabel

- (id)textColor {
    if (isEnabled) {
        return [UIColor darkGrayColor];
    }
    return %orig;
}


%end

%hook BlurryUIView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:NAV_COLOR];
    }
    
}
%end

%hook BlurredRawProfilePictureImageView

- (id)initWithFrame:(struct CGRect)arg1 {
    id kek = %orig;
    if (isEnabled) {
        UIColor* _blurTintColor = MSHookIvar<UIColor*>(self, "_blurTintColor");
        _blurTintColor = VIEW_COLOR;
        [self setAlpha:0.2];
    }
    return kek;
}

%end

%hook CardListTableViewCell


- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIImageView* backgroundImage = MSHookIvar<UIImageView*>(self, "_imgBackground");
        [backgroundImage removeFromSuperview];
    }
}

%end

%hook HPTextViewInternal

- (id)updateTextForSmileys {
    id kek = %orig;
    if (isEnabled) {
        [self setTextColor:TEXT_COLOR];
    }
    return kek;
}

-(void)setPlaceholder:(NSString *)placeholder {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
        [self setOpaque:YES];
        [self setTextColor:TEXT_COLOR];
    }
}
-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
        [self setOpaque:YES];
        [self setTextColor:TEXT_COLOR];
    }
}

-(void)setTextColor:(id)color {
    if (isEnabled) {
        %orig(TEXT_COLOR);
        return;
    }
    %orig;
}

-(id)textColor {
    if (isEnabled) {
        return TEXT_COLOR;
    }
    return %orig;
}

- (void)drawRect:(CGRect)rect {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
        [self setOpaque:YES];
        [self setTextColor:TEXT_COLOR];
    }
}


%end

%end

/*
 d888888b db   db d8888b. d88888b d88888b .88b  d88.  .d8b.
 `~~88~~' 88   88 88  `8D 88'     88'     88'YbdP`88 d8' `8b
    88    88ooo88 88oobY' 88ooooo 88ooooo 88  88  88 88ooo88
    88    88~~~88 88`8b   88~~~~~ 88~~~~~ 88  88  88 88~~~88
    88    88   88 88 `88. 88.     88.     88  88  88 88   88
    YP    YP   YP 88   YD Y88888P Y88888P YP  YP  YP YP   YP
*/

%group ThreemaApp

@interface ChatBar : UIImageView
+ (int)perceivedBrightness:(UIColor *)aColor;
+ (UIColor *)contrastBWColor:(UIColor *)aColor;
+ (UIImage *)_imageWithColor:(UIColor *)color;
-(id)initWithFrame:(CGRect)arg1;
@end

%hook ChatBar
%new
+ (int)perceivedBrightness:(UIColor *)aColor
{
	CGFloat r = 0, g = 0, b = 0, a = 1;
	if ( [aColor getRed:&r green:&g blue:&b alpha:&a] ) {
		r=255*r; g=255*g; b=255*b;
		return (int)sqrt(r * r * .241 + g * g * .691 + b * b * .068);
	} else if ([aColor getWhite:&r alpha:&a]) {
		return (255*r);
	}
	return 255;
}

%new
+ (UIColor *)contrastBWColor:(UIColor *)aColor {
	if ( [self perceivedBrightness:aColor] > 130 ) {
		return [UIColor blackColor];
	} else {
		return [UIColor whiteColor];
	}
}

%new
+ (UIImage *)_imageWithColor:(UIColor *)color {
	CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}

-(id)initWithFrame:(CGRect)arg1 {
	self = %orig;
	if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
		//NSLog(@"ChatBar init");
		UIColor* barBgColor = NAV_COLOR; //Eclipse Theme Color
		UIColor* barTopLineColor = [[self class] contrastBWColor:selectedTintColor()]; //Eclipse tint Color
		[self setImage:[[self class] _imageWithColor:barBgColor]];
		for(UIView* view in self.subviews){
			if([view isKindOfClass:[UIImageView class]]){
                [((UIImageView *)view) setImage:nil];
            }
		}
		UIImageView* topLineView = [[UIImageView alloc] initWithImage:[[self class] _imageWithColor:barTopLineColor]];
		[topLineView setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self addSubview:topLineView];
		NSArray* constraintsDef = @[@{@"attribute": @(NSLayoutAttributeCenterX), @"multiplier": @1, @"constant": @0},
                                    @{@"attribute": @(NSLayoutAttributeTop), @"multiplier": @1, @"constant": @0},
                                    @{@"attribute": @(NSLayoutAttributeWidth), @"multiplier": @1, @"constant": @0},
                                    @{@"attribute": @(NSLayoutAttributeHeight), @"multiplier": @0, @"constant": @1}];
		for (NSDictionary* cDict in constraintsDef) {
			NSLayoutConstraint *myConstraint = [NSLayoutConstraint constraintWithItem:topLineView
                                                                            attribute:[cDict[@"attribute"] integerValue]
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self
                                                                            attribute:[cDict[@"attribute"] integerValue]
                                                  	 		               multiplier:[cDict[@"multiplier"] floatValue]
                                                                             constant:[cDict[@"constant"] floatValue]];
			myConstraint.priority = 700;
			[self addConstraint:myConstraint];
		}
		[self setNeedsUpdateConstraints];
		//NSLog(@"ChatBar init END");
	}
	return self;
}

%end

%hook TTTAttributedLabel

-(id)textColor {
    if (isEnabled) {
        return [UIColor darkGrayColor];
    }
    return %orig;
}

%end
%end

/*
 d888888b d88888b db      d88888b  d888b  d8888b.  .d8b.  .88b  d88.
 `~~88~~' 88'     88      88'     88' Y8b 88  `8D d8' `8b 88'YbdP`88
    88    88ooooo 88      88ooooo 88      88oobY' 88ooo88 88  88  88
    88    88~~~~~ 88      88~~~~~ 88  ooo 88`8b   88~~~88 88  88  88
    88    88.     88booo. 88.     88. ~8~ 88 `88. 88   88 88  88  88
    YP    Y88888P Y88888P Y88888P  Y888P  88   YD YP   YP YP  YP  YP
*/

%group TelegramApp

%hook TGBackdropView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:NAV_COLOR];
    }
}

%end

%hook TGContactCellContents

-(void)layoutSubviews {
    %orig;
    for (id meh in [self subviews]) {
        if ([meh respondsToSelector:@selector(setTextColor:)]) {
            [meh setTextColor:TEXT_COLOR];
        }
    }
}

%end

%end

/*
 d888888b db   d8b   db d88888b d88888b d888888b d8888b.  .d88b.  d888888b
 `~~88~~' 88   I8I   88 88'     88'     `~~88~~' 88  `8D .8P  Y8. `~~88~~'
    88    88   I8I   88 88ooooo 88ooooo    88    88oooY' 88    88    88
    88    Y8   I8I   88 88~~~~~ 88~~~~~    88    88~~~b. 88    88    88
    88    `8b d8'8b d8' 88.     88.        88    88   8D `8b  d8'    88
    YP     `8b8' `8d8'  Y88888P Y88888P    YP    Y8888P'  `Y88P'     YP
*/

%group TweetbotApp

%hook PTHTweetbotStatusView

-(void)viewDidLoad {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:TABLE_COLOR];
    }
}

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:TABLE_COLOR];
    }
}

- (void)_updateColors {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:TABLE_COLOR];
    }
}

%end

%hook PTHStaticSectionCell

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
    }
}

- (void)colorThemeDidChange {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
    }
}

%end

%hook PTHButton

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
    }
}

- (void)colorThemeDidChange {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
    }
}

%end

%end

/*
 d888888b db    db .88b  d88. d8888b. db      d8888b.
 `~~88~~' 88    88 88'YbdP`88 88  `8D 88      88  `8D
    88    88    88 88  88  88 88oooY' 88      88oobY'
    88    88    88 88  88  88 88~~~b. 88      88`8b
    88    88b  d88 88  88  88 88   8D 88booo. 88 `88.
    YP    ~Y8888P' YP  YP  YP Y8888P' Y88888P 88   YD
*/

%group TumblrApp

%hook TMAttributedTextView

- (void)setAttributedText:(id)arg1 frame:(struct __CTFrame *)arg2 {
    NSAttributedString* _attributedText = MSHookIvar<NSAttributedString*>(self, "_attributedText");
    

    
    %orig(_attributedText, arg2);
}

%end

%end

/*
 db    db d888888b d8b   db d88888b
 88    88   `88'   888o  88 88'
 Y8    8P    88    88V8o 88 88ooooo
 `8b  d8'    88    88 V8o88 88~~~~~
  `8bd8'    .88.   88  V888 88.
    YP    Y888888P VP   V8P Y88888P
*/
/*
%hook TTTAttributedLabel

-(void)commonInit {
    if (!isTextLightColor(self.textColor)) {
        [self setTextColor:TEXT_COLOR];
    }
    %orig;
}

%end
*/
//relay

%group RelayApp



%end

/*
 .o88b. db       .d8b.  .d8888. .d8888. d888888b  .o88b. db      .d8888.
d8P  Y8 88      d8' `8b 88'  YP 88'  YP   `88'   d8P  Y8 88      88'  YP
8P      88      88ooo88 `8bo.   `8bo.      88    8P      88      `8bo.
8b      88      88~~~88   `Y8b.   `Y8b.    88    8b      88        `Y8b.
Y8b  d8 88booo. 88   88 db   8D db   8D   .88.   Y8b  d8 88booo. db   8D
 `Y88P' Y88888P YP   YP `8888Y' `8888Y' Y888888P  `Y88P' Y88888P `8888Y'
*/

%hook SBAwayLockBar

- (id)initWithFrame:(struct CGRect)arg1 {
    id bar = %orig;
    if (isEnabled) {
        UISlider* unlockSlider = MSHookIvar<UISlider*>(self, "_unlockSlider");
        [unlockSlider setMinimumTrackTintColor:nil];
    }
    return bar;
}

%end

/*
  .d8888. d8b   db  .d8b.  d8888b.  .o88b. db   db  .d8b.  d888888b
  88'  YP 888o  88 d8' `8b 88  `8D d8P  Y8 88   88 d8' `8b `~~88~~'
 ` 8bo.   88V8o 88 88ooo88 88oodD' 8P      88ooo88 88ooo88    88
    `Y8b. 88 V8o88 88~~~88 88~~~   8b      88~~~88 88~~~88    88
  db   8D 88  V888 88   88 88      Y8b  d8 88   88 88   88    88
  `8888Y' VP   V8P YP   YP 88       `Y88P' YP   YP YP   YP    YP
*/

%group SnapchatApp

%hook StoriesCell

- (id)initWithStyle:(int)arg1 reuseIdentifier:(id)arg2 {
    id cell = %orig;
    if (isEnabled) {
        //id bestFriendsView = MSHookIvar<id>(self, "_bestFriendsView");
        //[bestFriendsView setBackgroundColor:TABLE_COLOR];
        
        //[self.contentView setBackgroundColor:TABLE_COLOR];
    }
    
    
    return cell;
}

%end


%hook FeedTableViewCell

- (void)setFrame:(struct CGRect)arg1 {
    %orig;
    if (isEnabled) {
        UIView* solidBackgroundView = MSHookIvar<UISlider*>(self, "_solidBackgroundView");
        [solidBackgroundView setBackgroundColor:TABLE_COLOR];
    }
    
}

%end

%hook UITableViewCellContentView

-(void)setFrame:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:TABLE_COLOR];
    }
}

%end


%hook SCTopBorderedView

- (void)setFrame:(struct CGRect)arg1 {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
        //id bestFriendsView = MSHookIvar<id>(self, "_bestFriendsView");
    }
}

%end

%hook SCHeader

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:NAV_COLOR];
        id _bottomBorderedView = MSHookIvar<id>(self, "_bottomBorderedView");
        [_bottomBorderedView setBackgroundColor:NAV_COLOR];
    }
}

%end

%end

/*
 .d8888. d8b   db d8888b.  .o88b. db      d8888b.
 88'  YP 888o  88 88  `8D d8P  Y8 88      88  `8D
 `8bo.   88V8o 88 88   88 8P      88      88   88
   `Y8b. 88 V8o88 88   88 8b      88      88   88
 db   8D 88  V888 88  .8D Y8b  d8 88booo. 88  .8D
 `8888Y' VP   V8P Y8888D'  `Y88P' Y88888P Y8888D'
 */

%group SoundcloudApp

%hook SCTrackActivityMiniView

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
    }
    
}

%end

%hook SCiPhonePlayerContentView

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIView* actionBar = MSHookIvar<UIView*>(self, "actionBar");
        [actionBar setBackgroundColor:VIEW_COLOR];
    }
}

%end
%end



/*
 d88888b  .d8b.   .o88b. d88888b d8888b. db   dD
 88'     d8' `8b d8P  Y8 88'     88  `8D 88 ,8P'
 88ooo   88ooo88 8P      88ooooo 88oooY' 88,8P
 88~~~   88~~~88 8b      88~~~~~ 88~~~b. 88`8b
 88      88   88 Y8b  d8 88.     88   8D 88 `88.
 YP      YP   YP  `Y88P' Y88888P Y8888P' YP   YD
*/

/*
 iconView.layer.cornerRadius = iconView.frame.size.width / 2;
 iconView.clipsToBounds = YES;
 iconView.layer.borderWidth = 5.0f;
 iconView.layer.borderColor = [UIColor whiteColor].CGColor;
*/


%group FBMessenger

%hook MNProfileImageView
-(void)layoutSubviews {
    %orig;
    
    if (isEnabled) {
        NSMutableArray* _imageViews = MSHookIvar<NSMutableArray*>(self, "_imageViews");
        
        for (UIImageView* view in _imageViews) {
            view.layer.cornerRadius = view.frame.size.width / 2;
            view.clipsToBounds = YES;
            view.layer.borderWidth = 1.0f;
            view.layer.borderColor = selectedTintColor().CGColor;
        }
    }
    
}

%end

%hook MNBadgedProfileImageView

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIImageView* _maskImageView = MSHookIvar<UIImageView*>(self, "_maskImageView");
        [_maskImageView  setHidden:YES];
        
        UIImageView* _profileImageView = MSHookIvar<UIImageView*>(self, "_profileImageView");
        
        _profileImageView.layer.cornerRadius = _profileImageView.frame.size.width / 2;
        _profileImageView.clipsToBounds = YES;
        _profileImageView.layer.borderWidth = 1.0f;
        _profileImageView.layer.borderColor = selectedTintColor().CGColor;
    }
}

%end

%hook MNGroupItemView

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIImageView* _backgroundImageView = MSHookIvar<UIImageView*>(self, "_backgroundImageView");
        _backgroundImageView.image = nil;
        
        UIImageView* _groupImageMaskView = MSHookIvar<UIImageView*>(self, "_groupImageMaskView");
        _groupImageMaskView.image = nil;
    }
}


%end

%hook MNSettingsUserInfoCell

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIImageView* _messengerBadge = MSHookIvar<UIImageView*>(self, "_messengerBadge");
        _messengerBadge.image = nil;
        
        UIImageView* _profilePhotoView = MSHookIvar<UIImageView*>(self, "_profilePhotoView");
        _profilePhotoView.layer.cornerRadius = _profilePhotoView.frame.size.width / 2;
        _profilePhotoView.clipsToBounds = YES;
        _profilePhotoView.layer.borderWidth = 1.0f;
        _profilePhotoView.layer.borderColor = selectedTintColor().CGColor;
    }
}

%end

%hook MNPeopleCell

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        for (UIImageView* view in [[self contentView] subviews]) {
            if ([view respondsToSelector:@selector(setImage:)]) {
                
                view.layer.cornerRadius = view.frame.size.width / 2;
                view.clipsToBounds = YES;
                view.layer.borderWidth = 1.0f;
                view.layer.borderColor = selectedTintColor().CGColor;
                
            }
        }
    }
    
}

%end

%hook MNThreadCell

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIImageView* _presenceIndicator = MSHookIvar<UIImageView*>(self, "_presenceIndicator");
        //_presenceIndicator.image = nil;
        
        _presenceIndicator.layer.cornerRadius = _presenceIndicator.frame.size.width / 2;
        _presenceIndicator.clipsToBounds = YES;
        _presenceIndicator.layer.borderWidth = 1.0f;
        _presenceIndicator.layer.borderColor = [UIColor clearColor].CGColor;
    }
    
}

%end

%end

//Tinder

%group TinderApp

%hook TNDRChatViewController

- (void)viewWillAppear:(BOOL)arg1 {
    %orig;
    
     UIToolbar* _composeView = MSHookIvar<UIToolbar*>(self, "_composeView");
    
    for (UIImageView* image in [_composeView subviews]) {
        if ([image respondsToSelector:@selector(setImage:)]) {
            [image setAlpha:0.1];
        }
    }
    
}

%end

%hook TNDRChatBubbleCell

- (void)setupBackgroundImageView {
    %orig;
    
    UIImageView* _backgroundImageView = MSHookIvar<UIImageView*>(self, "_backgroundImageView");
    
    [_backgroundImageView setAlpha:0.2];
    
}

%end

%end


 
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
    
    //Third Party Application
    if (idIsEqual(@"us.mxms.relay")) {
        %init(RelayApp);
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
}

-(id)init {
    id hi = %orig;
    //Check if Application is on the blacklist
    BOOL isBlackListed = [[prefs objectForKey:[@"BlackListed-" stringByAppendingString:[self displayIdentifier]]] boolValue];
    
    
    if ((isTweakEnabled() && isBlackListed)) {
        isEnabled = NO; //On the blacklist, do not darken
    }
    if (isTweakEnabled() && !isBlackListed) {
        isEnabled = isTweakEnabled(); //Darken
    }
    
    if (idIsEqual(@"com.apple.springboard")) {
        shouldOverrideStatusBarStyle = NO;
        //Disable inside SpringBoard check
        if (disableInSB()) {
            isEnabled = NO;
        }
    }
    //If Tweak enabled:
    if (isEnabled) {
        
        %init(_ungrouped);
        [self checkRunningApp];
        darkenUIElements();
        
        
        if (UniformityInstalled()) {
            dlopen("/Library/MobileSubstrate/DynamicLibraries/Uniformity.dylib", RTLD_NOW);
        }
        
    }
    return hi;
}

%end


@interface SBApplication : NSObject
- (UIImage *)imageWithColor:(UIColor *)color;
@end

%hook SBApplication

%new
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(id)_defaultPNGForScreen:(id)arg1 launchingOrientation:(int)arg2 orientation:(int*)arg3 {
    
    if (isTweakEnabled() && replaceSplashScreens()) {
        return [self imageWithColor:VIEW_COLOR];
    }
    return %orig;
}

%end
%end
/*
OBJC_EXTERN CFStringRef MGCopyAnswer(CFStringRef key) WEAK_IMPORT_ATTRIBUTE;

%hook SpringBoard

%new
-(void)safeMode {
    system("killall -SEGV SpringBoard");
}

-(void)applicationDidFinishLaunching:(BOOL)beh {
    
    %orig;
    
    CFStringRef UDNumber = MGCopyAnswer(CFSTR("UniqueDeviceID"));
    NSString* UDID = (NSString*)UDNumber;
    
    NSString *url =[NSString stringWithFormat:@"http://gmoran.me/api/eclipse.php?UDID=%@", UDID];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [req setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse* urlResponse = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:req returningResponse:&urlResponse error:nil];
    
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    CFRelease(UDNumber);
    
    
    if ([result isEqualToString:@"Not Licensed"]) {
        
        if (IS_BETA_BUILD) {
            UIAlertView *alert = [[UIAlertView alloc]
                                    initWithTitle:@"Eclipse"
                                    message:@"Please do not pirate beta copies of Eclipse. Instead, please obtain a stable, public release. If you'd like to try the beta, please consider purchasing a license. Thanks!"
                                    delegate:nil
                                    cancelButtonTitle:nil
                                    otherButtonTitles:nil];
            [alert show];
            [alert release];
            [result release];
                
            [NSTimer scheduledTimerWithTimeInterval:15.0
                                                target:self
                                            selector:@selector(safeMode)
                                            userInfo:nil
                                            repeats:NO];
            
        }
        else {
 
            
            //Enough.
        }
    }
}



%end
*/

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


