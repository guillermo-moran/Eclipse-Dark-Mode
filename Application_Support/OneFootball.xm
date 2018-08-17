%group OneFootball

%hook UITextView

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setTextColor:TEXT_COLOR];
	}
}

%end

%hook ILStyleLabel

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setTextColor:TEXT_COLOR];
	}
}

%end

%end
