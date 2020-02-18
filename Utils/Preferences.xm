/*
d8888b. d8888b. d88888b d88888b .d8888.
88  `8D 88  `8D 88'     88'     88'  YP
88oodD' 88oobY' 88ooooo 88ooo   `8bo.
88~~~   88`8b   88~~~~~ 88~~~     `Y8b.
88      88 `88. 88.     88      db   8D
88      88   YD Y88888P YP      `8888Y'
*/

///

static BOOL isClockApp;

static BOOL shouldOverrideStatusBarStyle = YES;

static NSDictionary *prefs;

static void wallpaperChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {


    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR(PREFS_CHANGED_NOTIF), NULL, NULL, TRUE);


    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Eclipse 2"
    message:@"Please respring your device for changes to take effect."
    delegate:nil
    cancelButtonTitle:@"OK"
    otherButtonTitles: nil];
    [alert show];

}

//================ Preferences KEYS ================//

static BOOL      _isTweakEnabled;
static BOOL      _colorDetailText;
static BOOL      _cellSeparatorsEnabled;
static BOOL      _darkenKeyboard;
static BOOL      _tintSMSBubbles;
static BOOL      _tintMessageBubbles;
static BOOL      _reverseModeEnabled;

static BOOL      _adaptiveUIEnabled;
static BOOL      _customNavColorsEnabled;
static BOOL      _customThemeColorsEnabled;
static BOOL      _customTintColorsEnabled;
static BOOL      _customStatusbarColorsEnabled;
static BOOL      _customTextColorsEnabled;
static BOOL      _darkWebEnabled;
static BOOL      _alertsEnabled;

static int       _selectedTheme;
static int       _selectedNavColor;
static int       _selectedKeyboardColor;
static int       _statusbarTint;
static int       _selectedTint;

static NSString* _customNavBarHex;
static NSString* _customThemeHex;
static NSString* _customTintHex;
static NSString* _customStatusbarHex;
static NSString* _customTextHex;

@interface SpringBoard : UIApplication
-(void)relaunchSpringBoard; // Respring
@end


static void prefsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

    /*
     CFPreferencesAppSynchronize(CFSTR("com.gmoran.eclipse"));

     _isTweakEnabled = !CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR("com.gmoran.eclipse")) ? YES : [(id)CFBridgingRelease(CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR("com.gmoran.eclipse"))) boolValue];
     */

    if (!IS_BETA_BUILD) {

        //boolean values

        if (prefs != nil) {
            prefs = nil;
            [prefs release];

        }

        prefs = [[NSDictionary alloc] initWithContentsOfFile:PREFS_FILE_PATH];
        //prefs = [[NSUserDefaults standardUserDefaults] persistentDomainForName:PREFS_DOMAIN];

        NSNumber *n = (NSNumber *)[prefs objectForKey:@"enabled"];
        _isTweakEnabled = (n)? [n boolValue]:NO;

        n = (NSNumber *)[prefs objectForKey:@"colorDetailText"];
        _colorDetailText = (n)? [n boolValue]:NO;

        n = (NSNumber *)[prefs objectForKey:@"cellSeparatorsEnabled"];
        _cellSeparatorsEnabled = (n)? [n boolValue]:NO;

        n = (NSNumber *)[prefs objectForKey:@"darkenKeyboard"];
        _darkenKeyboard = (n)? [n boolValue]:NO;

        n = (NSNumber *)[prefs objectForKey:@"tintSMSBubbles"];
        _tintSMSBubbles = (n)? [n boolValue]:NO;

        //_tintSMSBubbles = YES;

       n = (NSNumber *)[prefs objectForKey:@"tintMessageBubbles"];
       _tintMessageBubbles = (n)? [n boolValue]:NO;

        //_tintMessageBubbles = YES;

        n = (NSNumber *)[prefs objectForKey:@"reverseModeEnabled"];
        _reverseModeEnabled = (n)? [n boolValue]:NO;

        _selectedTheme = [(NSNumber*)[prefs objectForKey:@"selectedTheme"] intValue];
        _selectedNavColor = [(NSNumber*)[prefs objectForKey:@"selectedNavColor"] intValue];
        _selectedKeyboardColor = [(NSNumber*)[prefs objectForKey:@"selectedKeyboardColor"] intValue];
        _statusbarTint = [(NSNumber*)[prefs objectForKey:@"statusbarTint"] intValue];
        _selectedTint = [(NSNumber*)[prefs objectForKey:@"selectedTint"] intValue];


        /* Custom Colors */

        n = (NSNumber *)[prefs objectForKey:@"customNavColorsEnabled"];
        _customNavColorsEnabled = (n)? [n boolValue]:NO;

        n = (NSNumber *)[prefs objectForKey:@"customThemeColorsEnabled"];
        _customThemeColorsEnabled = (n)? [n boolValue]:NO;

        n = (NSNumber *)[prefs objectForKey:@"customTintColorsEnabled"];
        _customTintColorsEnabled = (n)? [n boolValue]:NO;

        n = (NSNumber *)[prefs objectForKey:@"customStatusbarColorsEnabled"];
        _customStatusbarColorsEnabled = (n)? [n boolValue]:NO;

        n = (NSNumber *)[prefs objectForKey:@"customTextColorsEnabled"];
        _customTextColorsEnabled = (n)? [n boolValue]:NO;
        //_customColorsEnabled = NO;

        _customNavBarHex = (NSString*)[prefs objectForKey:@"customNavBarHex"];
        _customThemeHex = (NSString*)[prefs objectForKey:@"customThemeHex"];
        _customTintHex = (NSString*)[prefs objectForKey:@"customTintHex"];
        _customStatusbarHex = (NSString*)[prefs objectForKey:@"customStatusbarHex"];
        _customTextHex = (NSString*)[prefs objectForKey:@"customTextHex"];


    }

    else {

        NSDate * currentDate = [NSDate date];
        NSDate * otherDate = [[NSDate alloc] initWithString:@"2020-02-27 12:00:00 +0600"];
        NSComparisonResult result = [currentDate compare:otherDate];

        if (result == NSOrderedAscending) { //Before Expiry

            prefs = [[NSDictionary alloc] initWithContentsOfFile:PREFS_FILE_PATH];
            //prefs = [[NSUserDefaults standardUserDefaults] persistentDomainForName:PREFS_DOMAIN];

            NSNumber *n = (NSNumber *)[prefs objectForKey:@"enabled"];
            _isTweakEnabled = (n)? [n boolValue]:NO;

            n = (NSNumber *)[prefs objectForKey:@"colorDetailText"];
            _colorDetailText = (n)? [n boolValue]:NO;

            n = (NSNumber *)[prefs objectForKey:@"alertsEnabled"];
            _alertsEnabled = (n)? [n boolValue]:NO;

            n = (NSNumber *)[prefs objectForKey:@"cellSeparatorsEnabled"];
            _cellSeparatorsEnabled = (n)? [n boolValue]:NO;

            n = (NSNumber *)[prefs objectForKey:@"darkenKeyboard"];
            _darkenKeyboard = (n)? [n boolValue]:NO;

            n = (NSNumber *)[prefs objectForKey:@"tintSMSBubbles"];
            _tintSMSBubbles = (n)? [n boolValue]:NO;

            //_tintSMSBubbles = YES;

            n = (NSNumber *)[prefs objectForKey:@"tintMessageBubbles"];
            _tintMessageBubbles = (n)? [n boolValue]:NO;

            //_tintMessageBubbles = YES;

            n = (NSNumber *)[prefs objectForKey:@"reverseModeEnabled"];
            _reverseModeEnabled = (n)? [n boolValue]:NO;

            _selectedTheme = [(NSNumber*)[prefs objectForKey:@"selectedTheme"] intValue];
            _selectedNavColor = [(NSNumber*)[prefs objectForKey:@"selectedNavColor"] intValue];
            _selectedKeyboardColor = [(NSNumber*)[prefs objectForKey:@"selectedKeyboardColor"] intValue];
            _statusbarTint = [(NSNumber*)[prefs objectForKey:@"statusbarTint"] intValue];
            _selectedTint = [(NSNumber*)[prefs objectForKey:@"selectedTint"] intValue];


            /* Custom Colors */

            n = (NSNumber *)[prefs objectForKey:@"customNavColorsEnabled"];
            _customNavColorsEnabled = (n)? [n boolValue]:NO;

            n = (NSNumber *)[prefs objectForKey:@"customThemeColorsEnabled"];
            _customThemeColorsEnabled = (n)? [n boolValue]:NO;

            n = (NSNumber *)[prefs objectForKey:@"customTintColorsEnabled"];
            _customTintColorsEnabled = (n)? [n boolValue]:NO;

            n = (NSNumber *)[prefs objectForKey:@"customStatusbarColorsEnabled"];
            _customStatusbarColorsEnabled = (n)? [n boolValue]:NO;

            n = (NSNumber *)[prefs objectForKey:@"customTextColorsEnabled"];
            _customTextColorsEnabled = (n)? [n boolValue]:NO;

            n = (NSNumber *)[prefs objectForKey:@"darkWebEnabled"];
            _darkWebEnabled = (n)? [n boolValue]:NO;

            _customNavBarHex = (NSString*)[prefs objectForKey:@"customNavBarHex"];
            _customThemeHex = (NSString*)[prefs objectForKey:@"customThemeHex"];
            _customTintHex = (NSString*)[prefs objectForKey:@"customTintHex"];
            _customStatusbarHex = (NSString*)[prefs objectForKey:@"customStatusbarHex"];
            _customTextHex = (NSString*)[prefs objectForKey:@"customTextHex"];

            n = (NSNumber *)[prefs objectForKey:@"adaptiveUIEnabled"];
            _adaptiveUIEnabled = (n)? [n boolValue]:NO;
            // _adaptiveUIEnabled = YES;
        }
    }
}

@implementation UIColor (LightAndDark)

- (UIColor *)lighterColor
{
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:MIN(b * 1.3, 1.0)
                               alpha:a];
    return nil;
}

- (UIColor *)darkerColor
{
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b * 0.75
                               alpha:a];
    return nil;
}
@end

static BOOL adaptiveUIEnabled(void) {
    return _adaptiveUIEnabled;
}

static UIColor* generatedAdaptiveColor() {
    NSString* identifier = [UIApplication displayIdentifier];
    UIImage* icon = [UIImage _applicationIconImageForBundleIdentifier:identifier format:0 scale:[UIScreen mainScreen].scale];
    UIColor* color = [UIColor getDominantColor: icon];
    return [[color darkerColor] darkerColor];
}

static BOOL isBetterSettingsInstalled() {
    return [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/rewriteSettings.dylib"];
}


static BOOL isTweakEnabled(void) {
    return _isTweakEnabled;
}

static BOOL alertsEnabled(void) {
    return _alertsEnabled;

}

static BOOL shouldColorDetailText(void) {
    return _colorDetailText;
}

static BOOL cellSeparatorsEnabled(void) {
    return _cellSeparatorsEnabled;
}

static BOOL tintSMSBubbles(void) {
    return _tintSMSBubbles;
}
static BOOL tintMessageBubbles(void) {
    return _tintMessageBubbles;
}
static BOOL reverseModeEnabled(void) {
    return _reverseModeEnabled;
}

//Custom Colors
static BOOL customNavColorEnabled(void) {
    return _customNavColorsEnabled;
}

static BOOL customThemeColorEnabled(void) {
    return _customThemeColorsEnabled;
}

static BOOL customTintColorEnabled(void) {
    return _customTintColorsEnabled;
}

static BOOL customStatusbarColorEnabled(void) {
    return _customStatusbarColorsEnabled;
}

static BOOL customTextColorEnabled(void) {
   return _customTextColorsEnabled;
}

//Installed Checks

static BOOL isMessageCustomiserInstalled() {
     return [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/CustomMessagesColour.dylib"];

}

static BOOL darkenKeyboard(void) {
    return _darkenKeyboard;
}

//Experimental Features
static bool darkWebEnabled(void) {
    return _darkWebEnabled;
}

static BOOL isEnabled = isTweakEnabled();



//Useful Macros

#define colorWithHexString(h,a) [UIColor colorWithHexString:h alpha:a]
#define darkerColorForColor(c) [UIColor darkerColorForColor:c]


//Selections

static int selectedTheme(void) {
    return _selectedTheme;
}

static int selectedNavColor(void) {
    return _selectedNavColor;
}

static int selectedKeyboardColor(void) {
    return _selectedKeyboardColor;
}

static int selectedTint(void) {
    return _selectedTint;
}

static int statusbarTint(void) {
    return _statusbarTint;
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

    NSString* hex = _customNavBarHex;

    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;


    //UIColor *color = colorFromDefaultsWithKey(@"com.gmoran.eclipse", @"customNavBarHex", @"#0A0A0A");
    //return color;
}

static UIColor* hexThemeColor(void) {

    NSString* hex = _customThemeHex;

    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;


    //UIColor *color = colorFromDefaultsWithKey(@"com.gmoran.eclipse", @"customThemeHex", @"#1E1E1E");
    //return color;
}

static UIColor* hexTintColor(void) {

    NSString* hex = _customTintHex;
    hex = [hex stringByReplacingOccurrencesOfString:@" " withString:@""];

    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;


    //UIColor *color = colorFromDefaultsWithKey(@"com.gmoran.eclipse", @"customTintHex", @"#00A3EB");
    //return color;
}

static UIColor* hexStatusbarColor(void) {

    NSString* hex = _customStatusbarHex;
    hex = [hex stringByReplacingOccurrencesOfString:@" " withString:@""];

    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;


    //UIColor *color = colorFromDefaultsWithKey(@"com.gmoran.eclipse", @"customStatusbarHex", @"#E6E6E6");
    //return color;
}

static UIColor* hexTextColor(void) {

    NSString* hex = _customTextHex;

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

    if (adaptiveUIEnabled()) {
        return generatedAdaptiveColor();
    }

    int number = selectedTheme();

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

    if (adaptiveUIEnabled()) {
        return generatedAdaptiveColor();
    }

    int number = selectedTheme();

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

    if (adaptiveUIEnabled()) {
        return [generatedAdaptiveColor() darkerColor];
    }

    int number = selectedNavColor();

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

static UIColor* theTableColor(void) {
    if (reverseModeEnabled()) {
        return selectedViewColor();
    }
    else {
        return selectedTableColor();
    }
}

static UIColor* theViewColor(void) {
    if (reverseModeEnabled()) {
        return selectedTableColor();
    }
    else {
        return selectedViewColor();
    }
}

#define TABLE_COLOR theTableColor() //Used for TableView

#define NAV_COLOR selectedBarColor() //Used for NavBars, Toolbars, TabBars

#define VIEW_COLOR theViewColor() //Used for TableCells, UIViews

//Advanced Settings

static UIColor* keyboardColor(void) {
    int number = selectedKeyboardColor();

    if (adaptiveUIEnabled()) {
        return [generatedAdaptiveColor() darkerColor];
    }

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

static UIColor* selectedStatusbarTintColor(void) {
    int number = statusbarTint();

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

    if (adaptiveUIEnabled()) {
        return [[generatedAdaptiveColor() lighterColor] lighterColor];
    }

    int number = selectedTint();

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


        NSArray* availableColors = @[BABY_BLUE_COLOR, PINK_COLOR, DARK_ORANGE_COLOR, GREEN_COLOR, PURPLE_COLOR, RED_COLOR, YELLOW_COLOR];

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

static UIColor* tableSeparatorColor(void) {
    if (cellSeparatorsEnabled()) {
        return [[selectedTintColor() colorWithAlphaComponent:0.3] darkerColor];
    }
    else {
        return TABLE_COLOR;
    }
}

#define TABLE_SEPARATOR_COLOR tableSeparatorColor()

static void setTintColors() {

    [[UINavigationBar appearance] setTintColor:selectedTintColor()];
    [[UISlider appearance] setMinimumTrackTintColor:selectedTintColor()];
    [[UIToolbar appearance] setTintColor:selectedTintColor()];
    [[UITabBar appearance] setTintColor:selectedTintColor()];

    [[UITextView appearance] setTintColor:selectedTintColor()];
    [[UITextField appearance] setTintColor:selectedTintColor()];

    [[UITableView appearance] setTintColor:selectedTintColor()];

    //Experimental

    [[UIApplication sharedApplication] keyWindow].tintColor = selectedTintColor();

    //[[UIView appearance] setTintColor:selectedTintColor()]; //Buggy?
    // [[UITableView appearance] setTintColor:selectedTintColor()];
    // [[UITableViewCell appearance] setTintColor:selectedTintColor()];
    // [[UIButton appearance] setTintColor:selectedTintColor()];


    [[UIButton appearance] setTintColor:selectedTintColor()];

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

    if ([UIColor color:color isEqualToColor:[UIColor blackColor] withTolerance:0.6] && (![color isEqual:selectedTintColor()])) {
        return YES;
    }
    else {
        return NO;
    }

}

//Uniformity Support


static void darkenUIElements() {


    setTintColors();

    [[UINavigationBar appearance] setBarTintColor:NAV_COLOR];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];

    //[[UISearchBar appearance] setBarTintColor:NAV_COLOR]; //Crashes Dropbox

    //[[UISearchBar appearance] setBarStyle:UIBarStyleBlack];

    [[UIToolbar appearance] setBarTintColor:NAV_COLOR];
    //[[UIToolbar appearance] setBarStyle:UIBarStyleBlack];

    [[UITabBar appearance] setBarTintColor:NAV_COLOR];
    [[UITabBar appearance] setBarStyle:UIBarStyleBlack];

    [[UISwitch appearance] setTintColor:[selectedTintColor() colorWithAlphaComponent:0.6]];
    [[UISwitch appearance] setOnTintColor:[selectedTintColor() colorWithAlphaComponent:0.3]];
    //[[UISwitch appearance] setThumbTintColor:TEXT_COLOR];


}
