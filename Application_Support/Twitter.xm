/*
 d888888b db   d8b   db d888888b d888888b d888888b d88888b d8888b.
 `~~88~~' 88   I8I   88   `88'   `~~88~~' `~~88~~' 88'     88  `8D
 88    88   I8I   88    88       88       88    88ooooo 88oobY'
 88    Y8   I8I   88    88       88       88    88~~~~~ 88`8b
 88    `8b d8'8b d8'   .88.      88       88    88.     88 `88.
 YP     `8b8' `8d8'  Y888888P    YP       YP    Y88888P 88   YD
 */

%group TwitterApp

%hook T1SearchTextView

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		UIImageView* backgroundImageView = MSHookIvar<UIImageView*>(self, "_backgroundImageView");
		[backgroundImageView setAlpha:0.1];

	}
}

%end

%hook T1StatusView

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor:VIEW_COLOR];
	}
}

%end


%hook ABCustomHitTestView

-(id)backgroundColor {
	if (isEnabled) {
		return RED_COLOR;
	}
}

%end



%hook TFNCellDrawingView

- (void)setBackgroundColor:(id)arg1 {
	if (isEnabled) {
		arg1 = VIEW_COLOR;
	}
	%orig(arg1);
}

%end

%hook T1TweetDetailsAttributedStringItem //1.4.3 fix

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor:VIEW_COLOR];
	}
}

%end

%hook TFNTableViewCell

- (void)_layoutSeparator:(id)arg1 {
	return;
}

%end

%hook TFNRoundedCornerView

-(UIColor*)borderColor {
	if (isEnabled) {
		return selectedTintColor();
	}
	return %orig;
}

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor: [UIColor clearColor]];
	}
}

%end

%hook TFNTwitterStandardColorPalette

//Usernames
- (id)_twitterColorText {
	if (isEnabled) {
		return selectedTintColor();
	}
	return %orig;
}
- (id)twitterColorText {
	if (isEnabled) {
		return TEXT_COLOR;
	}
	return %orig;
}


%end
%end
