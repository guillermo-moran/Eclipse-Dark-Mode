%hook UIActivityIndicatorView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setColor: INDICATOR_COLOR];
    }
}

%end