/*
 d8b   db  .d8b.  db    db      d888888b d888888b d88888b .88b  d88. .d8888.
 888o  88 d8' `8b 88    88        `88'   `~~88~~' 88'     88'YbdP`88 88'  YP
 88V8o 88 88ooo88 Y8    8P         88       88    88ooooo 88  88  88 `8bo.
 88 V8o88 88~~~88 `8b  d8'         88       88    88~~~~~ 88  88  88   `Y8b.
 88  V888 88   88  `8bd8'         .88.      88    88.     88  88  88 db   8D
 VP   V8P YP   YP    YP         Y888888P    YP    Y88888P YP  YP  YP `8888Y'
*/

// %hook _UIVisualEffectBackdropView

// -(void)layoutSubviews {
//     %orig;
//     if (isEnabled) {
//         // [self setAlpha: 1.0];
//         UIColor* originalColor = (UIColor*)[self backgroundColor];
//         UIColor* newColor = createEclipseDynamicColor(originalColor, [[[NAV_COLOR lighterColor] lighterColor] lighterColor]);
//         [self setBackgroundColor: newColor];
//     }
// }

// %end

// %hook _UINavigationBarContentView

// -(void)layoutSubviews {
//     %orig;
//     if (isEnabled) {
//         UIColor* originalBarColor = (UIColor*)[self backgroundColor];
//         UIColor* newBarColor = createEclipseDynamicColor(originalBarColor, NAV_COLOR);
//         [self setBackgroundColor: newBarColor];
//     }
// }

// %end

%hook _UIBarBackground

// static UIView* barBgView;

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {

        UIColor* originalBarColor = (UIColor*)[self backgroundColor];
        UIColor* newBarColor = createEclipseDynamicColor(originalBarColor, NAV_COLOR);

        // if (!barBgView) {
        //     // [barBgView removeFromSuperview];
        //     // [barBgView release];
        //     // barBgView = nil;
        //     barBgView = [[UIView alloc] initWithFrame:[self frame]];
        //     [barBgView setBackgroundColor: createEclipseDynamicColor([UIColor clearColor], NAV_COLOR)];
        //     [self addSubview: barBgView];
        // }
        

        [self setBackgroundColor:newBarColor];
        // [self setHidden: NO];
        // if (selectedNavColor() == -1) {
        //     id _backgroundEffectView = MSHookIvar<id>(self, "_backgroundEffectView");
        //     [_backgroundEffectView setHidden:YES];
        // }
        id effectView1 = MSHookIvar<id>(self, "_effectView1");
        id effectView2 = MSHookIvar<id>(self, "_effectView2");
        BOOL isDark = ACTIVE_APPLICATION_USER_INTERFACE_STYLE == USER_INTERFACE_DARK;
        [effectView1 setHidden: isDark];
        [effectView2 setHidden: isDark];
    }
}

%end

%hook UINavigationBar

-(void)layoutSubviews {
    %orig;
    if (isEnabled && ![[self backgroundColor] isEqual:[UIColor clearColor]] && ![[self barTintColor] isEqual:[UIColor clearColor]]) {
        // UIColor* originalBarTintColor = [self barTintColor];
        // UIColor* newBarTintColor = createEclipseDynamicColor(originalBarTintColor, NAV_COLOR);
        // [self setBarTintColor: newBarTintColor];

        UIColor* originalBarBgColor = [self backgroundColor];
        UIColor* newBarBgColor = createEclipseDynamicColor(originalBarBgColor, NAV_COLOR);
        [self setBackgroundColor: newBarBgColor];
    }
}

// -(void)drawRect:(CGRect)arg1 {
//     %orig;
//     if (isEnabled && ![[self backgroundColor] isEqual:[UIColor clearColor]]) {

//         @try {
//             [self setBarTintColor:NAV_COLOR];

//         }
//         @catch (NSException * e) {
//             //Nah
//         }
//         @finally {
//             //NSLog(@"Eclipse 3: An error occured while attempting to color the Nav Bar. This application may not support this feature.");
//         }
//     }
// }

// -(void)setBounds:(CGRect)arg1 {
//     %orig;
//     if (isEnabled && ![[self backgroundColor] isEqual:[UIColor clearColor]]) {

//         @try {
//             [self setBarTintColor:NAV_COLOR];

//         }
//         @catch (NSException * e) {
//             //Nah
//         }
//         @finally {
//             //NSLog(@"Eclipse 3: An error occured while attempting to color the Nav Bar. This application may not support this feature.");
//         }
//     }
// }

// -(void)setBarTintColor:(UIColor*)color {
//     if (isEnabled && ![[self backgroundColor] isEqual:[UIColor clearColor]]) {
//         color = NAV_COLOR;
//     }
//     %orig(color);
// }

%end

//Tab Bar Stuff

%hook UITabBar

-(void)setFrame:(CGRect)arg1 {
    %orig;
     if (isEnabled) {
        UIColor* originalBarBgColor = [self backgroundColor];
        UIColor* newBarBgColor = createEclipseDynamicColor(originalBarBgColor, NAV_COLOR);
        [self setBackgroundColor: newBarBgColor];

        // UIColor* originalSelectedImageTintColor = [self selectedImageTintColor];
        // UIColor* originalUnselectedImageTintColor = [self unselectedItemTintColor];
        // UIColor* newUnselectedImageTintColor = [UIColor whiteColor];
        // [self setUnselectedItemTintColor: createEclipseDynamicColor(originalUnselectedImageTintColor, newUnselectedImageTintColor)];


        // self.backgroundColor = NAV_COLOR; //Fuck you, Whatsapp.

    }
}

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIColor* originalBarBgColor = [self backgroundColor];
        UIColor* newBarBgColor = createEclipseDynamicColor(originalBarBgColor, NAV_COLOR);
        [self setBackgroundColor: newBarBgColor];

        // UIColor* originalSelectedImageTintColor = [self selectedImageTintColor];
        // UIColor* originalUnselectedImageTintColor = [self unselectedItemTintColor];
        // UIColor* newUnselectedImageTintColor = [UIColor whiteColor];
        // [self setUnselectedItemTintColor: createEclipseDynamicColor(originalUnselectedImageTintColor, newUnselectedImageTintColor)];


        // self.backgroundColor = NAV_COLOR; //Fuck you, Whatsapp.

    }
}

-(UIColor *)unselectedItemTintColor {
    UIColor* originalColor = %orig;
	if (isEnabled) {
		return createEclipseDynamicColor([UIColor grayColor], [UIColor whiteColor]);
	}
	return %orig;
}

// -(void)setBarTintColor:(id)arg1 {
//     if (isEnabled) {
//         self.backgroundColor = NAV_COLOR;
//         %orig(NAV_COLOR);
//         return;
//     }
//     %orig;
// }

%end

// %hook SKUITabBarBackgroundView

// -(void)layoutSubviews {
//     %orig;
//     if (isEnabled) {
//         UIView* eclipseBarView = [[UIView alloc] initWithFrame:[self frame]];
//         [eclipseBarView setBackgroundColor:NAV_COLOR];
//         [self addSubview:eclipseBarView];
//         [eclipseBarView release];

//     }
// }


// %end


%hook UIToolbar


-(void)setBarStyle:(int)arg1 {
    if (isEnabled && !(IsiPad)) {
        UIColor* originalBarBgColor = [self barTintColor];
        UIColor* newBarBgColor = createEclipseDynamicColor(originalBarBgColor, NAV_COLOR);
        // [self setBackgroundColor: newBarBgColor];
        [self setBarTintColor:newBarBgColor];
        return;
    }
    %orig;
}


-(void)setBarTintColor:(id)arg1 {
    if (isEnabled && !(IsiPad)) {
        UIColor* originalBarBgColor = [self barTintColor];
        UIColor* newBarBgColor = createEclipseDynamicColor(originalBarBgColor, NAV_COLOR);
        %orig(newBarBgColor);
        return;
    }
    %orig;
}

%end
