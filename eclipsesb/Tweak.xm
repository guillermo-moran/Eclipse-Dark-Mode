/*
 _______  _______  _       _________ _______  _______  _______
 (  ____ \(  ____ \( \      \__   __/(  ____ )(  ____ \(  ____ \
 | (    \/| (    \/| (         ) (   | (    )|| (    \/| (    \/
 | (__    | |      | |         | |   | (____)|| (_____ | (__
 |  __)   | |      | |         | |   |  _____)(_____  )|  __)
 | (      | |      | |         | |   | (            ) || (
 | (____/\| (____/\| (____/\___) (___| )      /\____) || (____/\
 (_______/(_______/(_______/\_______/|/       \_______)(_______/

 NIGHT MODE FOR IOS - SpringBoard Hook
 COPYRIGHT © 2014 GUILLERMO MORAN

 */
#include "../Utils/Interfaces.h"
#include "../Utils/UIColor+Eclipse.h"

#import <objc/runtime.h>

#include <notify.h>

#define VIEW_COLOR                      [UIColor eclipseSelectedViewColor]
#define NAV_COLOR                       [UIColor eclipseSelectedNavColor]
#define TEXT_COLOR                      [UIColor eclipseSelectedTextColor]
#define selectedTintColor()             [UIColor eclipseSelectedTintColor]
#define selectedStatusbarTintColor()    [UIColor eclipseSelectedStatusbarTintColor]

static NSDictionary *prefs = nil;

static void prefsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

    if (prefs) {
        prefs = nil;
        [prefs release];

    }

    prefs = [[NSDictionary alloc] initWithContentsOfFile:PREFS_FILE_PATH];

}

//Preferences

static BOOL isTweakEnabled(void) {
    return (prefs) ? [prefs[@"enabled"] boolValue] : NO;
    //return NO;
}

static BOOL alertsEnabled(void) {
    return (prefs) ? [prefs[@"alertsEnabled"] boolValue] : NO;
    //return NO;
}

static BOOL replaceSplashScreens(void) {
    return (prefs) ? [prefs[@"replaceSplashScreens"] boolValue] : NO;
}

static int selectedSplashScreenColor(void) {
    int selectedTheme = [[prefs objectForKey:@"selectedSplashScreenColor"] intValue];
    return selectedTheme;
}

static int selectedDockColor(void) {
    int selectedTheme = [[prefs objectForKey:@"selectedDockColor"] intValue];
    return selectedTheme;
}

static int selectedCCColor() {
    int selectedTheme = [[prefs objectForKey:@"selectedCCColor"] intValue];
    return selectedTheme;
}

static BOOL disableInSB() {
    // return (prefs) ? [prefs[@"disableInSB"] boolValue] : NO;
    return NO;
}

static BOOL colorSBStatusBar() {
    // return (prefs) ? [prefs[@"colorSBStatusBar"] boolValue] : NO;
    return YES;
}


static BOOL darkenWallpapers() {
    return (prefs) ? [prefs[@"darkenWallpapers"] boolValue] : NO;
}

static UIColor* dockColor() {
    int number = selectedDockColor();

    /*
     if (customColorEnabled()) {
     if (hexNavColor()) {
     return hexNavColor();
     }
     }
     */

    if (number == -2) {
        return nil;
    }

    else if (number == -1) {
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
        return nil;
    }
}

static UIColor* controlCenterColor(void) {
    int number = selectedCCColor();

    /*
     if (customColorEnabled()) {
     if (hexNavColor()) {
     return hexNavColor();
     }
     }
     */

    if (number == -2) {
        return nil;
    }

    else if (number == -1) {
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
        return nil;
    }
}

static UIColor* splashScreenColor(void) {
    int number = selectedSplashScreenColor();

    /*
     if (customColorEnabled()) {
     if (hexNavColor()) {
     return hexNavColor();
     }
     }
     */

    if (number == -2) {
        return [UIColor eclipseSelectedViewColor];
    }

    else if (number == -1) {
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
        return [UIColor eclipseSelectedViewColor];
    }
}

static UIColor* createEclipseDynamicColor(UIColor* lightColor, UIColor* darkColor) {
    if (@available(iOS 13.0, *)) {

        UITraitCollection *traitCollection = [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight];
        UIColor* resolvedDefaultColor = lightColor ? [lightColor resolvedColorWithTraitCollection:traitCollection] : [UIColor blackColor];

        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traits) {
            return traits.userInterfaceStyle == UIUserInterfaceStyleDark ?
                darkColor :     // Dark Mode Color
                resolvedDefaultColor;   // Light Mode Color
        }];
    }         
    return lightColor ? lightColor : [UIColor clearColor];
}

//hooks

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

-(id)initWithFrame:(CGRect)arg1 wallpaperImage:(id)arg2 treatWallpaper:(BOOL)arg3 variant:(long long)arg4 {


    if (darkenWallpapers() && !disableInSB() && isTweakEnabled()) {

        return %orig(arg1, [self colorizeImage:arg2 withColor:[UIColor colorWithWhite:0 alpha:0.5]], arg3, arg4);
    }
    else {
        return %orig;
    }

}

%end

// APRIL FOOLS
/*
@interface SBIconImageView : UIView {}
@end


%hook SBIconImageView

-(void)layoutSubviews {
    %orig;

    int r = arc4random_uniform(4);
    if (r == 1) {
        CGFloat radians = atan2f(self.transform.b, self.transform.a);
        CGFloat degrees = radians * (180 / M_PI);
        CGAffineTransform transform = CGAffineTransformMakeRotation((90 + degrees) * M_PI/180);
        self.transform = transform;
    }
}

%end
*/

/*
 d8888b.  .d88b.   .o88b. db   dD
 88  `8D .8P  Y8. d8P  Y8 88 ,8P'
 88   88 88    88 8P      88,8P
 88   88 88    88 8b      88`8b
 88  .8D `8b  d8' Y8b  d8 88 `88.
 Y8888D'  `Y88P'   `Y88P' YP   YD
 */

/*
%hook SBDockIconListView

-(id)initWithModel:(id)arg1 orientation:(int)arg2 viewMap:(id)arg3 {
    id kek = %orig;

    if (isTweakEnabled() && !disableInSB() && (selectedDockColor() > -2)) {
        [self setBackgroundColor:[dockColor() colorWithAlphaComponent:0.5f]];
    }

    return kek;
}

%end
 */

/*
 .o88b.  .o88b.
 d8P  Y8 d8P  Y8
 8P      8P
 8b      8b
 Y8b  d8 Y8b  d8
 `Y88P'  `Y88P'
 */

// %hook SBControlCenterContentContainerView
//
// -(void)layoutSubviews {
//     %orig;
//     if (isTweakEnabled() && !disableInSB() && (selectedCCColor() > -2)) {
//         [self setBackgroundColor:[controlCenterColor() colorWithAlphaComponent:1.0f]];
//     }
// }
//
// %end

/*
 .d8888. d888888b  .d8b.  d888888b db    db .d8888. d8888b.  .d8b.  d8888b.
 88'  YP `~~88~~' d8' `8b `~~88~~' 88    88 88'  YP 88  `8D d8' `8b 88  `8D
 `8bo.      88    88ooo88    88    88    88 `8bo.   88oooY' 88ooo88 88oobY'
 `  Y8b.    88    88~~~88    88    88    88   `Y8b. 88~~~b. 88~~~88 88`8b
 db   8D    88    88   88    88    88b  d88 db   8D 88   8D 88   88 88 `88.
 `8888Y'    YP    YP   YP    YP    ~Y8888P' `8888Y' Y8888P' YP   YP 88   YD
 */
 @interface _UIStatusBar : UIView
 @property (nonatomic, retain) UIColor *foregroundColor;
 @end
 %hook _UIStatusBar

//  -(void)layoutSubviews {
//      %orig;
//      if (isTweakEnabled() && !disableInSB() && colorSBStatusBar()) {
//          self.foregroundColor = selectedStatusbarTintColor();
//          //self.foregroundColor = selectedStatusbarTintColor();
//      }
//  }

-(id)foregroundColor {
    UIColor* color = %orig;

    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    int number = [[prefs objectForKey:@"statusbarTint"] intValue];

    if (number == -1) {
        return color;
    }

    if (isTweakEnabled() && !disableInSB() && colorSBStatusBar() ) {
        color = createEclipseDynamicColor(color, selectedStatusbarTintColor());
    }
    return color;
}

 %end

%hook UIStatusBar_Base

-(id)foregroundColor {
    UIColor* color = %orig;

    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    int number = [[prefs objectForKey:@"statusbarTint"] intValue];

    if (number == -1) {
        return color;
    }
    
    if (isTweakEnabled() && !disableInSB() && colorSBStatusBar() ) {
        color = createEclipseDynamicColor(color, selectedStatusbarTintColor());
    }
    return color;
}

%end

/*
%hook SBCCBrightnessSectionController

-(BOOL)_shouldDarkenBackground {
    return NO;
}

%end

%hook SBCCButtonLikeSectionView

-(void)_updateEffects {
    return;
}

%end
*/

/*
  .d8b.  db      d88888b d8888b. d888888b .d8888.
 d8' `8b 88      88'     88  `8D `~~88~~' 88'  YP
 88ooo88 88      88ooooo 88oobY'    88    `8bo.
 88~~~88 88      88~~~~~ 88`8b      88      `Y8b.
 88   88 88booo. 88.     88 `88.    88    db   8D
 YP   YP Y88888P Y88888P 88   YD    YP    `8888Y'
 */

/*
%hook UILabel

-(void)setTextColor:(UIColor*)color {
    if (!disableInSB() && isTweakEnabled()) {

        if (([self tag] != VIEW_EXCLUDE_TAG) && !([[self textColor] isEqual:[UIColor clearColor]])) {

            %orig(TEXT_COLOR); //Fix Later
            return;
        }

    }
    %orig;
}

%end
*/

%hook _UITextFieldRoundedRectBackgroundViewNeue

-(id)fillColor {
    if (!disableInSB() && isTweakEnabled()) {
        return [UIColor clearColor];
    }
    return %orig;
}

-(id)initWithFrame:(CGRect)arg1 {
    id ok = %orig;
    if (!disableInSB() && isTweakEnabled()) {
        [self setFillColor:[UIColor clearColor]];
    }
    return ok;
}
%end

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



    if (!disableInSB() && isTweakEnabled() && [self class] == %c(_UIBackdropViewSettingsUltraLight)) {

        color = [NAV_COLOR colorWithAlphaComponent:0.9];
        [_backdrop setAlpha:0.9];
    }

    /*
    if (!disableInSB() && darkenKeyboard() && [_backdrop isKindOfClass:objc_getClass("UIKBBackdropView")]) {
        color = [keyboardColor() colorWithAlphaComponent:0.9];
        [_backdrop setAlpha:0.9];
    }
    */

    return color;
}

%end

%group EclipseAlerts //Eclipse Alert Group (Noctis Support)

%hook _UIAlertControllerBlendingSeparatorView

-(void)layoutSubviews {
    %orig;
    if (!disableInSB() && isTweakEnabled()) {
        [self setBackgroundColor:selectedTintColor()];
    }
}

%end

//Action Sheets

//Action Sheets
@interface _UIActivityGroupActivityCellTitleLabel : UILabel
@end

%hook _UIActivityGroupActivityCellTitleLabel

-(void)layoutSubviews {
    %orig;

    if (!disableInSB() && isTweakEnabled()) {
        self.textColor = selectedTintColor();
    }
}

%end

@interface UIActionSheetiOSDismissActionView : UIView
@end

%hook UIActionSheetiOSDismissActionView
-(void)layoutSubviews {
    %orig;

    if (!disableInSB() && isTweakEnabled()) {

        UIButton *button = MSHookIvar<UIButton *>(self, "_dismissButton");
        button.tintColor = selectedTintColor();
    }
}
%end

@interface _UIInterfaceActionGroupHeaderScrollView  : UIView
@end

%hook _UIInterfaceActionGroupHeaderScrollView
-(void)layoutSubviews {
    %orig;

    if (!disableInSB() && isTweakEnabled()) {
        UIView *contentView = MSHookIvar<UIView *>(self, "_contentView");

        for (UILabel *subview in contentView.subviews) {
            if ([subview isKindOfClass:[UILabel class]]) {
                subview.textColor = selectedTintColor();
            }
        }
    }
}
%end

/*
@interface _UIInterfaceActionCustomViewRepresentationView  : UIView
@end

%hook _UIInterfaceActionCustomViewRepresentationView

-(void)layoutSubviews {
    %orig;
    if (!disableInSB() && isTweakEnabled()) {
        UIView *actionView = MSHookIvar<UIView *>(self, "_actionContentView");
        UILabel *label = MSHookIvar<UILabel *>(actionView, "_label");
        label.tintColor = selectedTintColor();
    }
}

-(void)setHighlighted:(BOOL)arg1{
    %orig;
    if (!disableInSB() && isTweakEnabled()) {

        UIView *actionView = MSHookIvar<UIView *>(self, "_actionContentView");
        UILabel *label = MSHookIvar<UILabel *>(actionView, "_label");
        label.tintColor = selectedTintColor();
    }
}

%end
*/

//Alerts

%hook _UIAlertControllerView

- (void)layoutSubviews {

    %orig;
    if (!disableInSB() && isTweakEnabled()) {

        for (UIView* view in [self subviews]) {
            view.tag = VIEW_EXCLUDE_TAG;
        }


        UILabel* _titleLabel = MSHookIvar<id>(self, "_titleLabel");
        [_titleLabel setTextColor:selectedTintColor()];

        UILabel* _detailMessageLabel = MSHookIvar<id>(self, "_detailMessageLabel");
        [_detailMessageLabel setTextColor:TEXT_COLOR];

        UILabel* _messageLabel = MSHookIvar<id>(self, "_messageLabel");
        [_messageLabel setTextColor:TEXT_COLOR];

    }
}

%end

%hook _UIAlertControllerShadowedScrollView

-(void)layoutSubviews {
    %orig;
    if (!disableInSB() && isTweakEnabled()) {
        [self setBackgroundColor:NAV_COLOR];
    }
}

%end

%hook _UIAlertControllerCollectionViewCell

-(void)layoutSubviews {
    %orig;
    if (!disableInSB() && isTweakEnabled()) {
        [self setBackgroundColor:NAV_COLOR];
    }
}

%end

%hook _UIAlertControllerActionView

- (void)layoutSubviews {
    %orig;
    if (!disableInSB() && isTweakEnabled()) {
        [self setBackgroundColor:NAV_COLOR];

        UILabel* _label = MSHookIvar<id>(self, "_label");
        [_label setTextColor:selectedTintColor()];
    }
}


%end

%end //End Group


//Splash Screen

/*
%subclass EclipseApplicationSnapshot : XBApplicationSnapshot

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

- (id)imageForInterfaceOrientation:(int)arg1 {
    return [self imageWithColor:VIEW_COLOR];
}

%end
*/


%hook SBUIController



+(id)zoomViewForDeviceApplicationSceneHandle:(id)arg1 displayConfiguration:(id)arg2 interfaceOrientation:(long long)arg3 snapshot:(id)arg4 snapshotSize:(CGSize)arg5 statusBarDescriptor:(id)arg6 decodeImage:(BOOL)arg7 {

    id view = %orig;

    if (isTweakEnabled() && replaceSplashScreens()) {
        UIView* newView = [[UIView alloc] init];
        newView.backgroundColor = splashScreenColor();
        newView.frame = [view frame];
        return newView;
    }
    return view;

}




%end

// %hook SpringBoard
//
// UIWindow* SBBrowserWindow = nil;
//
// -(void)applicationDidFinishLaunching:(BOOL)beh {
//     %orig;
//     if (SBBrowserWindow == nil) {
//         SBBrowserWindow = [[[UIWindow alloc] initWithFrame:CGRectMake(0, 50, 320, 430)] retain];
//         SBBrowserWindow.windowLevel = 66666;
//     }
//
//     [SBBrowserWindow setAlpha:1];
//     [SBBrowserWindow setHidden:NO];
//     [SBBrowserWindow setBackgroundColor:[UIColor redColor]];
// }
//
// %end
//DRM

//#import "NSString+Fr0st.h"

/*

OBJC_EXTERN CFStringRef MGCopyAnswer(CFStringRef key) WEAK_IMPORT_ATTRIBUTE;

%hook SpringBoard

%new
-(void)safeMode {
    system("killall -SEGV SpringBoard");
}

-(void)applicationDidFinishLaunching:(BOOL)beh {

    %orig;

    if (IS_BETA_BUILD) {


        CFStringRef UDNumber = MGCopyAnswer(CFSTR("UniqueDeviceID"));
        NSString* UDID = (NSString*)UDNumber;
        //NSString* UDID = @"kek";

        NSString *url =[NSString stringWithFormat:@"http://gmoran.me/api/check.php?UDID=%@", UDID];

        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];

        //NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSString obfuscate:url withKey:UDID],UDID]]];
        [req setHTTPMethod:@"GET"];

        NSHTTPURLResponse* urlResponse = nil;

        NSData *responseData = [NSURLConnection sendSynchronousRequest:req returningResponse:&urlResponse error:nil];

        NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        CFRelease(UDNumber);

        if ([result isEqualToString:@"Not Licensed"]) {

            if (IS_BETA_BUILD) {

                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"Eclipse 3 Beta"
                                      message:@"Beta access is restricted to customers"
                                      delegate:nil
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil];
                [alert show];
                [alert release];

                [NSTimer scheduledTimerWithTimeInterval:5.0
                                                 target:self
                                               selector:@selector(safeMode)
                                               userInfo:nil
                                                repeats:NO];

            }

        }
    }

}

%end

*/

static BOOL noctisInstalled = [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/NoctisXI.dylib"];

%ctor {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];


    prefsChanged(NULL, NULL, NULL, NULL, NULL); // initialize prefs
                // register to receive changed notifications
    registerNotification(prefsChanged, PREFS_CHANGED_NOTIF);
                //registerNotification(wallpaperChanged, WALLPAPER_CHANGED_NOTIF);
                //registerNotification(quitAppsRequest, QUIT_APPS_NOTIF);
                //%init(UIApp);

    %init(_ungrouped);

    if (alertsEnabled()) {
        %init(EclipseAlerts); //Noctis Support
    }

    [pool release];
}


/*
%ctor {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    prefsChanged(NULL, NULL, NULL, NULL, NULL); // initialize prefs
    // register to receive changed notifications
    registerNotification(prefsChanged, PREFS_CHANGED_NOTIF);
    //registerNotification(wallpaperChanged, WALLPAPER_CHANGED_NOTIF);
    //registerNotification(quitAppsRequest, QUIT_APPS_NOTIF);
    //%init(UIApp);

    %init(_ungrouped);

    if (!noctisInstalled) {
        %init(EclipseAlerts); //Noctis Support
    }

    [pool release];
}
*/
