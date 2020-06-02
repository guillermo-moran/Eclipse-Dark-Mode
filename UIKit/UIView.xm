/*
 db    db d888888b db    db d888888b d88888b db   d8b   db
 88    88   `88'   88    88   `88'   88'     88   I8I   88
 88    88    88    Y8    8P    88    88ooooo 88   I8I   88
 88    88    88    `8b  d8'    88    88~~~~~ Y8   I8I   88
 88b  d88   .88.    `8bd8'    .88.   88.     `8b d8'8b d8'
 ~Y8888P' Y888888P    YP    Y888888P Y88888P  `8b8' `8d8'
*/

%hook UIKBBackdropView

-(id)initWithFrame:(CGRect)arg1 style:(long long)arg2 primaryBackdrop:(BOOL)arg3 {
    id kek = %orig;

    if (isEnabled) {
        [self setTag:VIEW_EXCLUDE_TAG];

        for (UIView* view in [self subviews]) {
            [view setTag:VIEW_EXCLUDE_TAG];
        }
    }

    return kek;
}

%end

@interface UIView(Eclipse)
-(void)override;

@property (nonatomic) BOOL eclipsed;

@end

%hook UIViewController

// -(void)viewDidLoad {
//     %orig;
//     UIView* window = self.view;

//     if (!ranKeyWindowForTheFirstTime) {
//         NSNumber *n = (NSNumber* )[uikit_prefs objectForKey:INTERFACE_PREFS_KEY];
//         BOOL sysDarkModeEnabled = (n.intValue == 2);

//         if (isEnabled) { // isEnabled means that both system dark mode and Eclipse are enabled in Settings
            
//             BOOL isAppStillLight = (ACTIVE_APPLICATION_USER_INTERFACE_STYLE == 1);
//             BOOL isAppUnsupported = (ACTIVE_APPLICATION_USER_INTERFACE_STYLE == 0);
//             BOOL isAppDark = (ACTIVE_APPLICATION_USER_INTERFACE_STYLE == 2);

//             if (isAppDark) {
//                 windowNeedsInterfaceOverride = NO; // Prevent override on apps that already support dark mode natively
//                 // ranKeyWindowForTheFirstTime = YES;
//             }
            
//             if ((isAppStillLight || isAppUnsupported) && windowNeedsInterfaceOverride && sysDarkModeEnabled ) { // App does not support dark mode
//                 os_log(OS_LOG_DEFAULT, "ECLIPSE: Overriding user interface style to dark");
//                 [window setOverrideUserInterfaceStyle: USER_INTERFACE_DARK]; // Force dark mode on all views through the key window
//                  [window _setOverrideUserInterfaceStyle: USER_INTERFACE_DARK];
//                 window.overrideUserInterfaceStyle = USER_INTERFACE_DARK;
//                 didNeedInterfaceStyleOverride = YES;
//                 // ranKeyWindowForTheFirstTime = YES;
//             }

//             os_log(OS_LOG_DEFAULT, "ECLIPSE: Current user interface style for app: %ld", ACTIVE_APPLICATION_USER_INTERFACE_STYLE);
//         }
//     }
//     // NSString* executableName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleExecutable"];
//     // os_log(OS_LOG_DEFAULT, "ECLIPSE: Executable name is %@", executableName);


//     // [window layoutSubviews]; // Probably not necessary

//     // return window;
// }


-(long long)overrideUserInterfaceStyle {
    NSNumber *n = (NSNumber* )[uikit_prefs objectForKey:INTERFACE_PREFS_KEY];
    BOOL sysDarkModeEnabled = (n.intValue == 2);
    BOOL appForceDarkIsEnabledInSettings = [[prefs objectForKey:[@"ForcedApps-" stringByAppendingString:[UIApplication displayIdentifier]]] boolValue];
    
    if (isEnabled && appForceDarkIsEnabledInSettings && sysDarkModeEnabled) {
        return USER_INTERFACE_DARK;
    }
    return %orig;
}

%end


%hook UIView
%property (nonatomic) BOOL eclipsed;

//HBFPBackgroundView == FlagPaint

#define FLAGPAINT objc_getClass("UITextField")
#define SC_HEADER objc_getClass("SCBottomBorderedView") //snapchat fix (prevent bans)
#define SC_GRADIENT objc_getClass("SCGradientView")
#define CARET objc_getClass("UITextSelectionView")

static BOOL didOverrideColor = NO;

%new
-(void)override {
    if (isEnabled) {

        if (isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]] && ([self class] != CARET) && (self.tag != VIEW_EXCLUDE_TAG)) {
            UIColor* newColor = createEclipseDynamicColor(self.backgroundColor, VIEW_COLOR);
            [self setBackgroundColor: newColor];
            [self setEclipsed: YES];
        }
    }
}

-(void)layoutSubviews {
    %orig;
     if (isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]] && ([self class] != CARET) && (self.tag != VIEW_EXCLUDE_TAG)) {
            UIColor* newColor = createEclipseDynamicColor(self.backgroundColor, VIEW_COLOR);
            [self setBackgroundColor: newColor];
            [self setEclipsed: YES];
        }
}

-(void)setBackgroundColor:(UIColor*)color {
    if (isLightColor(color) && ![color isEqual:[UIColor clearColor]] && ([self class] != CARET) && (self.tag != VIEW_EXCLUDE_TAG)) {
        UIColor* eclipseColor = createEclipseDynamicColor(color, VIEW_COLOR);
        %orig(eclipseColor);
        [self setEclipsed: YES];
        return;
    }
    %orig;

    
}

-(id)backgroundColor {
    id color = %orig;

    if (isLightColor(color) && ![color isEqual:[UIColor clearColor]] && ([self class] != CARET) && (self.tag != VIEW_EXCLUDE_TAG)) {
        UIColor* eclipseColor = createEclipseDynamicColor(color, VIEW_COLOR);
        [self setEclipsed: YES];
        return eclipseColor;
    }
    return color;
}

// //Crashed venmo. Possibly others.
// -(id)init {
//     @try {
//         id ok = %orig;
//         [self override];
//         return ok;
//     }
//     @catch (NSException* e) {
//         NSLog(@"Error");
//         return %orig;
//     }
//     @finally {
//         return %orig;
//     }
// }

-(id)initWithFrame:(CGRect)arg1 {
    id ok = %orig;

    @try {
        [self override];
    }
    @catch (NSException* e) {
        NSLog(@"Error");
    }

    return ok;
}

-(id)initWithSize:(CGSize)arg1 {
    id ok = %orig;

    @try {
        [self override];
    }
    @catch (NSException* e) {
        NSLog(@"Error");
    }

    return ok;
}

-(id)initWithCoder:(CGRect)arg1 {
    id ok = %orig;

    @try {
        [self override];
    }
    @catch (NSException* e) {
        NSLog(@"Error");
    }

    return ok;
}

-(id)_initWithLayer:(id)arg1 {
id ok = %orig;

    @try {
        [self override];
    }
    @catch (NSException* e) {
        NSLog(@"Error");
    }

    return ok;
}

-(id)_initWithMaskImage:(id)arg1 {
    id ok = %orig;

    @try {
        [self override];
    }
    @catch (NSException* e) {
        NSLog(@"Error");
    }

    return ok;
}

-(void)setFrame:(CGRect)arg1 {
    %orig;
    if (isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]] && ([self class] != CARET) && (self.tag != VIEW_EXCLUDE_TAG)) {
        [self setBackgroundColor:createEclipseDynamicColor(self.backgroundColor, VIEW_COLOR)];
        [self setEclipsed: YES];
    }

}




// //#define KB_BG_COLOR [UIColor colorWithRed:1.0f green:0.87f blue:0.87f alpha:0.87] //Fuck You Apple. (Some apps don't use whiteColor)



// //if (origColorSpace == tableBGColorSpace || origColorSpace == whiteColorSpace || origColorSpace == cellWhiteColorSpace) {



// -(void)layoutSubviews {
//     %orig;
//     if (isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]] && ([self class] != FLAGPAINT) && (self.tag != VIEW_EXCLUDE_TAG)) {
//         [self setBackgroundColor: createEclipseDynamicColor(self.backgroundColor, RED_COLOR)];
//     }
// }

// // -(void)layoutSubviews {

// //     os_log(OS_LOG_DEFAULT, "ECLIPSE: INTERFACE CHANGE CALLED LAYOUTSUBVIEWS");


// //     %orig;

// //     if (isEnabled && !isClockApp) {


// //         if (!isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]] && (self.tag != VIEW_EXCLUDE_TAG)) {

// //             for (UILabel* v in [self subviews]){

// //                 if ([(UILabel*)v respondsToSelector:@selector(setTextColor:)] && [(UILabel*)v respondsToSelector:@selector(textColor)]) {

// //                     if (isTextDarkColor([(UILabel*)v textColor])) {
// //                         [(UILabel*)v setTag:52961101];
// //                         [(UILabel*)v setBackgroundColor:[UIColor clearColor]];
// //                         [(UILabel*)v setTextColor: TEXT_COLOR];
// //                     }
// //                 }
// //             }
// //         }
// //     }
// // }

// /*

//  //Comment to fix crashing on Viber, possibly others.

// -(void)didAddSubview:(id)v {
//     %orig;

//     if (isEnabled) {

//         if (!isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]] && (self.tag != VIEW_EXCLUDE_TAG)) {

//             if ([v respondsToSelector:@selector(setTextColor:)] && [v respondsToSelector:@selector(textColor)]) {

//                 if (isTextDarkColor([v textColor])) {
//                     [v setTag:52961101];
//                     [v setBackgroundColor:[UIColor clearColor]];
//                     [v setTextColor: TEXT_COLOR];
//                 }
//             }
//         }
//     }
// }

// -(void)addSubview:(id)v {
//     %orig;

//     if (isEnabled) {

//         if (!isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]] && (self.tag != VIEW_EXCLUDE_TAG)) {

//             if ([v respondsToSelector:@selector(setTextColor:)] && [v respondsToSelector:@selector(textColor)]) {

//                 if (isTextDarkColor([v textColor])) {
//                     [v setTag:52961101];
//                     [v setBackgroundColor:[UIColor clearColor]];
//                     [v setTextColor: TEXT_COLOR];
//                 }
//             }
//         }
//     }

// }

//  */

%end
