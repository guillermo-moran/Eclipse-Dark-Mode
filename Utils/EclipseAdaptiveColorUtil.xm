//Invert Colors Filter
//By Andy Wiik


static UIColor* createEclipseDynamicColor(UIColor* lightColor, UIColor* darkColor) {
    if (@available(iOS 13.0, *)) {

        UITraitCollection *traitCollection = [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight];
        UIColor* resolvedDefaultColor = lightColor ? [lightColor resolvedColorWithTraitCollection:traitCollection] : [UIColor clearColor];

        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traits) {
            return traits.userInterfaceStyle == UIUserInterfaceStyleDark ?
                darkColor :     // Dark Mode Color
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

    if ((red <= 0.5) || (green <= 0.5) || (blue <= 0.5)) {
        return NO;
    }
    if (white >= 0.5 && alpha > 0.7) {
        return YES;
    }
    return NO;
}

static BOOL isTextDarkColor(UIColor* color) {

    UITraitCollection *traitCollection = [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight];
    UIColor* resolvedLightColor = color ? [color resolvedColorWithTraitCollection:traitCollection] : [UIColor labelColor];

    /*
    CGFloat white = 0;
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    [color getWhite:&white alpha:nil];
    [color getRed:&red green:&green blue:&blue alpha:nil];

   return ((white <= 0.5) && (red <= 0.5) && (green <= 0.5)  && (blue <= 0.5) && (![color isEqual:TINT_COLOR]));
     */

    if ([UIColor color:resolvedLightColor isEqualToColor:[UIColor blackColor] withTolerance:0.6] && (![color isEqual:TINT_COLOR])) {
        return YES;
    }
    else {
        return NO;
    }

}