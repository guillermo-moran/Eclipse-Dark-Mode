%group Whatsapp

%hook WACaptionBarInputTextView

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		UIColor* newColor = createEclipseDynamicColor([UIColor blackColor], TEXT_COLOR);
		[self setTextColor: newColor];
	}
}

-(id)textColor {
	UIColor* originalColor = %orig;
	if (isEnabled) {
		return createEclipseDynamicColor(originalColor, TEXT_COLOR);
	}
	return originalColor;
}

-(void)setTextColor:(UIColor*)color {
	if (isEnabled) {
		UIColor* newColor = createEclipseDynamicColor(color, TEXT_COLOR);
		%orig(newColor);
		return;
	}
	%orig;
	
}

%end