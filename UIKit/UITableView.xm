/*
 d888888b  .d8b.  d8888b. db      d88888b
 `~~88~~' d8' `8b 88  `8D 88      88'
    88    88ooo88 88oooY' 88      88ooooo
    88    88~~~88 88~~~b. 88      88~~~~~
    88    88   88 88   8D 88booo. 88.
    YP    YP   YP Y8888P' Y88888P Y88888P
*/

#define TABLE_BG_COLOR [UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:1.0f] //Default Table BG Color

static CGColorSpaceRef tableBGColorSpace = CGColorGetColorSpace([TABLE_BG_COLOR CGColor]);

#define CELL_WHITE [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f] //Fuck You Apple. (Some apps don't use whiteColor)

static CGColorSpaceRef cellWhiteColorSpace = CGColorGetColorSpace([CELL_WHITE CGColor]);

#define IPAD_CELL_WHITE [UIColor colorWithRed:0.145098 green:0.145098 blue:0.145098 alpha:1.0f]

static CGColorSpaceRef iPadCellWhiteColorSpace = CGColorGetColorSpace([IPAD_CELL_WHITE CGColor]);


static CGColorSpaceRef whiteColorSpace = CGColorGetColorSpace([[UIColor whiteColor] CGColor]);



%hook UITableView


%new
-(void)override {

    @try {
        if (isEnabled) {

            UIColor* originalColor = self.backgroundColor;
            // CGColorSpaceRef origColorSpace = CGColorGetColorSpace([self.backgroundColor CGColor]);

            //if (origColorSpace == tableBGColorSpace || origColorSpace == whiteColorSpace || origColorSpace == cellWhiteColorSpace) {

            if (isLightColor(originalColor)) {

                self.sectionIndexBackgroundColor = [UIColor clearColor];


                [self setSectionIndexTrackingBackgroundColor:[UIColor clearColor]];
                self.sectionIndexTrackingBackgroundColor = [UIColor clearColor];

                [self setSectionIndexColor:selectedTintColor()];
                self.sectionIndexColor = selectedTintColor();
            }
        }


    }
    @catch (NSException* e) {
        //Error
    }

}


-(id)initWithFrame:(CGRect)arg1 {
    id itsTenPM = %orig;
    [self override];
    return itsTenPM;
}


-(id)initWithCoder:(id)arg1 {
    id itsTenPM = %orig;
    [self override];
    return itsTenPM;
}



-(id)init {
    id itsTenPM = %orig;
    [self override];
    return itsTenPM;
}



// -(void)setBackgroundColor:(id)arg1 {
//
//     if (isEnabled) {
//         %orig(TABLE_COLOR);
//         return;
//     }
//     %orig;
// }
//
// -(id)backgroundColor {
//     if (isEnabled) {
//         return TABLE_COLOR;
//     }
//     return %orig;
// }



-(void)layoutSubviews {
    %orig;
    
    UIColor* originalColor = self.backgroundColor;
    if (isEnabled && ![self.backgroundColor isEqual:[UIColor clearColor]] && self.backgroundColor != nil) { // should we check isLight?
        UIColor* dynamicColor = createEclipseDynamicColor(originalColor, TABLE_COLOR);
        [self setBackgroundColor:dynamicColor];
    }
}




-(id)sectionBorderColor {
    if (isEnabled) {
        return [UIColor clearColor];
    }
    return %orig;
}



-(id)sectionIndexTrackingBackgroundColor {
    if (isEnabled) {
        return [UIColor clearColor];
    }
    return %orig;
}
-(void)setSectionIndexTrackingBackgroundColor:(id)arg1 {
    if (isEnabled) {
        %orig ([UIColor clearColor]);
        return;
    }
    %orig;
}

-(void)setSectionIndexColor:(id)arg1 {
    if (isEnabled) {
        self.sectionIndexBackgroundColor = [UIColor clearColor];

        arg1 = selectedTintColor();
    }
    %orig(arg1);
}

-(void)setTableHeaderBackgroundColor:(id)arg1 {
    if (isEnabled) {
        self.sectionIndexBackgroundColor = [UIColor clearColor];
        arg1 = TABLE_COLOR;
    }
    %orig(arg1);
}
-(id)tableHeaderBackgroundColor {
    if (isEnabled) {
        return TABLE_COLOR;
    }
    return %orig;
}



%end

//Selected Background



//Table Index

%hook UITableViewIndex

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setIndexTrackingBackgroundColor:[UIColor clearColor]];
        [self setIndexBackgroundColor:[UIColor clearColor]];
        [self setIndexColor:selectedTintColor()];
    }

}

-(id)initWithFrame:(CGRect)arg1 {
    id k = %orig;

    if (isEnabled) {
        [self setIndexTrackingBackgroundColor:[UIColor clearColor]];
        [self setIndexBackgroundColor:[UIColor clearColor]];
        [self setIndexColor:selectedTintColor()];
    }

    return k;
}

-(void)drawRect:(CGRect)arg1 {
    %orig;

    if (isEnabled) {
        [self setIndexTrackingBackgroundColor:[UIColor clearColor]];
        [self setIndexBackgroundColor:[UIColor clearColor]];
        [self setIndexColor:selectedTintColor()];
    }

}

-(UIColor *)indexTrackingBackgroundColor {
    if (isEnabled) {
        return [UIColor clearColor];
    }
    return %orig;
}
-(UIColor *)indexBackgroundColor {
    if (isEnabled) {
        return [UIColor clearColor];
    }
    return %orig;
}

-(UIColor *)indexColor {
    if (isEnabled) {
        return selectedTintColor();
    }
    return %orig;
}

%end



/*
 db   db d88888b db    db d8888b.  d888b
 88   88 88'     88    88 88  `8D 88' Y8b
 88ooo88 88ooo   Y8    8P 88oooY' 88
 88~~~88 88~~~   `8b  d8' 88~~~b. 88  ooo
 88   88 88       `8bd8'  88   8D 88. ~8~
 YP   YP YP         YP    Y8888P'  Y888P
*/

%hook _UITableViewHeaderFooterViewBackground

// -(void)layoutSubviews {
//     %orig;
//     if (isEnabled) {
//         UIColor* originalColor = (UIColor*)[self backgroundColor];
//         UIColor* dynamicColor = createEclipseDynamicColor(originalColor, TABLE_BG_COLOR);
//         [self setBackgroundColor:dynamicColor];
//     }
// }

-(id)backgroundColor {
    return [UIColor clearColor];
}

%end



/*
  .o88b. d88888b db      db      .d8888.
 d8P  Y8 88'     88      88      88'  YP
 8P      88ooooo 88      88      `8bo.
 8b      88~~~~~ 88      88        `Y8b.
 Y8b  d8 88.     88booo. 88booo. db   8D
  `Y88P' Y88888P Y88888P Y88888P `8888Y'
*/


%hook UIGroupTableViewCellBackground

- (UIColor*)_fillColor {
    if (isEnabled) {
        UIColor* originalColor = %orig;
        UIColor* dynamicColor = createEclipseDynamicColor(originalColor, TABLE_COLOR);
        
        return dynamicColor;
    }
    return %orig;
}



%end

@interface UITableViewCell(Eclipse)
-(void)override;
-(BOOL)isLightColor:(id)clr;
-(void)setSelectionTintColor:(id)arg1;
@end

%hook UITableViewCell

/* i made a fucking mess because Clock.app crashes on some devices.
 Now i'm trying to catch the fucking exception.
*/



// %new
// -(void)override {

//     if (isEnabled) {
//         if (isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]]) {
//             UIColor* originalColor = self.backgroundColor;
//             UIColor* dynamicColor = createEclipseDynamicColor(originalColor, TABLE_COLOR);
//             [self setBackgroundColor:dynamicColor];

//         }
//     }

// }

-(void)drawRect:(CGRect)arg1 {
    %orig;

    if (isEnabled) {
        if ([self selectionStyle] != UITableViewCellSelectionStyleNone) {
            [self setSelectionTintColor:[UIColor darkerColorForSelectionColor:selectedTintColor()]];
        }
    }


}


-(id)_detailTextLabel {
    UILabel* label = %orig;

    if (isEnabled) {
        if (shouldColorDetailText()) {
            [label setTextColor:selectedTintColor()];
        }
        else {
            [label setTextColor:TEXT_COLOR];
        }
    }


    return label;
}

// -(id)init {
//     id orig = %orig;
//     [self override];
//     return orig;
// }

-(void)layoutSubviews {
    %orig;
    self.tag = VIEW_EXCLUDE_TAG; // temp workaround
    if (isEnabled) {
        if (isLightColor(self.backgroundColor)) {
            UIColor* originalColor = self.backgroundColor;
            UIColor* dynamicColor = createEclipseDynamicColor(originalColor, TABLE_COLOR);
            [self setBackgroundColor:dynamicColor];
        }
    }
}

// -(void)setBackgroundColor:(id)arg1 {

//     if (isEnabled) {

//         if (!isLightColor(arg1) && ![arg1 isEqual:[UIColor clearColor]]) {
//             //[self.textLabel setTextColor:TEXT_COLOR];
//             UIColor* dynamicColor = createEclipseDynamicColor(arg1, TABLE_COLOR);
//             [self setBackgroundColor:dynamicColor];

//             arg1 = dynamicColor;
//         }
//     }


//         %orig(arg1);
// }


// -(id)backgroundColor {
//     if (isEnabled) {
//         UIColor* originalColor = %orig;
//         if (!isLightColor(originalColor) && ![originalColor isEqual:[UIColor clearColor]]) {
//             //[((UITableViewCell*)self).textLabel setTextColor:TEXT_COLOR];

//             UIColor* dynamicColor = createEclipseDynamicColor(originalColor, TABLE_COLOR);
//             [self setBackgroundColor:dynamicColor];
//         }
//     }

//     return %orig;
// }


-(id)selectionTintColor {

    if (isEnabled) {
        return [UIColor darkerColorForSelectionColor:selectedTintColor()];
    }


    return %orig;
}


%end

%hook _UITableViewCellSeparatorView

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setTag:VIEW_EXCLUDE_TAG];
        [self setBackgroundColor:TABLE_SEPARATOR_COLOR];
    }
}

-(void)setBackgroundColor:(UIColor*)color {
    if (isEnabled) {
        %orig(TABLE_SEPARATOR_COLOR);
        return;
    }
    %orig;
}

%end

//Cell Selection


//Cell Edit Control (CONFLICTS WITH WINTERBOARD)
/*
%hook UITableViewCellEditControl

-(id)backgroundColor {

    UIColor* bgColor = %orig;

    if (isEnabled) {
        return VIEW_COLOR;
    }
    return bgColor;
}

%end
*/
