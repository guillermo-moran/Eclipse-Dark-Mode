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


%hook IGTabBarButton

- (id)_initWithFrame:(struct CGRect)arg1 badgeType:(unsigned long long)arg2 clearsBadgeWhenSelected:(_Bool)arg3 {
	id x = %orig;
	if (isEnabled) {
		applyInvertFilter((UIButton*)self);
	}
	return x;
}

// - (void)layoutSubviews {
// 	%orig;
// 	self = [UIButton buttonWithType:(UIButtonTypeCustom)];
// 	if (isEnabled) {
// 		[self setTintColor: RED_COLOR];
// 	}
// }

%end

%hook UIView //Very hacky method of hooking IGUFIButtonBarView, which for some reason wouldn't hook. Hmm.

-(void)layoutSubviews {
	%orig;
	if ([NSStringFromClass([self class]) isEqualToString:@"IGUFIButtonBarView"]) {
            [self setColorType:1];
        }
}

%end


%hook IGGradientView

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setHidden:YES];
	}
}
%end

%hook IGDiscoveryNavigationTrayItemCell

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		CAShapeLayer* bgLayer = MSHookIvar<CAShapeLayer*>(self, "_backgroundLayer");
		bgLayer.fillColor = [UIColor clearColor].CGColor;
	}
}

%end

%end
