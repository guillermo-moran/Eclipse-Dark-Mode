/*
 d88888b  .d8b.   .o88b. d88888b d8888b. db   dD
 88'     d8' `8b d8P  Y8 88'     88  `8D 88 ,8P'
 88ooo   88ooo88 8P      88ooooo 88oooY' 88,8P
 88~~~   88~~~88 8b      88~~~~~ 88~~~b. 88`8b
 88      88   88 Y8b  d8 88.     88   8D 88 `88.
 YP      YP   YP  `Y88P' Y88888P Y8888P' YP   YD
 */


%group Facebook

// // %hook FBRichTextComponentView

// // -(void)layoutSubviews {
// // 	%orig;
// // 	[RED_COLOR set];
// // 	[self setColor: RED_COLOR];
// // }

// // -(void)setColor:(UIColor*)color {
// // 	[RED_COLOR set];
// // 	%orig(RED_COLOR);
// // }

// // -(UIColor*)color {
// // 	return RED_COLOR;
// // }

// // %end

// %hook NSString

// -(CGSize)drawAtPoint:(CGPoint)arg1 forWidth:(double)arg2 withFont:(id)arg3 lineBreakMode:(long long)arg4 {

// 	// if (isPaidCydiaPackage) {
// 	//   [selectedTintColor() set];
// 	// }
// 	//else {
// 	if (isEnabled) {
// 		[TEXT_COLOR set];
// 	}
// 	//}
// 	return %orig;
// }

// %end

%hook FDSTetraPressStateScaleComponentView

-(id)init {
    id x = %orig;
    if (isEnabled) {
        UIImage* image = [self image];
        applyInvertFilter((UIView*)image);
    }
    return x;
}

%end

%hook CKButtonWithExtendedTapArea

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setAlpha: 0.5];
    }
}

%end

%hook RCTView

-(id)init {
    id x = %orig;
    if (isEnabled) {
        applyInvertFilter((UIView*)self);
    }
    return x;
}

%end

%hook FBUIExpandableButton

-(id)init {
    id x = %orig;
    if (isEnabled) {
        applyInvertFilter((UIView*)self);
    }
    return x;
}

%end

%hook FBRichTextView

-(void)setAttributedString:(NSAttributedString *)string {
    if (isEnabled) {
        NSMutableAttributedString* newString = [string mutableCopy];
        if ([[newString string] length] > 0) {
            NSRange range = NSMakeRange(0, [[newString string] length]);
            [newString removeAttribute: NSForegroundColorAttributeName range: range];

            NSDictionary* attributesFromString = [newString attributesAtIndex:0 longestEffectiveRange:nil inRange:range];
            UIColor* originalColor = [attributesFromString objectForKey:NSForegroundColorAttributeName];

            if (true) {
                UIColor* newColor = createEclipseDynamicColor(originalColor, TEXT_COLOR);
                [newString addAttribute:NSForegroundColorAttributeName value:newColor range:range];
                %orig(newString);
                return;
            }
        }
    }
    %orig;
}

-(NSAttributedString *)attributedString {
    NSAttributedString* string = %orig;

    if (isEnabled) {
        NSMutableAttributedString* newString = [string mutableCopy];
        if ([[newString string] length] > 0) {
            NSRange range = NSMakeRange(0, [[newString string] length]);
            [newString removeAttribute: NSForegroundColorAttributeName range: range];
        
            NSDictionary* attributesFromString = [newString attributesAtIndex:0 longestEffectiveRange:nil inRange:range];
            UIColor* originalColor = [attributesFromString objectForKey:NSForegroundColorAttributeName];

            if (true) {
                UIColor* newColor = createEclipseDynamicColor(originalColor, TEXT_COLOR);
                [newString addAttribute:NSForegroundColorAttributeName value:newColor range:range];
                return newString;
            }
        }
    }
    return string;
}

-(void)setFrame:(CGRect*)frame {
	%orig;
    if (isEnabled) {
        NSMutableAttributedString* newString = [[self attributedString] mutableCopy];

        if ([[newString string] length] > 0) {
            NSRange range = NSMakeRange(0, [[newString string] length]);
        
            NSDictionary* attributesFromString = [newString attributesAtIndex:0 longestEffectiveRange:nil inRange:range];
            UIColor* originalColor = [attributesFromString objectForKey:NSForegroundColorAttributeName];

            if (true) {
                UIColor* newColor = createEclipseDynamicColor(originalColor, TEXT_COLOR);
                [newString addAttribute:NSForegroundColorAttributeName value:newColor range:range];
                [self setAttributedString: newString];
            }
        }
	    

        NSAttributedString* attrString = MSHookIvar<NSAttributedString*>(self, "_attributedString");
        NSMutableAttributedString* newStringIvar = [attrString mutableCopy];

        if ([[newStringIvar string] length] > 0) {
            NSRange range = NSMakeRange(0, [[newStringIvar string] length]);
        
            NSDictionary* attributesFromString = [newStringIvar attributesAtIndex:0 longestEffectiveRange:nil inRange:range];
            UIColor* originalColor = [attributesFromString objectForKey:NSForegroundColorAttributeName];

            if (true) {
                UIColor* newColor = createEclipseDynamicColor(originalColor, TEXT_COLOR);
                [newStringIvar addAttribute:NSForegroundColorAttributeName value:newColor range:range];
                attrString = newStringIvar;
            }
        }

        [self setColor: TEXT_COLOR];
    }
}

-(void)layoutSubviews {
	%orig;
    if (isEnabled) {
        NSMutableAttributedString* newString = [[self attributedString] mutableCopy];

        if ([[newString string] length] > 0) {
            NSRange range = NSMakeRange(0, [[newString string] length]);
        
            NSDictionary* attributesFromString = [newString attributesAtIndex:0 longestEffectiveRange:nil inRange:range];
            UIColor* originalColor = [attributesFromString objectForKey:NSForegroundColorAttributeName];

            if (true) {
                UIColor* newColor = createEclipseDynamicColor(originalColor, TEXT_COLOR);
                [newString addAttribute:NSForegroundColorAttributeName value:newColor range:range];
                [self setAttributedString: newString];
            }
        }
	    

        NSAttributedString* attrString = MSHookIvar<NSAttributedString*>(self, "_attributedString");
        NSMutableAttributedString* newStringIvar = [attrString mutableCopy];

        if ([[newStringIvar string] length] > 0) {
            NSRange range = NSMakeRange(0, [[newStringIvar string] length]);
        
            NSDictionary* attributesFromString = [newStringIvar attributesAtIndex:0 longestEffectiveRange:nil inRange:range];
            UIColor* originalColor = [attributesFromString objectForKey:NSForegroundColorAttributeName];

            if (isTextDarkColor(originalColor)) {
                UIColor* newColor = createEclipseDynamicColor(originalColor, TEXT_COLOR);
                [newStringIvar addAttribute:NSForegroundColorAttributeName value:newColor range:range];
                attrString = newStringIvar;
            }
        }

        [self setColor: TEXT_COLOR];
    }
}


-(void)setColor:(UIColor*)color {
    if (isEnabled) {
        %orig(TEXT_COLOR);
    }
	%orig;
}

-(UIColor*)color {
	if (isEnabled) {
        return TEXT_COLOR;
    }
    return %orig;
}

%end

%end
