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

%group SafariApp

//static NSString* safariJS = @"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'white'; document.getElementsByTagName('html')[0].style.backgroundColor= 'black'; var x = document.getElementsByTagName('div'); var i; for (i = 0; i < x.length; i++) { x[i].style.backgroundColor = 'transparent'; };";

static NSString* safariJS = @"javascript: ( function () { var css = 'html {-webkit-filter: invert(100%);' + '-moz-filter: invert(100%);' + '-o-filter: invert(100%);' + '-ms-filter: invert(100%); }', head = document.getElementsByTagName('head')[0], style = document.createElement('style'); style.type = 'text/css'; if (style.styleSheet){ style.styleSheet.cssText = css; } else { style.appendChild(document.createTextNode(css)); } head.appendChild(style); }());";

%hook WKWebView

-(void)_didFinishLoadForMainFrame {
    %orig;
    if (isEnabled) {
        //[self stringByEvaluatingJavaScriptFromString:safariJS];
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
