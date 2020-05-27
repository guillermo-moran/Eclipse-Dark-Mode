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


%end
