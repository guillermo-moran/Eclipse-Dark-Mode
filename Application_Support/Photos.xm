%hook PUPhotosSectionHeaderView

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		id backdrop = MSHookIvar<id>(self, "_backdropView");
		[backdrop setHidden:YES];
		[self setBackgroundColor:TABLE_COLOR];
	}
}

%end

%hook PXRoundedCornerOverlayView

- (id)overlayColor {
	return VIEW_COLOR;
}

%end
