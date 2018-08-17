/*
 d888888b db   d8b   db d88888b d88888b d888888b d8888b.  .d88b.  d888888b
 `~~88~~' 88   I8I   88 88'     88'     `~~88~~' 88  `8D .8P  Y8. `~~88~~'
 88    88   I8I   88 88ooooo 88ooooo    88    88oooY' 88    88    88
 88    Y8   I8I   88 88~~~~~ 88~~~~~    88    88~~~b. 88    88    88
 88    `8b d8'8b d8' 88.     88.        88    88   8D `8b  d8'    88
 YP     `8b8' `8d8'  Y88888P Y88888P    YP    Y8888P'  `Y88P'     YP
 */

%group TweetbotApp

%hook PTHTweetbotStatusView

-(void)viewDidLoad {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor:TABLE_COLOR];
	}
}

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor:TABLE_COLOR];
	}
}

- (void)_updateColors {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor:TABLE_COLOR];
	}
}

%end

%hook PTHStaticSectionCell

- (void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor:VIEW_COLOR];
	}
}

- (void)colorThemeDidChange {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor:VIEW_COLOR];
	}
}

%end

%hook PTHButton

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor:VIEW_COLOR];
	}
}

- (void)colorThemeDidChange {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor:VIEW_COLOR];
	}
}

%end

%end
