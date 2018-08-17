/*
 .d8888. d8b   db d8888b.  .o88b. db      d8888b.
 88'  YP 888o  88 88  `8D d8P  Y8 88      88  `8D
 `8bo.   88V8o 88 88   88 8P      88      88   88
 `Y8b. 88 V8o88 88   88 8b      88      88   88
 db   8D 88  V888 88  .8D Y8b  d8 88booo. 88  .8D
 `8888Y' VP   V8P Y8888D'  `Y88P' Y88888P Y8888D'
 */

%group SoundcloudApp

%hook SCTrackActivityMiniView

- (void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor:VIEW_COLOR];
	}

}

%end
%end
