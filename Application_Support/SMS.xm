/*
 .d8888. .88b  d88. .d8888.
 88'  YP 88'YbdP`88 88'  YP
 `8bo.   88  88  88 `8bo.
   `Y8b. 88  88  88   `Y8b.
 db   8D 88  88  88 db   8D
 `8888Y' YP  YP  YP `8888Y'
*/

//Do not group (text bubbles in compose views system-wide)

/*
%subclass CKUIThemeEclipse : CKUITheme

-(UIColor *)transcriptBackgroundColor;
-(UIColor *)messagesControllerBackgroundColor;
-(UIColor *)conversationListBackgroundColor;
-(UIColor *)dimmingViewBackgroundColor;
-(UIColor *)searchResultsBackgroundColor;
-(UIColor *)searchResultsCellBackgroundColor;
-(UIColor *)searchResultsCellSelectedColor;
-(UIColor *)searchResultsSeperatorColor;
-(UIColor *)entryFieldBackgroundColor;

%end
 */

//static CKUIThemeDark *darkTheme;

%subclass CKUIThemeEclipse : CKUIThemeDark

-(id)conversationListBackgroundColor {
    //if (isEnabled) {
        return VIEW_COLOR;
    //}
    //return %orig;
}
-(id)conversationListCellColor {
    //if (isEnabled) {
        return TABLE_COLOR;
    //}
    //return %orig;
}

-(id)transcriptBackgroundColor {
    //if (isEnabled) {
        return VIEW_COLOR;
    //}
    //return %orig;
}

-(id)blue_balloonColors {
    if (tintMessageBubbles() && isEnabled) {

        int number = [[prefs objectForKey:@"selectedTint"] intValue];

        if (number == 1) {

            NSArray* color = @[darkerColorForColor([selectedTintColor() colorWithAlphaComponent:0.7]), [selectedTintColor() colorWithAlphaComponent:0.7]];
            return color;
        }

        else {
            NSArray* color = @[darkerColorForColor([selectedTintColor() colorWithAlphaComponent:0.8]),selectedTintColor()];
            return color;
        }
    }
    //Disabled, but this fixes a stupid bug that I created by replacing systemBlueColor. So instead of properly tinting everything, I just assign a new blue.

    NSArray* originalColor = @[darkerColorForColor([BABY_BLUE_COLOR colorWithAlphaComponent:0.8]),BABY_BLUE_COLOR];

    return originalColor;
}

- (id)blue_balloonTextColor {
    if (selectedTint() == 1 && isEnabled && tintMessageBubbles()) {
        return [UIColor blackColor];
    }
    else {
        return %orig;
    }
}

-(id)green_balloonColors {
    int number = [[prefs objectForKey:@"selectedTint"] intValue];
    if (tintSMSBubbles() && isEnabled) {

        int number = [[prefs objectForKey:@"selectedTint"] intValue];

        if (number == 1) {

            NSArray* color = @[darkerColorForColor([selectedTintColor() colorWithAlphaComponent:0.7]), [selectedTintColor() colorWithAlphaComponent:0.7]];
            return color;
        }

        else {
            NSArray* color = @[darkerColorForColor([selectedTintColor() colorWithAlphaComponent:0.8]),selectedTintColor()];
            return color;
        }
    }
    return %orig;
}

- (id)green_balloonTextColor {
    if (selectedTint() == 1 && isEnabled && tintSMSBubbles()) {
        return [UIColor blackColor];
    }
    else {
        return %orig;
    }
}

// -(id)gray_balloonColors {
//     return @[VIEW_COLOR, VIEW_COLOR];
// }

-(id)siri_balloonColors {
    if (isEnabled) {
        return @[VIEW_COLOR, NIGHT_VIEW_COLOR];
    }
    return %orig;
}



/*

-(id)red_balloonColors {
    if (isEnabled) {
        return @[VIEW_COLOR, NIGHT_VIEW_COLOR];
    }
    return %orig;
}
 */

%end

static CKUIThemeEclipse* eclipseTheme;


%hook CKUIBehaviorPhone
- (id)theme {
    if (isEnabled) {
        eclipseTheme = [[%c(CKUIThemeEclipse) alloc] init];
        return eclipseTheme;
    }
    return %orig;
}
%end



%hook CKUIBehaviorPad
- (id)theme {
    if (isEnabled) {
        eclipseTheme = [[%c(CKUIThemeEclipse)  alloc] init];
        return eclipseTheme;
    }
    return %orig;
}
%end

/*
@interface _UITextFieldRoundedRectBackgroundViewNeue : NSObject
-(void)setFillColor:(UIColor*)color ;
@end
 */

%hook UILabel

-(void)layoutSubviews {
    %orig;
    if ([NSStringFromClass([self.superview class]) isEqualToString:@"LPTextView"]) {
        if (selectedTint() == 1) {
            [self setTextColor: RED_COLOR];
        }
        else {
            [self setTextColor: selectedTintColor()];
        }

    }
}

%end

%hook CKBrowserSwitcherFooterView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UICollectionView* _collectionView = MSHookIvar<UICollectionView*>(self, "_collectionView");
        [_collectionView setBackgroundColor: VIEW_COLOR];

    }
}

-(id)initWithFrame:(CGRect)arg1 {
    id x = %orig;
    if (isEnabled) {
        UICollectionView* _collectionView = MSHookIvar<UICollectionView*>(self, "_collectionView");
        [_collectionView setBackgroundColor: VIEW_COLOR];

    }
    return x;
}


-(UICollectionView*)collectionView {
    UICollectionView* c = %orig;
    if (isEnabled) {
        [c setBackgroundColor: VIEW_COLOR];
    }
    return c;
}


%end

%hook CNContactView

-(void)layoutSubviews{
    %orig;
    if (isEnabled) {
        [self setBackgroundColor: VIEW_COLOR];
    }
}

%end
