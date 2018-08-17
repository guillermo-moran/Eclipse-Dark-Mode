/*
 _   _           _
 | |_(_)_ __   __| | ___ _ __
 | __| | '_ \ / _` |/ _ \ '__|
 | |_| | | | | (_| |  __/ |
 \__|_|_| |_|\__,_|\___|_|

 */

%group TinderApp

%hook TNDRChatViewController

- (void)viewWillAppear:(BOOL)arg1 {
	%orig;

	if (isEnabled) {
		UIToolbar* _composeView = MSHookIvar<UIToolbar*>(self, "_composeView");

		for (UIImageView* image in [_composeView subviews]) {
			if ([image respondsToSelector:@selector(setImage:)]) {
				[image setAlpha:0.1];
			}
		}
	}
}

%end

%hook TNDRChatBubbleCell

- (void)setupBackgroundImageView {
	%orig;
	if (isEnabled) {
		UIImageView* _backgroundImageView = MSHookIvar<UIImageView*>(self, "_backgroundImageView");

		[_backgroundImageView setAlpha:0.2];
	}


}

%end

%end
