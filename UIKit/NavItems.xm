/*
 d8b   db  .d8b.  db    db      d888888b d888888b d88888b .88b  d88. .d8888.
 888o  88 d8' `8b 88    88        `88'   `~~88~~' 88'     88'YbdP`88 88'  YP
 88V8o 88 88ooo88 Y8    8P         88       88    88ooooo 88  88  88 `8bo.
 88 V8o88 88~~~88 `8b  d8'         88       88    88~~~~~ 88  88  88   `Y8b.
 88  V888 88   88  `8bd8'         .88.      88    88.     88  88  88 db   8D
 VP   V8P YP   YP    YP         Y888888P    YP    Y88888P YP  YP  YP `8888Y'
*/

%hook _UIBarBackground

-(void)layoutSubviews {
    %orig;
    if (isEnabled && ![[self backgroundColor] isEqual:[UIColor clearColor]]) {
        [self setBackgroundColor:NAV_COLOR];
        [self setHidden: NO];
        if (selectedNavColor() == -1) {
            id _backgroundEffectView = MSHookIvar<id>(self, "_backgroundEffectView");
            [_backgroundEffectView setHidden:YES];
        }
    }
}

%end

%hook UINavigationBar

-(void)layoutSubviews {
    %orig;
    if (isEnabled && ![[self backgroundColor] isEqual:[UIColor clearColor]]) {

        @try {
            [self setBarTintColor:NAV_COLOR];
            [self setBackgroundColor:NAV_COLOR];
            //[self setBarStyle:UIBarStyleBlack];
            [self setTitleTextAttributes: @{NSForegroundColorAttributeName:TEXT_COLOR}];

        }
        @catch (NSException * e) {
            //Nah
        }
        @finally {
            //NSLog(@"Eclipse 3: An error occured while attempting to color the Nav Bar. This application may not support this feature.");
        }


    }
}

-(void)drawRect:(CGRect)arg1 {
    %orig;
    if (isEnabled && ![[self backgroundColor] isEqual:[UIColor clearColor]]) {

        @try {
            [self setBarTintColor:NAV_COLOR];

        }
        @catch (NSException * e) {
            //Nah
        }
        @finally {
            //NSLog(@"Eclipse 3: An error occured while attempting to color the Nav Bar. This application may not support this feature.");
        }
    }
}

-(void)setBounds:(CGRect)arg1 {
    %orig;
    if (isEnabled && ![[self backgroundColor] isEqual:[UIColor clearColor]]) {

        @try {
            [self setBarTintColor:NAV_COLOR];

        }
        @catch (NSException * e) {
            //Nah
        }
        @finally {
            //NSLog(@"Eclipse 3: An error occured while attempting to color the Nav Bar. This application may not support this feature.");
        }
    }
}

-(void)setBarTintColor:(UIColor*)color {
    if (isEnabled && ![[self backgroundColor] isEqual:[UIColor clearColor]]) {
        color = NAV_COLOR;
        if (translucentNavbarEnabled()) {
            [self setAlpha:0.9];
        }
    }
    %orig(color);
}

%end

//Tab Bar Stuff

%hook UITabBar

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        self.backgroundColor = NAV_COLOR; //Fuck you, Whatsapp.

    }
}

-(void)setBarTintColor:(id)arg1 {
    if (isEnabled) {
        self.backgroundColor = NAV_COLOR;
        %orig(NAV_COLOR);
        return;
    }
    %orig;
}

%end

%hook SKUITabBarBackgroundView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIView* eclipseBarView = [[UIView alloc] initWithFrame:[self frame]];
        [eclipseBarView setBackgroundColor:NAV_COLOR];
        [self addSubview:eclipseBarView];
        [eclipseBarView release];

    }
}


%end


%hook UIToolbar


-(void)setBarStyle:(int)arg1 {
    if (isEnabled && !(IsiPad)) {
        [self setBarTintColor:NAV_COLOR];
        return;
    }
    %orig;
}


-(void)setBarTintColor:(id)arg1 {
    if (isEnabled && !(IsiPad)) {
        %orig(NAV_COLOR);
        return;
    }
    %orig;
}

%end
