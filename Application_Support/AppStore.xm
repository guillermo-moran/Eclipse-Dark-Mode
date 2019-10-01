%group AppstoreApp

%hook FadeInDynamicTypeButton

- (void)layoutSubviews {
    %orig;
    if (SYSTEM_VERSION_LESS_THAN(@"12.2")) {
        // shit me, why cant we use 'self' within a hooked swift class. what a nightmare
        AppStoreFadeInDynamicTypeButton *button = (AppStoreFadeInDynamicTypeButton *)self;

        // looks like noctis sets the background color of the button itself, so we can use that if its set
        // for eclipse, well need to travers to the cell view and get its background color
        UIColor *backColor = button.backgroundColor ? : button.superview.superview.superview.backgroundColor;

        // just in case insanity happens, and neither the cell or the button have a color then prevent a crash
        if (backColor) {

            // apply the color to the gradient with a left facing fade, (possibly needs to change for R to L languages?)
            button.fadeLayer.colors = @[(id)[backColor colorWithAlphaComponent:0].CGColor, (id)backColor.CGColor];
        }
    } 
}

%end


%hook AppStoreSearchHeaderView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        id effectView = MSHookIvar<id>(self, "effectView");
        id searchBar = MSHookIvar<id>(self, "searchBar");

        CGRect searchBarFrame = [searchBar frame];
        CGRect newEffectViewFrame = CGRectMake(searchBarFrame.origin.x + 10.0, searchBarFrame.origin.y, searchBarFrame.size.width - 20.0, searchBarFrame.size.height);

        [effectView setLegacyBackgroundTintColor:BABY_BLUE_COLOR];
        [effectView setFrame:newEffectViewFrame];

    }
}

%end

/*
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
            return [TEXT_COLOR colorWithAlphaComponent:0.4];
        }
    }
    return %orig;
}
%end
*/
/*
%hook SKUIStackedBarCell

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:NAV_COLOR];

    }
}
%end


%hook SKUITableViewCell

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
    }

}

%end

%hook SKUITextBoxView

-(id)initWithFrame:(CGRect)arg1 {
    id frame = %orig;
    if (isEnabled) {

        applyInvertFilter((UIView*)self);

        //id _colorScheme = MSHookIvar<id>(self, "_colorScheme");
        //id colorScheme = [[[%c(SKUIColorScheme) alloc] init] autorelease];
        //[colorScheme setPrimaryTextColor:TEXT_COLOR];
        //[colorScheme setSecondaryTextColor:selectedTintColor()];

        //_colorScheme = colorScheme;

        //[self setColorScheme:_colorScheme];

    }
    return frame;
}

- (void)setColorScheme:(id)arg1 {

    //id _colorScheme = MSHookIvar<id>(self, "_colorScheme");
    id colorScheme = [[%c(SKUIColorScheme) alloc] initWithCoder:nil];
    [colorScheme setBackgroundColor:TEXT_COLOR];
    [colorScheme setSecondaryTextColor:selectedTintColor()];

    //_colorScheme = colorScheme;

    HBLogInfo(@"COLOR SCHEME: %@",colorScheme);
    %orig(colorScheme);
}

-(UIColor*)backgroundColor {
    if (isEnabled) {
        return [UIColor clearColor];
    }
    return %orig;
}

-(void)setBackgroundColor:(UIColor*)color {
    if (isEnabled) {
        %orig([UIColor clearColor]);
        return;
    }
    %orig;

}


%end

%hook SKUIStyledButton

- (id)_textColor {
    if (isEnabled) {
        return RED_COLOR;
    }
    return %orig;
}

- (BOOL)_usesTintColor {
    if (isEnabled) {
        return YES;
    }
    return %orig;
}


%end

%hook SKUIAttributedStringView

-(id)init {
    id string = %orig;
    if (isEnabled) {


        //[self setTextColor:TEXT_COLOR];
        applyInvertFilter((UIView*)self);

    }
    return string;
}

-(UIColor*)backgroundColor {
    if (isEnabled) {
        return [UIColor clearColor];
    }
    return %orig;
}

-(void)setBackgroundColor:(UIColor*)color {
    if (isEnabled) {
        %orig([UIColor clearColor]);
        return;
    }
    %orig;

}

%end

%hook SKUIProductPageHeaderLabel

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setTextColor:TEXT_COLOR];
    }
}

%end
*/
%end
