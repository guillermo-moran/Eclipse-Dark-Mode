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

#define TABLE_LABEL objc_getClass("UITableViewLabel")

%new
-(BOOL)isSuperviewEclipsed {
    // if (isEnabled) {
    //     return [self.superview isEclipsed];
    // }
    // return NO;
    return YES;
}

// -(void)layoutSubviews {
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

-(void)setAttributedText:(NSAttributedString *)string {
    if (isEnabled && ![self isKindOfClass: TABLE_LABEL]) {
        NSMutableAttributedString* newString = [string mutableCopy];
        if ([[newString string] length] > 0) {
            NSRange range = NSMakeRange(0, [[newString string] length]);

            NSDictionary* attributesFromString = [newString attributesAtIndex:0 longestEffectiveRange:nil inRange:range];
            UIColor* originalColor = [attributesFromString objectForKey:NSForegroundColorAttributeName];

            if (isTextDarkColor(originalColor)) {
                UIColor* newColor = createEclipseDynamicColor(originalColor, TEXT_COLOR);
                [newString addAttribute:NSForegroundColorAttributeName value:newColor range:range];
                %orig(newString);
                return;
            }
        }
    }
    %orig;
}

-(NSAttributedString *)attributedText {
    NSAttributedString* string = %orig;

    if (isEnabled && ![self isKindOfClass: TABLE_LABEL]) {
        NSMutableAttributedString* newString = [string mutableCopy];
        if ([[newString string] length] > 0) {
            NSRange range = NSMakeRange(0, [[newString string] length]);
        
            NSDictionary* attributesFromString = [newString attributesAtIndex:0 longestEffectiveRange:nil inRange:range];
            UIColor* originalColor = [attributesFromString objectForKey:NSForegroundColorAttributeName];

            if (isTextDarkColor(originalColor)) {
                UIColor* newColor = createEclipseDynamicColor(originalColor, TEXT_COLOR);
                [newString addAttribute:NSForegroundColorAttributeName value:newColor range:range];
                return newString;
            }
        }
    }
    return string;
}

-(void)didMoveToWindow {
    %orig;

    if (isEnabled && ![self isKindOfClass: TABLE_LABEL]) {
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

    if (isEnabled && ![self isKindOfClass: TABLE_LABEL]) {
        if ([self isSuperviewEclipsed]) {
            UIColor* originalTextColor = color;
            if (isTextDarkColor(originalTextColor)) {
                UIColor* newColor = createEclipseDynamicColor(originalTextColor, TEXT_COLOR);
                [self setBackgroundColor:[UIColor clearColor]];
                %orig(newColor);
                return;
            }
        }
    }
    %orig(color);
}

-(UIColor*)textColor {
    UIColor* orig = %orig;
    if (isEnabled && ![self isKindOfClass: TABLE_LABEL]) {
        if ([self isSuperviewEclipsed]) {
            if (isTextDarkColor(orig)) {
                UIColor* newColor = createEclipseDynamicColor(orig, TEXT_COLOR);
                [self setBackgroundColor:[UIColor clearColor]];
                return newColor;
            }
        }
    }
    return orig;
}

%end
