%group PreferencesApp

%hook PLWallpaperButton

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		id backdropView = MSHookIvar<id>(self, "_backdropView");
		[backdropView setHidden: true];

		[self setBackgroundColor: NAV_COLOR];
	}

}

%end

%hook PSPasscodeField

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setForegroundColor: TEXT_COLOR];
	}
}

-(void)setForegroundColor:(UIColor *)arg1 {
	if (isEnabled) {
		arg1 = TEXT_COLOR;
	}
	%orig(arg1);
}
-(UIColor *)foregroundColor {
	UIColor* color = %orig;
	if (isEnabled) {
		color = TEXT_COLOR;
	}
	return color;
}

%end

%end
