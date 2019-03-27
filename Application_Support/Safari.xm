/*
.d8888.  .d8b.  d88888b  .d8b.  d8888b. d888888b
88'  YP d8' `8b 88'     d8' `8b 88  `8D   `88'
`8bo.   88ooo88 88ooo   88ooo88 88oobY'    88
  `Y8b. 88~~~88 88~~~   88~~~88 88`8b      88
db   8D 88   88 88      88   88 88 `88.   .88.
`8888Y' YP   YP YP      YP   YP 88   YD Y888888P
*/


@interface NavigationBarBackdrop : _UIBackdropView
- (void)applySettings:(id)arg1;
@end


@interface DimmingButton : UIButton
-(UIImage *)maskImage:(UIImage*)image withColor:(UIColor *)color;
@end

#include "Utils/WKWebView+Eclipse.h"

// // Webview hooks (do not group)
// %hook UIWebView
// 	-(void)webViewMainFrameDidFinishLoad:(id)arg1{
// 		%orig;
// 		[self stringByEvaluatingJavaScriptFromString:darkSafariJS];
// 	}
// 	%end

%group SafariApp

%hook WKWebView

-(void)_didCommitLoadForMainFrame {
    %orig;
    if (isEnabled) {
        if (darkWebEnabled()) {
            [self stringByEvaluatingJavaScriptFromString:darkSafariJS];
        }
    }
}

-(void)_didFinishLoadForMainFrame {
    %orig;
    if (isEnabled) {
        if (darkWebEnabled()) {
            [self stringByEvaluatingJavaScriptFromString:darkSafariJS];
        }
    }
}

%end


%hook _SFNavigationBar

/*
-(void)tintColorDidChange {
    if (isEnabled) {
        return;
    }
    %orig;
}
-(void)_updateControlTints {
    if (isEnabled) {
        return;
    }
    %orig;
}
 */
-(void)_updateTextColor {
    if (isEnabled) {
        return;
    }
    %orig;
}

-(void)setPreferredControlsTintColor:(id)arg1 {
    if (isEnabled) {
        arg1 = selectedTintColor();
    }
    %orig(arg1);
}

-(id)_EVCertLockAndTextColor {
    if (isEnabled) {
        return selectedTintColor();
    }
    return %orig;
}
-(id)_tintForLockImage:(bool)arg1 {
    if (isEnabled) {
        return selectedTintColor();
    }
    return %orig;
}


-(id)_URLTextColor {
    if (isEnabled) {
        return selectedTintColor();
    }
    return %orig;
}

-(id)_placeholderColor {
    if (isEnabled) {
        return selectedTintColor();
    }
    return %orig;
}

-(id)preferredBarTintColor {
    if (isEnabled) {
        return selectedTintColor();
    }
    return %orig;
}
-(id)preferredControlsTintColor {
    if (isEnabled) {
        return selectedTintColor();
    }
    return %orig;

}

-(id)_URLControlsColor {
    if (isEnabled) {
        return selectedTintColor();
    }
    return %orig;
}

-(id)reloadButton {
    id x = %orig;

    if (isEnabled) {
        [x setTintColor:selectedTintColor()];
    }

    return x;
}
-(id)readerButton {
    id x = %orig;

    if (isEnabled) {
        [x setTintColor:selectedTintColor()];
    }

    return x;
}

%end

%hook TabBar

- (void)layoutSubviews {

    %orig;

    if (isEnabled) {

        UIView *_leadingContainer = MSHookIvar<UIButton*>(self, "_leadingContainer");

        UIView *_leadingBackgroundOverlayView = MSHookIvar<UIButton*>(self, "_leadingBackgroundOverlayView");

        UIView *_leadingBackgroundTintView = MSHookIvar<UIButton*>(self, "_leadingBackgroundTintView");

        _leadingContainer.alpha = 0.1;



    }
}

%end

%hook _SFToolbar

- (void)layoutSubviews {
    %orig;

    if (isEnabled) {
        _UIBackdropView* backdropView = MSHookIvar<_UIBackdropView*>(self, "_backgroundView");

        //_UIBackdropViewSettings *settings = [_UIBackdropViewSettings settingsForPrivateStyle:2030];
        //[settings setColorTint:RED_COLOR];
        //[backdropView applySettings:settings];

        UIView* toolbarBackground = [[UIView alloc] initWithFrame:backdropView.frame];
        [toolbarBackground setBackgroundColor:NAV_COLOR];
        [backdropView addSubview:toolbarBackground];
        [toolbarBackground release];

        //backdropView.hidden = YES;
    }
}

%end

%hook SFDialogTextView

-(void)layoutSubviews {
    //%orig;
    if (isEnabled) {
        [self setBackgroundColor:[UIColor clearColor]];
        return;
    }
    %orig;
}

%end

%end
