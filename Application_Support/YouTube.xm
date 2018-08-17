/*
 __   __         _____      _
 \ \ / /__  _   |_   _|   _| |__   ___
 \ V / _ \| | | || || | | | '_ \ / _ \
 | | (_) | |_| || || |_| | |_) |  __/
 |_|\___/ \__,_||_| \__,_|_.__/ \___|
 */

//%group YouTubeApp

%hook YTFeedHeaderView

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		for (UIImageView* imgView in [self subviews]) {
			imgView.alpha = 0.2;
		}
	}
}

%end

%hook YTFormattedStringLabel

-(void)setBounds:(CGRect)arg1 {
	%orig;

	if (isEnabled) {
		[self setTextColor:TEXT_COLOR];


	}
}

-(void)setFrame:(CGRect)arg1 {
	%orig;

	if (isEnabled) {
		[self setTextColor:TEXT_COLOR];


	}
}


- (void)didMoveToSuperview {

	%orig;

	if (isEnabled) {
		[self setTextColor:TEXT_COLOR];


	}

}

%end
