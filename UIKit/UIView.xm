/*
 db    db d888888b db    db d888888b d88888b db   d8b   db
 88    88   `88'   88    88   `88'   88'     88   I8I   88
 88    88    88    Y8    8P    88    88ooooo 88   I8I   88
 88    88    88    `8b  d8'    88    88~~~~~ Y8   I8I   88
 88b  d88   .88.    `8bd8'    .88.   88.     `8b d8'8b d8'
 ~Y8888P' Y888888P    YP    Y888888P Y88888P  `8b8' `8d8'
*/

%hook UIKBBackdropView

-(id)initWithFrame:(CGRect)arg1 style:(long long)arg2 primaryBackdrop:(BOOL)arg3 {
    id kek = %orig;

    if (isEnabled) {
        [self setTag:VIEW_EXCLUDE_TAG];

        for (UIView* view in [self subviews]) {
            [view setTag:VIEW_EXCLUDE_TAG];
        }
    }

    return kek;
}

%end

@interface UIView(Eclipse)
-(void)override;
@end


%hook UIView

//HBFPBackgroundView == FlagPaint

#define FLAGPAINT objc_getClass("UITextField")
#define SC_HEADER objc_getClass("SCBottomBorderedView") //snapchat fix (prevent bans)
#define SC_GRADIENT objc_getClass("SCGradientView")

%new
-(void)override {

    if (isEnabled) {

        if (isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]] && ([self class] != FLAGPAINT) && (self.tag != VIEW_EXCLUDE_TAG)) {

            [self setBackgroundColor:VIEW_COLOR];
        }

        //Snapchat fix (prevent ban/connection error)
        if ([self class] == SC_HEADER) {
            [self setBackgroundColor:NAV_COLOR];
        }
        if ([self class] == SC_GRADIENT) {
            [self setAlpha:0.0];
        }
    }
}

// %new
// -(BOOL)

-(id)backgroundColor {
    id color = %orig;

    if (isEnabled) {

        if (isLightColor(color) && ![color isEqual:[UIColor clearColor]] && ([self class] != FLAGPAINT) && (self.tag != VIEW_EXCLUDE_TAG)) {

            return VIEW_COLOR;
        }
    }

    return %orig;

}

/* //Crashed venmo. Possibly others.
-(id)init {
    @try {
        id ok = %orig;
        [self override];
        return ok;
    }
    @catch (NSException* e) {
        NSLog(@"Error");
    }
    @finally {
        return %orig;
    }
}
*/

-(id)initWithFrame:(CGRect)arg1 {
    id ok = %orig;

    @try {
        [self override];
    }
    @catch (NSException* e) {
        NSLog(@"Error");
    }

    return ok;
}

-(id)initWithSize:(CGSize)arg1 {
    id ok = %orig;

    @try {
        [self override];
    }
    @catch (NSException* e) {
        NSLog(@"Error");
    }

    return ok;
}

-(id)initWithCoder:(CGRect)arg1 {
    id ok = %orig;

    @try {
        [self override];
    }
    @catch (NSException* e) {
        NSLog(@"Error");
    }

    return ok;
}


//#define KB_BG_COLOR [UIColor colorWithRed:1.0f green:0.87f blue:0.87f alpha:0.87] //Fuck You Apple. (Some apps don't use whiteColor)



//if (origColorSpace == tableBGColorSpace || origColorSpace == whiteColorSpace || origColorSpace == cellWhiteColorSpace) {

-(void)setBackgroundColor:(UIColor*)color {

    if (isEnabled) {
        if (isLightColor(color) && ![color isEqual:[UIColor clearColor]] && ([self class] != FLAGPAINT) && (self.tag != VIEW_EXCLUDE_TAG)) {

            color = VIEW_COLOR;

        }
    }

    %orig(color);
}



-(void)layoutSubviews {

    %orig;

    if (isEnabled && !isClockApp) {


        if (!isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]] && (self.tag != VIEW_EXCLUDE_TAG)) {

            for (UILabel* v in [self subviews]){

                if ([(UILabel*)v respondsToSelector:@selector(setTextColor:)] && [(UILabel*)v respondsToSelector:@selector(textColor)]) {

                    if (isTextDarkColor([(UILabel*)v textColor])) {
                        [(UILabel*)v setTag:52961101];
                        [(UILabel*)v setBackgroundColor:[UIColor clearColor]];
                        [(UILabel*)v setTextColor: TEXT_COLOR];
                    }
                }
            }
        }
    }
}

/*

 //Comment to fix crashing on Viber, possibly others.

-(void)didAddSubview:(id)v {
    %orig;

    if (isEnabled) {

        if (!isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]] && (self.tag != VIEW_EXCLUDE_TAG)) {

            if ([v respondsToSelector:@selector(setTextColor:)] && [v respondsToSelector:@selector(textColor)]) {

                if (isTextDarkColor([v textColor])) {
                    [v setTag:52961101];
                    [v setBackgroundColor:[UIColor clearColor]];
                    [v setTextColor: TEXT_COLOR];
                }
            }
        }
    }
}

-(void)addSubview:(id)v {
    %orig;

    if (isEnabled) {

        if (!isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]] && (self.tag != VIEW_EXCLUDE_TAG)) {

            if ([v respondsToSelector:@selector(setTextColor:)] && [v respondsToSelector:@selector(textColor)]) {

                if (isTextDarkColor([v textColor])) {
                    [v setTag:52961101];
                    [v setBackgroundColor:[UIColor clearColor]];
                    [v setTextColor: TEXT_COLOR];
                }
            }
        }
    }

}

 */

%end
