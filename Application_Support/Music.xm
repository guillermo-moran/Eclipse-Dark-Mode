/*
 .88b  d88. db    db .d8888. d888888b  .o88b.
 88'YbdP`88 88    88 88'  YP   `88'   d8P  Y8
 88  88  88 88    88 `8bo.      88    8P
 88  88  88 88    88   `Y8b.    88    8b
 88  88  88 88b  d88 db   8D   .88.   Y8b  d8
 YP  YP  YP ~Y8888P' `8888Y' Y888888P  `Y88P'
*/


%group MusicApp


%hook PlayIntentControlsReusableView

-(void)layoutSubviews {
    %orig;

}

%end

%hook UITextView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setTextColor:TEXT_COLOR];
    }
}

%end


%hook _UINavigationBarContentView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor: VIEW_COLOR];
    }
}

%end

%hook _UINavigationBarLargeTitleView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor: VIEW_COLOR];
    }
}

%end

%hook UIButton

-(void)didMoveToSuperview {
    %orig;
    if (isEnabled) {
        if ([NSStringFromClass([self class]) isEqualToString:@"Music.NowPlayingTransportButton"]) {
            [self setTintColor:[UIColor blackColor]];
            applyInvertFilter((UIButton*)self);
        }
    }
}

%end

%hook MusicPlayerTimeControl

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIView* _elapsedTrack = MSHookIvar<UIView*>(self, "elapsedTrack");
        UIView* _knobView = MSHookIvar<UIView*>(self, "_knobView");

        [_elapsedTrack setBackgroundColor: selectedTintColor()];
        //[_knobView setBackgroundColor: RED_COLOR];
    }
}

%end

//MusicNavBarBGView = objc_getClass("Music.NavigationBarBackgroundView"))
%hook MusicNavBarBGView

-(void)layoutSubviews {
    %orig;
    if (isEnabled && [self respondsToSelector:@selector(setBackgroundTintColor:)]) {
        if (selectedTheme() == -1 || selectedTheme() == 0) {
            [self setBackgroundTintColor:GRAPHITE_VIEW_COLOR]; //Temporary fix
        }
    }
}

%end

%hook UIImageView



-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        if ([NSStringFromClass([self.superview class]) isEqualToString:@"Music.ArtworkComponentImageView"]) {
            [self setHidden:YES];
        }

        if ([NSStringFromClass([self.superview class]) isEqualToString:@"UIButton"]) {
            if (![[(UIButton*)self.superview title] isEqualToString:@""]) {
                [self setAlpha:0.2];
            }

        }
    }
}

//Messes with the keyboard
/*
-(void)setTintColor:(UIColor*)color {
    if (isEnabled) {
        %orig(selectedTintColor());
        return;
    }
    %orig;

}
-(UIColor*)tintColor {
    if (isEnabled) {
        return selectedTintColor();
    }
    return %orig;
}
 */

 -(void)didMoveToSuperview {

 	//Fix Controls
 	if ([NSStringFromClass([self.superview class]) isEqualToString:@"Music.NowPlayingTransportButton"]) {

 	//applyInvertFilter(self);
 	//[self setTintColor:WHITE_COLOR]
 	//[self setHidden:YES];
 	}
 	%orig;
 }

%end

%hook UILabel


- (BOOL)_textColorFollowsTintColor
{

        return NO;

}

-(UIColor *)textColor {
	if (isEnabled) {
		return [UIColor whiteColor];
	}
	return %orig;
}

-(void)setTextColor:(UIColor *)textColor {
	if (isEnabled) {
		%orig([UIColor whiteColor]);
	}
	return %orig;
}

-(void)layoutSubviews {
    self.textColor = [UIColor whiteColor];
	if ([self.superview isMemberOfClass:objc_getClass("Music.MiniPlayerButton")]) {

	}
}

%end

%hook _TtCVV5Music4Text7Drawing4View

-(id)init {

    id x = %orig;
    if (isEnabled) {
        applyInvertFilter((UIView*)self);
    }

    return x;

}

%end

%end
