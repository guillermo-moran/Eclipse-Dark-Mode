/*
 d888888b db    db d888888b db    db d888888b d88888b db   d8b   db
 `~~88~~' `8b  d8' `~~88~~' 88    88   `88'   88'     88   I8I   88
    88     `8bd8'     88    Y8    8P    88    88ooooo 88   I8I   88
    88     .dPYb.     88    `8b  d8'    88    88~~~~~ Y8   I8I   88
    88    .8P  Y8.    88     `8bd8'    .88.   88.     `8b d8'8b d8'
    YP    YP    YP    YP       YP    Y888888P Y88888P  `8b8' `8d8'
*/

%hook UITextView

-(id)init {
    id  wow = %orig;

    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {

            if (![self.superview isKindOfClass:[UIImageView class]]) {

                id balloon = objc_getClass("CKBalloonTextView");

                if ([self class] == balloon) {
                    return wow;
                }
                else {
                    [self setBackgroundColor:[UIColor clearColor]];
                    [self setTextColor:TEXT_COLOR];
                }
            }
        }
    }
    return wow;
}

-(id)initWithFrame:(CGRect)arg1 {
    id  wow = %orig;

    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {

            if (![self.superview isKindOfClass:[UIImageView class]]) {

                id balloon = objc_getClass("CKBalloonTextView");

                if ([self class] == balloon) {
                    return wow;
                }
                else {
                    [self setBackgroundColor:[UIColor clearColor]];
                    [self setTextColor:TEXT_COLOR];
                }
            }
        }
    }
    return wow;
}

-(id)initWithCoder:(id)arg1 {
    id  wow = %orig;

    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {

            if (![self.superview isKindOfClass:[UIImageView class]]) {

                id balloon = objc_getClass("CKBalloonTextView");

                if ([self class] == balloon) {
                    return wow;
                }
                else {
                    [self setBackgroundColor:[UIColor clearColor]];
                    [self setTextColor:TEXT_COLOR];
                }
            }
        }
    }
    return wow;
}

-(id)initWithFrame:(CGRect)arg1 font:(id)arg2 {

    id  wow = %orig;

    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {

            if (![self.superview isKindOfClass:[UIImageView class]]) {

                id balloon = objc_getClass("CKBalloonTextView");

                if ([self class] == balloon) {
                    return wow;
                }
                else {
                    [self setBackgroundColor:[UIColor clearColor]];
                    [self setTextColor:TEXT_COLOR];
                }
            }
        }
    }
    return wow;
}

-(id)initWithFrame:(CGRect)arg1 textContainer:(id)arg2 {
    id  wow = %orig;

    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {

            if (![self.superview isKindOfClass:[UIImageView class]]) {

                id balloon = objc_getClass("CKBalloonTextView");

                if ([self class] == balloon) {
                    return wow;
                }
                else {
                    [self setBackgroundColor:[UIColor clearColor]];
                    [self setTextColor:TEXT_COLOR];
                }
            }
        }
    }
    return wow;
}





-(id)backgroundColor {
    UIColor* color = %orig;
    if (isEnabled) {
        if (!isLightColor(color)) {

            color = [UIColor clearColor];
        }
    }
    return color;
}

-(id)textColor {
    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {

            if (![self.superview isKindOfClass:[UIImageView class]]) {

                return TEXT_COLOR;

            }
        }
    }
    return %orig;
}
-(void)setFrame:(CGRect)arg1 {
    %orig;

    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {

            if (![self.superview isKindOfClass:[UIImageView class]]) {

                id balloon = objc_getClass("CKBalloonTextView");

                if ([self class] == balloon) {
                    return;
                }
                else {
                    [self setBackgroundColor:[UIColor clearColor]];
                    [self setTextColor:TEXT_COLOR];
                }
            }
        }
    }
}

-(void)setTextColor:(UIColor*)color {
    %orig;

    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {

            if (![self.superview isKindOfClass:[UIImageView class]]) {

                id balloon = objc_getClass("CKBalloonTextView");

                if ([self class] == balloon) {
                    %orig;
                }
                else {
                    [self setBackgroundColor:[UIColor clearColor]];
                    %orig(TEXT_COLOR);
                }
            }
        }
    }
}

//These methods cause hanging

/*
-(void)setFrame:(CGRect)arg1 {
}
 */
/*
-(void)setBounds:(CGRect)arg1 {
}
*/

/*
-(void)layoutSubviews {
}
 */

%end

%hook MFComposeRecipientTextView

- (void)layoutSubviews {
    %orig;

    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
    }


}
%end

%hook _MFAtomTextView

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
       [self setTextColor:TEXT_COLOR];
    }

}

%end
