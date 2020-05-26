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

static NSDictionary *prefs;
static NSDictionary *uikit_prefs;


static void userDefaultsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    os_log(OS_LOG_DEFAULT, "ECLIPSE RECEIVED USER DEFAULTS CHANGE");
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR(PREFS_CHANGED_NOTIF), NULL, NULL, TRUE);
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

static UIColor* _adaptiveColor;

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
    // if (IS_BETA_BUILD) {
    //     NSDate * currentDate = [NSDate date];
    //     NSDate * otherDate = [[NSDate alloc] initWithString:@"2020-04-30 12:00:00 +0600"];
    //     NSComparisonResult result = [currentDate compare:otherDate];

    //     if (result == NSOrderedAscending) { //Before Expiry
    //         return _isTweakEnabled;
    //     }

    //     return NO;
    // }
    return _isTweakEnabled;
    // return YES;
    
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

    UIColor* eclipseColor = [UIColor colorWithRed:230.0/255.0f green:230.0/255.0f blue:230.0/255.0f alpha:1.0f];
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traits) {
            return traits.userInterfaceStyle == UIUserInterfaceStyleDark ?
                eclipseColor :             // Dark Mode Color
                [UIColor labelColor];  // Light Mode Color
        }];
    }         
    return eclipseColor;
}
static UIColor* selectedBarColor(void) {

    if (adaptiveUIEnabled()) {
        return [_adaptiveColor darkerColor];
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

static UIColor* selectedTableColor(void) {
    if (reverseModeEnabled()) {
        return [UIColor eclipseSelectedViewColor];
    }
    else {
        return [UIColor eclipseSelectedTableColor];
    }
}

static UIColor* selectedViewColor(void) {
    if (reverseModeEnabled()) {
        return [UIColor eclipseSelectedTableColor];
    }
    else {
        return [UIColor eclipseSelectedViewColor];
    }
}

#define TABLE_COLOR selectedTableColor() //Used for TableView
#define VIEW_COLOR selectedViewColor() //Used for TableCells, UIViews
#define NAV_COLOR [UIColor eclipseSelectedNavColor] //Used for NavBars, Toolbars, TabBars
#define TEXT_COLOR textColor()
#define TABLE_SEPARATOR_COLOR tableSeparatorColor()
#define TINT_COLOR selectedTintColor()
#define KEYBOARD_COLOR keyboardColor()

//Advanced Settings

static UIColor* keyboardColor(void) {
    int number = selectedKeyboardColor();

    if (adaptiveUIEnabled()) {
        return [_adaptiveColor darkerColor];
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
        return [[_adaptiveColor lighterColor] lighterColor];
    }
    return [UIColor eclipseSelectedTintColor];
}

static UIColor* tableSeparatorColor(void) {
    if (cellSeparatorsEnabled()) {
        return [[TINT_COLOR colorWithAlphaComponent:0.3] darkerColor];
    }
    else {
        return TABLE_COLOR;
    }
}

static void setTintColors() {

    [[UINavigationBar appearance] setTintColor:TINT_COLOR];
    [[UISlider appearance] setMinimumTrackTintColor:TINT_COLOR];
    [[UIToolbar appearance] setTintColor:TINT_COLOR];
    [[UITabBar appearance] setTintColor:TINT_COLOR];

    [[UITextView appearance] setTintColor:TINT_COLOR];
    [[UITextField appearance] setTintColor:TINT_COLOR];

    [[UITableView appearance] setTintColor:TINT_COLOR];

    //Experimental

    [[UIApplication sharedApplication] keyWindow].tintColor = TINT_COLOR;

    //[[UIView appearance] setTintColor:TINT_COLOR]; //Buggy?
    // [[UITableView appearance] setTintColor:TINT_COLOR];
    // [[UITableViewCell appearance] setTintColor:TINT_COLOR];
    // [[UIButton appearance] setTintColor:TINT_COLOR];


    [[UIButton appearance] setTintColor:TINT_COLOR];

}

//Uniformity Support


static void darkenUIElements() {
    // setTintColors();

    // [[UINavigationBar appearance] setBarTintColor:NAV_COLOR];

    // //[[UISearchBar appearance] setBarTintColor:NAV_COLOR]; //Crashes Dropbox

    // //[[UISearchBar appearance] setBarStyle:UIBarStyleBlack];

    // [[UIToolbar appearance] setBarTintColor:NAV_COLOR];
    // //[[UIToolbar appearance] setBarStyle:UIBarStyleBlack];

    // [[UITabBar appearance] setBarTintColor:NAV_COLOR];

    // [[UISwitch appearance] setTintColor:[TINT_COLOR colorWithAlphaComponent:0.6]];
    // [[UISwitch appearance] setOnTintColor:[TINT_COLOR colorWithAlphaComponent:0.3]];
    // //[[UISwitch appearance] setThumbTintColor:TEXT_COLOR];
}

static void prefsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

    /*
     CFPreferencesAppSynchronize(CFSTR("com.gmoran.eclipse"));

     _isTweakEnabled = !CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR("com.gmoran.eclipse")) ? YES : [(id)CFBridgingRelease(CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR("com.gmoran.eclipse"))) boolValue];
     */

    prefs = [[NSDictionary alloc] initWithContentsOfFile:PREFS_FILE_PATH];
    uikit_prefs = [[NSDictionary alloc] initWithContentsOfFile:UIKIT_PREFS_FILE_PATH];
    //prefs = [[NSUserDefaults standardUserDefaults] persistentDomainForName:PREFS_DOMAIN];

            NSNumber *n = (NSNumber* )[uikit_prefs objectForKey:INTERFACE_PREFS_KEY];
            BOOL sysDarkModeEnabled = (n.intValue == 2);

            n = (NSNumber* )[prefs objectForKey:@"enabled"];
            BOOL eclipseEnabled = (n)? [n boolValue]:NO;

            _isTweakEnabled = sysDarkModeEnabled && eclipseEnabled;

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
            // _adaptiveUIEnabled = (n)? [n boolValue]:NO;
            _adaptiveUIEnabled = NO;
            
            if (_adaptiveUIEnabled) {
                _adaptiveColor = generatedAdaptiveColor();
            }

   
}
