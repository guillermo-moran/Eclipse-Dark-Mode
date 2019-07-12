/*
 _______  _______  _       _________ _______  _______  _______
 (  ____ \(  ____ \( \      \__   __/(  ____ )(  ____ \(  ____ \
 | (    \/| (    \/| (         ) (   | (    )|| (    \/| (    \/
 | (__    | |      | |         | |   | (____)|| (_____ | (__
 |  __)   | |      | |         | |   |  _____)(_____  )|  __)
 | (      | |      | |         | |   | (            ) || (
 | (____/\| (____/\| (____/\___) (___| )      /\____) || (____/\
 (_______/(_______/(_______/\_______/|/       \_______)(_______/

 NIGHT MODE FOR IOS - Interfaces
 COPYRIGHT © 2014 GUILLERMO MORAN
 */

#pragma mark Preferences

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IsiPad UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#define IS_BETA_BUILD YES

#define registerNotification(c, n) CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (c), CFSTR(n), NULL, CFNotificationSuspensionBehaviorCoalesce);

#define PREFS_DOMAIN @"com.gmoran.eclipse"
#define PREFS_CHANGED_NOTIF "com.gmoran.eclipse.prefs-changed"
#define WALLPAPER_CHANGED_NOTIF "com.gmoran.eclipse.wallpaper-changed"
#define QUIT_APPS_NOTIF "com.gmoran.eclipse.quit-apps"

#define PREFS_FILE_PATH @"/var/mobile/Library/Preferences/com.gmoran.eclipse.plist"

#define NOCTISXI_PREFS @"/var/mobile/Library/Preferences/com.laughingquoll.noctisxiprefs.plist"
#define NOCTIS_PREFS @"/var/mobile/Library/Preferences/com.laughingquoll.noctis.plist"
#define NOCTIS_ENABLED_APPS @"/var/mobile/Library/Preferences/com.laughingquoll.noctis.enabledapp.plist"

//#define PREFS_FILE_PATH @"/bootstrap/Library/Preferences/com.gmoran.eclipse.plist"

#define VIEW_EXCLUDE_TAG 199

//#define idIsEqual(id) [[NSBundle mainBundle].bundleIdentifier isEqualToString:id]
#define idIsEqual(id) [[UIApplication displayIdentifier] isEqualToString:id]

//Continue

//Colors



//Table Colors

//#define MIDNIGHT_TABLE_COLOR [UIColor midnightTableColor]
#define MIDNIGHT_TABLE_COLOR [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1.0]

#define NIGHT_TABLE_COLOR [UIColor nightTableColor]

#define GRAPHITE_TABLE_COLOR [UIColor graphiteTableColor]

#define SILVER_TABLE_COLOR [UIColor silverTableColor]

#define CRIMSON_TABLE_COLOR [UIColor crimsonTableColor]

#define ROSE_PINK_TABLE_COLOR [UIColor rosePinkTableColor]

#define GRAPE_TABLE_COLOR [UIColor grapeTableColor]

#define WINE_TABLE_COLOR [UIColor wineTableColor]

#define VIOLET_TABLE_COLOR [UIColor violetTableColor]

#define SKY_TABLE_COLOR [UIColor skyTableColor]

#define LAPIS_TABLE_COLOR [UIColor lapisTableColor]

#define NAVY_TABLE_COLOR [UIColor navyTableColor]

#define DUSK_TABLE_COLOR [UIColor duskTableColor]

#define JUNGLE_TABLE_COLOR [UIColor jungleTableColor]

#define BAMBOO_TABLE_COLOR [UIColor bambooTableColor]

#define SAFFRON_TABLE_COLOR [UIColor saffronTableColor]

#define CITRUS_TABLE_COLOR [UIColor citrusTableColor]

#define AMBER_TABLE_COLOR [UIColor amberTableColor]


//View Colors (Table - 10 or 15)

//#define MIDNIGHT_VIEW_COLOR [UIColor midnightViewColor]
#define MIDNIGHT_VIEW_COLOR [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1.0]

#define NIGHT_VIEW_COLOR [UIColor nightViewColor]

#define GRAPHITE_VIEW_COLOR [UIColor graphiteViewColor]

#define SILVER_VIEW_COLOR [UIColor silverViewColor]

#define CRIMSON_VIEW_COLOR [UIColor crimsonViewColor]

#define ROSE_PINK_VIEW_COLOR [UIColor rosePinkViewColor]

#define GRAPE_VIEW_COLOR [UIColor grapeViewColor]

#define WINE_VIEW_COLOR [UIColor wineViewColor]

#define VIOLET_VIEW_COLOR [UIColor violetViewColor]

#define SKY_VIEW_COLOR [UIColor skyViewColor]

#define LAPIS_VIEW_COLOR [UIColor lapisViewColor]

#define NAVY_VIEW_COLOR [UIColor navyViewColor]

#define DUSK_VIEW_COLOR [UIColor duskViewColor]

#define JUNGLE_VIEW_COLOR [UIColor jungleViewColor]

#define BAMBOO_VIEW_COLOR [UIColor bambooViewColor]

#define SAFFRON_VIEW_COLOR [UIColor saffronViewColor]

#define CITRUS_VIEW_COLOR [UIColor citrusViewColor]

#define AMBER_VIEW_COLOR [UIColor amberViewColor]


//Nav Colors (Table - 30)

//#define MIDNIGHT_BAR_COLOR [UIColor midnightBarColor]
#define MIDNIGHT_BAR_COLOR [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1.0]

#define NIGHT_BAR_COLOR [UIColor nightBarColor]

#define GRAPHITE_BAR_COLOR [UIColor graphiteBarColor]

#define SILVER_BAR_COLOR [UIColor silverBarColor]

#define CRIMSON_BAR_COLOR [UIColor crimsonBarColor]

#define ROSE_PINK_BAR_COLOR [UIColor rosePinkBarColor]

#define GRAPE_BAR_COLOR [UIColor grapeBarColor]

#define WINE_BAR_COLOR [UIColor wineBarColor]

#define VIOLET_BAR_COLOR [UIColor violetBarColor]

#define SKY_BAR_COLOR [UIColor skyBarColor]

#define LAPIS_BAR_COLOR [UIColor lapisBarColor]

#define NAVY_BAR_COLOR [UIColor navyBarColor]

#define DUSK_BAR_COLOR [UIColor duskBarColor]

#define JUNGLE_BAR_COLOR [UIColor jungleBarColor]

#define BAMBOO_BAR_COLOR [UIColor bambooBarColor]

#define SAFFRON_BAR_COLOR [UIColor saffronBarColor]

#define CITRUS_BAR_COLOR [UIColor citrusBarColor]

#define AMBER_BAR_COLOR [UIColor amberBarColor]

/*
 d888888b d888888b d8b   db d888888b
 `~~88~~'   `88'   888o  88 `~~88~~'
    88       88    88V8o 88    88
    88       88    88 V8o88    88
    88      .88.   88  V888    88
    YP    Y888888P VP   V8P    YP
 */

#define BABY_BLUE_COLOR [UIColor eclipseBabyBlueTintColor]

#define WHITE_COLOR [UIColor eclipseWhiteTintColor]

#define PINK_COLOR [UIColor eclipsePinkTintColor]

#define DARK_ORANGE_COLOR [UIColor eclipseDarkOrangeTintColor]

#define GREEN_COLOR [UIColor eclipseGreenTintColor]

#define PURPLE_COLOR [UIColor eclipsePurpleTintColor]

#define RED_COLOR [UIColor eclipseRedTintColor]

#define YELLOW_COLOR [UIColor eclipseYellowTintColor]

#define INDICATOR_COLOR [UIColor whiteColor]


//Continue

#pragma mark SpringBoard

@interface SBUIController : NSObject{} @end

@interface SBAppSwitcherController : NSObject {}
-(void)_quitAppAtIndex:(int)i;
-(void)forceDismissAnimated:(BOOL)arg1;
@end


@interface SBFStaticWallpaperView : NSObject {}
-(UIImage *)colorizeImage:(UIImage *)image withColor:(UIColor *)color;
@end

@interface _UIBackdropView : UIView
@end

@interface _UIBackdropViewSettings : NSObject {}

-(int)style;
-(void)setStyle:(int)arg1 ;

@end

@interface _UIBackdropViewSettingsColored : NSObject {}

-(void)setTintColor;
-(id)init;

@end

@interface _UITextFieldRoundedRectBackgroundViewNeue : UIImageView {

}
-(void)setFillColor:(id)arg1 ;

@end

@interface SBApplication : NSObject
- (UIImage *)imageWithColor:(UIColor *)color;
-(id)_defaultPNGForSceneID:(id)arg1 size:(CGSize)arg2 scale:(float)arg3 launchingOrientation:(int)arg4 orientation:(int*)arg5;
@end

@interface XBApplicationSnapshot : NSObject
- (id)imageForInterfaceOrientation:(int)arg1;
@end

@interface SBMainSwitcherViewController : NSObject {
    NSMutableArray *_displayItems;
}
+ (id)sharedInstance;
- (void)_quitAppRepresentedByDisplayItem:(id)arg1 forReason:(long long)arg2;

@end

@interface SBDisplayItem : NSObject {

    NSString* _displayIdentifier;

}
-(NSString *)displayIdentifier;

@end

//CKUITheme
@interface CKUITheme : NSObject
@end

@interface CKUIThemeDark : CKUITheme 
@property (nonatomic,readonly) UIColor * messageAcknowledgmentRedColor;
@end

@interface CKUIBehavior : NSObject
- (id)theme;
+(id)sharedBehaviors;

@end

@interface CKUIBehaviorPhone : CKUIBehavior
@end

@interface CKUIBehaviorPad : CKUIBehavior
@end

@interface UIApplication(Eclipse)
+(id)displayIdentifier;
-(void)checkRunningApp;
@end

@interface AppStoreFadeInDynamicTypeButton : UIButton
@property (nonatomic, retain) CAGradientLayer *fadeLayer;
@end

@interface IGTabBarButton : UIButton
@end

//
//  ColorPicker.h
//
//  Created by Bailey Seymour on 8/27/14.
//  Copyright (c) 2014 Bailey Seymour. All rights reserved.
//
//Place libcolorpicker.dylib in $THEOS/lib/
//Import this header and link with libcolorpicker.



//UIColor *colorFromDefaultsWithKey(NSString *defaults, NSString *key, NSString *fallback);
