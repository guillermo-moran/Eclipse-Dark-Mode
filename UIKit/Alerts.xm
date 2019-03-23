/*
  .d8b.  db      d88888b d8888b. d888888b .d8888.
 d8' `8b 88      88'     88  `8D `~~88~~' 88'  YP
 88ooo88 88      88ooooo 88oobY'    88    `8bo.
 88~~~88 88      88~~~~~ 88`8b      88      `Y8b.
 88   88 88booo. 88.     88 `88.    88    db   8D
 YP   YP Y88888P Y88888P 88   YD    YP    `8888Y'
*/



%hook _UITextFieldRoundedRectBackgroundViewNeue

-(id)fillColor {
    if (isEnabled) {
        return [UIColor clearColor];
    }
    return %orig;
}

-(id)initWithFrame:(CGRect)arg1 {
    id ok = %orig;
    if (isEnabled) {
        [self setFillColor:[UIColor clearColor]];
    }
    return ok;
}
%end

/* ==== INFORMATION ====

 _UIBackdropViewSettingsAdaptiveLight = 2060 || iOS 7 Control Center

 _UIBackdropViewSettingsUltraLight = 2010 || App Store, iTunes, Action Sheets, and Share Sheets

 _UIBackdropViewSettingsLight = 0, 1000, 1003, 2020, 10090, 10100 || Dock, Spotlight, Folders

 */
/*
%hook _UIBackdropViewSettings

-(id)colorTint {
    UIColor* color = %orig;

    id _backdrop = MSHookIvar<id>(self, "_backdrop");

    //if ([[_backdrop superview] isKindOfClass:[UIActionSheet class]] && [self style] != 2060) {






    if (isEnabled && [self class] == %c(_UIBackdropViewSettingsUltraLight)) {

        color = [NAV_COLOR colorWithAlphaComponent:0.9];
        [_backdrop setAlpha:0.9];
    }



    if (isEnabled && darkenKeyboard() && [_backdrop isKindOfClass:objc_getClass("UIKBBackdropView")]) {
        color = [keyboardColor() colorWithAlphaComponent:0.9];
        [_backdrop setAlpha:0.9];
    }


    return color;
}

%end
*/

%group EclipseAlerts

//Action Sheets
@interface _UIActivityGroupActivityCellTitleLabel : UILabel
@end

%hook _UIActivityGroupActivityCellTitleLabel

-(void)layoutSubviews {
    %orig;

    if(isEnabled) {
        self.textColor = selectedTintColor();
    }
}

%end

@interface UIActionSheetiOSDismissActionView : UIView
@end

%hook UIActionSheetiOSDismissActionView
-(void)layoutSubviews {
    %orig;

    if(isEnabled) {

        UIButton *button = MSHookIvar<UIButton *>(self, "_dismissButton");
        button.tintColor = selectedTintColor();
    }
}
%end

@interface _UIInterfaceActionGroupHeaderScrollView  : UIView
@end

%hook _UIInterfaceActionGroupHeaderScrollView
-(void)layoutSubviews {
    %orig;

    if(isEnabled){
        UIView *contentView = MSHookIvar<UIView *>(self, "_contentView");

        for (UILabel *subview in contentView.subviews) {
            if ([subview isKindOfClass:[UILabel class]]) {
                subview.textColor = selectedTintColor();
            }
        }
    }
}
%end

/*
@interface _UIInterfaceActionCustomViewRepresentationView  : UIView
@end

%hook _UIInterfaceActionCustomViewRepresentationView

-(void)layoutSubviews {
    %orig;
    if(isEnabled){
        UIView *actionView = MSHookIvar<UIView *>(self, "_actionContentView");
        UILabel *label = MSHookIvar<UILabel *>(actionView, "_label");
        label.tintColor = selectedTintColor();
    }
}

-(void)setHighlighted:(BOOL)arg1{
    %orig;
    if(isEnabled){

        UIView *actionView = MSHookIvar<UIView *>(self, "_actionContentView");
        UILabel *label = MSHookIvar<UILabel *>(actionView, "_label");
        label.tintColor = selectedTintColor();
    }
}

%end
*/


//Alerts

%hook _UIAlertControllerView

- (id)initWithFrame:(CGRect)arg1
 {
    id kek = %orig;
    if (isEnabled) {

        for (UIView* view in [self subviews]) {
            view.tag = VIEW_EXCLUDE_TAG;
        }

        UILabel* _titleLabel = MSHookIvar<id>(self, "_titleLabel");
        [_titleLabel setTextColor:selectedTintColor()];

        UILabel* _detailMessageLabel = MSHookIvar<id>(self, "_detailMessageLabel");
        [_detailMessageLabel setTextColor:TEXT_COLOR];

        UILabel* _messageLabel = MSHookIvar<id>(self, "_messageLabel");
        [_messageLabel setTextColor:TEXT_COLOR];
    }
     return kek;
}

%end

// %hook ServiceTouchIDAlertHeaderViewE
//
// -(void)layoutSubviews {
//     %orig;
//     if (isEnabled) {
//
//         for (UILabel* label in [self subviews]) {
//             if ([label respondsToSelector:@selector(setTextColor:)]) {
//                 [label setTextColor:TEXT_COLOR];
//             }
//         }
//
//         [self setBackgroundColor:NAV_COLOR];
//     }
// }
//
// %end

// Alert Content View
%hook _UIAlertControllerShadowedScrollView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:NAV_COLOR];
    }
}

%end

// %hook _UIAlertControllerCollectionViewCell
//
// -(void)layoutSubviews {
//     %orig;
//     if (isEnabled) {
//         [self setBackgroundColor:NAV_COLOR];
//     }
// }
//
// %end

%hook _UIAlertControllerBlendingSeparatorView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:selectedTintColor()];
    }
}

%end

//Alert Buttons
%hook _UIAlertControllerActionView

- (void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:NAV_COLOR];

        UILabel* _label = MSHookIvar<id>(self, "_label");
        [_label setTextColor:selectedTintColor()];
    }
}

-(id)tintColor {
    if (isEnabled) {
        return selectedTintColor();

    }
    return %orig;
}


%end

%end //End Eclipse Alerts
