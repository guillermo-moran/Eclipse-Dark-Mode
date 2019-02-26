/*
 d888888b db    db d888888b d88888b d888888b d88888b db      d8888b.
 `~~88~~' `8b  d8' `~~88~~' 88'       `88'   88'     88      88  `8D
    88     `8bd8'     88    88ooo      88    88ooooo 88      88   88
    88     .dPYb.     88    88~~~      88    88~~~~~ 88      88   88
    88    .8P  Y8.    88    88        .88.   88.     88booo. 88  .8D
    YP    YP    YP    YP    YP      Y888888P Y88888P Y88888P Y8888D'
*/

@interface _UITextFieldContentView

@property (nonatomic, copy, readwrite) UIColor* backgroundColor;

@end

%hook _UITextFieldContentView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        self.backgroundColor = [UIColor clearColor];
    }
}


%end

%hook _MFSearchAtomTextView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
    }
}

%end

%hook UISearchBar

-(void)drawRect:(CGRect)rect {
    %orig;
    if (isEnabled) {
        [self setBarTintColor:NAV_COLOR];
    }
}

%end

%hook UITextField

%new
-(void)override {
    if (isEnabled) {

        //[self setKeyboardAppearance:UIKeyboardAppearanceDark];
        if (!isLightColor(self.backgroundColor)) {

            //[self setBackgroundColor:[VIEW_COLOR colorWithAlphaComponent:0.4]];

        }

        [self setTextColor:TEXT_COLOR];
        //self.textColor = TEXT_COLOR;
    }
}
/*
 - (void)drawPlaceholderInRect:(CGRect)rect {
 [DARKER_ORANGE_COLOR setFill];
 [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:12]];
 }
 */

//-(void)setKeyboardAppearance:(int)arg1 ;

-(id)initWithFrame:(CGRect)arg1 {
    id christmasPresents = %orig;
    [self override];
    return christmasPresents;
}


 -(id)initWithCoder:(id)arg1 {
     id christmasPresents = %orig;
     [self override];
     return christmasPresents;
 }

-(id)init {
    id christmasPresents = %orig;
    [self override];
    return christmasPresents;
}
/*
 -(void)setKeyboardAppearance:(int)arg1 {
 if (isEnabled) {
 %orig(UIKeyboardAppearanceDark);
 return;
 }
 %orig;
 }
 */

-(void)setTextColor:(id)arg1 {
    if (isEnabled) {
        if (![self isKindOfClass:%c(SBSearchField)]) {

            if (!isLightColor(self.backgroundColor)) {
                //[self setBackgroundColor:[VIEW_COLOR colorWithAlphaComponent:0.4]];
            }

            %orig(TEXT_COLOR);
            return;
        }
    }
    %orig;
}


-(id)textColor {
    UIColor* color = %orig;
    if (isEnabled) {

        if (![self isKindOfClass:%c(SBSearchField)]) {

            if (!isLightColor(self.backgroundColor)) {

                //[self setBackgroundColor:[VIEW_COLOR colorWithAlphaComponent:0.4]];
            }
            color = TEXT_COLOR;

        }
    }
    return color;
}


-(void)drawRect:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        if (![self isKindOfClass:%c(SBSearchField)]) {

            if (!isLightColor(self.backgroundColor)) {
                [self setBackgroundColor:[VIEW_COLOR colorWithAlphaComponent:0.4]];
            }


            [self setTextColor:TEXT_COLOR];
            //self.textColor = TEXT_COLOR;

        }
    }
}


%end
