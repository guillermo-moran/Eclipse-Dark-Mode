//Maps App

%group MapsApp

%hook BlurView

- (id)initWithFrame:(struct CGRect)arg1 privateStyle:(long long)arg2 {
    id blurView = %orig;

    if (isEnabled) {
        id _backdrop = MSHookIvar<id>(self, "_backdrop");
        UIView* fixView = [[UIView alloc] init];
        fixView.frame = [_backdrop frame];
        [fixView setBackgroundColor:VIEW_COLOR];
        [_backdrop addSubview:fixView];
        [fixView release];
    }
    return blurView;
}

%end

%end
