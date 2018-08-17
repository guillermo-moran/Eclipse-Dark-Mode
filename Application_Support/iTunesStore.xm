%group MobileStoreApp

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
            return TEXT_COLOR;
        }
    }
    return %orig;
}
%end

%end
