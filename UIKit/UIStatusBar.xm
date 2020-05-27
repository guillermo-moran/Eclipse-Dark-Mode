/*
 .d8888. d888888b  .d8b.  d888888b db    db .d8888. d8888b.  .d8b.  d8888b.
 88'  YP `~~88~~' d8' `8b `~~88~~' 88    88 88'  YP 88  `8D d8' `8b 88  `8D
 `8bo.      88    88ooo88    88    88    88 `8bo.   88oooY' 88ooo88 88oobY'
 `  Y8b.    88    88~~~88    88    88    88   `Y8b. 88~~~b. 88~~~88 88`8b
 db   8D    88    88   88    88    88b  d88 db   8D 88   8D 88   88 88 `88.
 `8888Y'    YP    YP   YP    YP    ~Y8888P' `8888Y' Y8888P' YP   YP 88   YD
 */

%hook _UIStatusBar

@interface _UIStatusBar : UIView
@property (nonatomic, retain) UIColor *foregroundColor;
@end

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        if (isBetterSettingsInstalled() && idIsEqual(@"com.apple.Preferences")) {
            //do nothing
        }
        else {
            UIColor* originalColor = self.foregroundColor;
            self.foregroundColor = createEclipseDynamicColor(originalColor, selectedStatusbarTintColor());

        }
        //self.foregroundColor = selectedStatusbarTintColor();
    }
}

%end

%hook UIStatusBar

-(id)foregroundColor {
    UIColor* color = %orig;
    if (isEnabled) {
        return createEclipseDynamicColor(color, selectedStatusbarTintColor());
    }
    return color;
}
%end

%hook UIStatusBarNewUIStyleAttributes
- (id)initWithRequest:(id)arg1 backgroundColor:(id)arg2 foregroundColor:(id)arg3 hasBusyBackground:(bool)arg4 {
    if (isEnabled) {
        UIColor* backgroundColor = createEclipseDynamicColor(arg2, VIEW_COLOR);
        UIColor* foregroundColor = createEclipseDynamicColor(arg3, selectedStatusbarTintColor());
        return %orig(arg1, backgroundColor, foregroundColor, arg4);
    }
    return %orig(arg1, arg2, arg3, arg4);
}
%end
