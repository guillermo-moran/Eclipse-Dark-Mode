/*
 db    db d888888b  .o88b.  .d88b.  db       .d88b.  d8888b.
 88    88   `88'   d8P  Y8 .8P  Y8. 88      .8P  Y8. 88  `8D
 88    88    88    8P      88    88 88      88    88 88oobY'
 88    88    88    8b      88    88 88      88    88 88`8b
 88b  d88   .88.   Y8b  d8 `8b  d8' 88booo. `8b  d8' 88 `88.
 ~Y8888P' Y888888P  `Y88P'  `Y88P'  Y88888P  `Y88P'  88   YD
*/

// AUTO REPLACE COLOR BETA

%group AutoReplaceColor

%hook UIColor
//such hacky

+(id)blackColor {
    if (isEnabled) {
        return TEXT_COLOR;
    }
    return %orig;
}

+(id)colorWithRed:(double)red green:(double)green blue:(double)blue alpha:(double)alpha {

    if (isEnabled) {
        if ((red == 0.0) && (green == 0.0) && (blue == 0.0) && (alpha < 0.7)) {
            return TEXT_COLOR;
        }
    }
    return %orig;
}

+(id)colorWithWhite:(float)arg1 alpha:(float)arg2 {

    id color = %orig;

    if (isEnabled) {
        if ((arg1 < .5)) {
            return [TEXT_COLOR colorWithAlphaComponent:0.4];
        }
    }
    return %orig;
}
%end

%hook UIImageView

-(void)layoutSubviews {
    %orig;

    if (isEnabled) {
        if ([UIColor color:[UIColor getDominantColor:self.image] isEqualToColor:[UIColor whiteColor] withTolerance:0.5]) {
            //if ([UIColor color:[self.image averageColor] isEqualToColor:[UIColor whiteColor] withTolerance:0.9]) {

            //self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            //[self setTintColor:VIEW_COLOR];

            [self setAlpha:0.3];
        }

    }

}
%end
%end

// REPLACE SYSTEM COLORS

%group SystemUIColors

%hook UIColor

static BOOL bazziInstalled = [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/Bazzi.dylib"] || [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/Bazzi2.dylib"];

+(UIColor*)systemGreenColor {
    if (isEnabled && (selectedTintColor() != WHITE_COLOR) && !bazziInstalled) {
        return selectedTintColor();
    }
    return %orig;
}

+(UIColor*)systemBlueColor {
    if (isEnabled) {
        return selectedTintColor();
    }
    return %orig;
}

%end

%end
