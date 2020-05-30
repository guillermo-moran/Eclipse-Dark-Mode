/*
 db    db d888888b db       .d8b.  d8888b. d88888b db
 88    88   `88'   88      d8' `8b 88  `8D 88'     88
 88    88    88    88      88ooo88 88oooY' 88ooooo 88
 88    88    88    88      88~~~88 88~~~b. 88~~~~~ 88
 88b  d88   .88.   88booo. 88   88 88   8D 88.     88booo.
 ~Y8888P' Y888888P Y88888P YP   YP Y8888P' Y88888P Y88888P
*/



@interface UILabel(Eclipse)
-(void)override;
@end

%hook UILabel

%new
-(BOOL)isSuperviewEclipsed {
    // if (isEnabled) {
    //     return [self.superview isEclipsed];
    // }
    // return NO;
    return YES;
}

-(void)drawRect:(CGRect)arg1 {
    %orig;

    if (isEnabled) {
        if ([self isSuperviewEclipsed]) {

            UIColor* originalTextColor = self.textColor;
            if (isTextDarkColor(originalTextColor)) {
                UIColor* newColor = createEclipseDynamicColor(originalTextColor, TEXT_COLOR);
                [self setBackgroundColor:[UIColor clearColor]];
                [self setTextColor:newColor];
            }
        }
    }

}

// -(void)setFrame:(CGRect)arg1 {
//     %orig;

//     if (isEnabled) {
//         if ([self isSuperviewEclipsed]) {

//             UIColor* originalTextColor = self.textColor;
//             if (isTextDarkColor(originalTextColor)) {
//                 UIColor* newColor = createEclipseDynamicColor(originalTextColor, TEXT_COLOR);
//                 [self setBackgroundColor:[UIColor clearColor]];
//                 [self setTextColor:newColor];
//             }
//         }
//     }
// }

-(void)layoutSubviews {
    %orig;

    if (isEnabled) {
        if ([self isSuperviewEclipsed]) {

            UIColor* originalTextColor = self.textColor;
            if (isTextDarkColor(originalTextColor)) {
                UIColor* newColor = createEclipseDynamicColor(originalTextColor, TEXT_COLOR);
                [self setBackgroundColor:[UIColor clearColor]];
                [self setTextColor:newColor];
            }
        }
    }

}

-(void)setTextColor:(id)color {

    if (isEnabled) {
        // if (self.tag == 52961101) {
        //     color = TEXT_COLOR;
        //     %orig(color);
        //     return;
        // }
        if ([self isSuperviewEclipsed]) {

            UIColor* originalTextColor = color;
            if (isTextDarkColor(originalTextColor)) {
                UIColor* newColor = createEclipseDynamicColor(originalTextColor, TEXT_COLOR);
                [self setBackgroundColor:[UIColor clearColor]];
                %orig(newColor);
            }
        }
    }
    %orig(color);
}

%end
