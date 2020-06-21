static UIColor* createEclipseDynamicColor(UIColor* lightColor, UIColor* darkColor) {
    if (@available(iOS 13.0, *)) {

        UITraitCollection *traitCollection = [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight];
        UIColor* resolvedDefaultColor = lightColor ? [lightColor resolvedColorWithTraitCollection:traitCollection] : [UIColor clearColor];
        UIColor* resolvedDarkColor = lightColor ? [darkColor colorWithAlphaComponent:CGColorGetAlpha(resolvedDefaultColor.CGColor)] : darkColor;

        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traits) {
            return traits.userInterfaceStyle == UIUserInterfaceStyleDark ?
                [resolvedDarkColor colorWithAlphaComponent: 1.0] :     // Dark Mode Color
                resolvedDefaultColor;   // Light Mode Color
        }];
    }         
    return lightColor ? lightColor : [UIColor clearColor];
}

static BOOL isLightColor(UIColor* color) {

    UITraitCollection *traitCollection = [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight];
    UIColor* resolvedLightColor = color ? [color resolvedColorWithTraitCollection:traitCollection] : [UIColor clearColor];
    
    //BOOL is = NO;

    CGFloat white = 0;
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 0;
    [resolvedLightColor getWhite:&white alpha:&alpha];
    [resolvedLightColor getRed:&red green:&green blue:&blue alpha:&alpha];

    //return ((white >= 0.5) && (red >= 0.5) && (green >= 0.5)  && (blue >= 0.5) && (alpha >= 0.4) && (![color isEqual:TINT_COLOR]));
    // if ([resolvedLightColor isEqual: [UIColor clearColor]]) {
    //     return NO;
    // }
    if ((red <= 0.5) || (green <= 0.5) || (blue <= 0.5)) {
        return NO;
    }
    if (white >= 0.5 && alpha > 0.7) {
        return YES;
    }
    return NO;
}

static BOOL isDarkColor(UIColor* color) {

    UITraitCollection *traitCollection = [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight];
    UIColor* resolvedLightColor = color ? [color resolvedColorWithTraitCollection:traitCollection] : [UIColor clearColor];

    // NSArray *blacklist = [NSArray arrayWithObjects:
    //     @"com.apple.mobilemail",
    //     @"com.apple.mobiletimer",
    //     @"com.saurik.Cydia",
    //     @"com.apple.mobileslideshow",
    //     @"com.burbn.instagram"
    // ];

    // // BOOL isInBlacklist = [blacklist containsObject:[UIApplication displayIdentifier]];
    // BOOL isInBlacklist = NO;

    if (idIsEqual(@"com.saurik.Cydia")) {
        return NO;
    }
    
    CGFloat white = 0;
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 0;

    [resolvedLightColor getWhite:&white alpha:&alpha];
    [resolvedLightColor getRed:&red green:&green blue:&blue alpha:&alpha];

    // //return ((white >= 0.5) && (red >= 0.5) && (green >= 0.5)  && (blue >= 0.5) && (alpha >= 0.4) && (![color isEqual:TINT_COLOR]));

    // if ((white < 0.3) && (red < 0.5) && (green < 0.5) && (blue < 0.5) && (alpha > 0.9)) {
    //     return YES;
    // }  
    // return NO;

    const CGFloat *componentColors = CGColorGetComponents(resolvedLightColor.CGColor);

    CGFloat colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
    if ((red >= 0.5) || (green >= 0.5) || (blue >= 0.5)) {
        return false;
    }
    if (colorBrightness < 0.5 && (alpha > 0.9) && ![resolvedLightColor isEqual:[UIColor clearColor]] && color)
    {
        return true;
    }
    else
    {
        return false;
    }
}

static BOOL shouldEclipse(UIColor* color) {

    if (isLightColor(color)) {
        return true;
    }
    else if (isDarkColor(color)) {
        return true;
    }
    return false;
}

static BOOL isTextDarkColor(UIColor* color) {

    UITraitCollection *traitCollection = [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight];
    UIColor* resolvedLightColor = color ? [color resolvedColorWithTraitCollection:traitCollection] : [UIColor labelColor];

    UITraitCollection *traitCollectionDark = [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    UIColor* resolvedDarkColor = color ? [color resolvedColorWithTraitCollection:traitCollection] : [UIColor labelColor];

    CGFloat white = 0;
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    [resolvedLightColor getWhite:&white alpha:nil];
    [resolvedLightColor getRed:&red green:&green blue:&blue alpha:nil];

    BOOL isDark = ((white <= 0.5) && (red <= 0.5) && (green <= 0.5)  && (blue <= 0.5) && (![resolvedDarkColor isEqual:TINT_COLOR]) && (![resolvedLightColor isEqual:TINT_COLOR]));

    if ([UIColor color:resolvedLightColor isEqualToColor:[UIColor blackColor] withTolerance:0.6] && isDark) {
        return YES;
    }
    else {
        return NO;
    }
}