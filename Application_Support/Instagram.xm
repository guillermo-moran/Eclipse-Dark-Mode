/*
 d888888b d8b   db .d8888. d888888b  .d8b.   d888b  d8888b.  .d8b.  .88b  d88.
 `88'   888o  88 88'  YP `~~88~~' d8' `8b 88' Y8b 88  `8D d8' `8b 88'YbdP`88
 88    88V8o 88 `8bo.      88    88ooo88 88      88oobY' 88ooo88 88  88  88
 88    88 V8o88   `Y8b.    88    88~~~88 88  ooo 88`8b   88~~~88 88  88  88
 .88.   88  V888 db   8D    88    88   88 88. ~8~ 88 `88. 88   88 88  88  88
 Y888888P VP   V8P `8888Y'    YP    YP   YP  Y888P  88   YD YP   YP YP  YP  YP
 */

@interface IGStringStyle : NSObject
@property(retain, nonatomic) UIColor *defaultColor;
@end

%group InstagramApp

%hook _UIBarBackground

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		UIImageView* _backgroundImageView = MSHookIvar<UIImageView*>(self, "_backgroundImageView");

		[_backgroundImageView setHidden:YES];
	}
}

%end

%hook IGTextButton

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		UIImageView* _backgroundImageView = MSHookIvar<UIImageView*>(self, "_backgroundView");

		[_backgroundImageView setAlpha:0.1];
	}

}

%end

%hook IGStringStyle

-(UIColor*)defaultColor {
	if (isEnabled) {
		return TEXT_COLOR;
	}
	return %orig;
}

-(UIColor*)linkColor {

	if (isEnabled) {

		return selectedTintColor();
	}
	return %orig;

}

%end

%hook IGCommentTextRedesignView

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		UIImageView* _backgroundImageView = MSHookIvar<UIImageView*>(self, "_roundedBackgroundImageView");

		[_backgroundImageView setAlpha:0.1];
	}
}

%end

%hook IGSimpleButton

- (void)layoutSubviews {
	%orig;

	if (isEnabled) {
		UIImageView* _backgroundImageView = MSHookIvar<UIImageView*>(self, "_backgroundImageView");

		[_backgroundImageView setAlpha:0.1];
	}
}

%end

%hook UITextFieldBorderView

-(void)layoutSubviews {
	%orig;

	if (isEnabled) {
		[self setAlpha:0.05];
	}
}

%end


%hook IGColors

+ (id)separatorColor {
	if (isEnabled) {
		return selectedTintColor();
	}
	return %orig;
}

+ (id)boldLinkHighlightedColor {
	if (isEnabled) {
		return selectedTintColor();
	}
	return %orig;
}
+ (id)boldLinkColor {
	if (isEnabled) {
		return selectedTintColor();
	}
	return %orig;
}
+ (id)linkHighlightedColor {
	if (isEnabled) {
		return selectedTintColor();
	}
	return %orig;

}
+ (id)linkColor {
	if (isEnabled) {
		return selectedTintColor();
	}
	return %orig;
}
+ (id)veryLightTextColor {
	if (isEnabled) {
		return TEXT_COLOR;
	}
	return %orig;
}
+ (id)secondaryTextColor {
	if (isEnabled) {
		return TEXT_COLOR;
	}
	return %orig;
}
+ (id)textColor {
	if (isEnabled) {
		return TEXT_COLOR;
	}
	return %orig;
}

+ (id)lightBarBackgroundColor {
	if (isEnabled) {
		return NAV_COLOR;
	}
	return %orig;
}




%end

%end
