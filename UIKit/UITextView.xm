/*
 d888888b db    db d888888b db    db d888888b d88888b db   d8b   db
 `~~88~~' `8b  d8' `~~88~~' 88    88   `88'   88'     88   I8I   88
    88     `8bd8'     88    Y8    8P    88    88ooooo 88   I8I   88
    88     .dPYb.     88    `8b  d8'    88    88~~~~~ Y8   I8I   88
    88    .8P  Y8.    88     `8bd8'    .88.   88.     `8b d8'8b d8'
    YP    YP    YP    YP       YP    Y888888P Y88888P  `8b8' `8d8'
*/

%hook UITextView

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
    if (isEnabled) {
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

// crashes slack, possibly others
// -(NSAttributedString *)attributedText {
//     NSAttributedString* string = %orig;

//     if (isEnabled) {
//         NSMutableAttributedString* newString = [string mutableCopy];
//         if ([[newString string] length] > 0) {
//             NSRange range = NSMakeRange(0, [[newString string] length]);
        
//             NSDictionary* attributesFromString = [newString attributesAtIndex:0 longestEffectiveRange:nil inRange:range];
//             UIColor* originalColor = [attributesFromString objectForKey:NSForegroundColorAttributeName];

//             if (isTextDarkColor(originalColor)) {
//                 UIColor* newColor = createEclipseDynamicColor(originalColor, TEXT_COLOR);
//                 [newString addAttribute:NSForegroundColorAttributeName value:newColor range:range];
//                 return newString;
//             }
//         }
//     }
//     return string;
// }

// -(void)didMoveToWindow {
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

-(void)setTextColor:(id)color {

    if (isEnabled) {
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
    if (isEnabled) {
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

// %hook MFComposeRecipientTextView

// - (void)layoutSubviews {
//     %orig;

//     if (isEnabled) {
//         [self setBackgroundColor:VIEW_COLOR];
//     }


// }
// %end

// %hook _MFAtomTextView

// - (void)layoutSubviews {
//     %orig;
//     if (isEnabled) {
//        [self setTextColor:TEXT_COLOR];
//     }

// }
// 
// %end
