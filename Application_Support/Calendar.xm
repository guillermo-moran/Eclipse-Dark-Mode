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
