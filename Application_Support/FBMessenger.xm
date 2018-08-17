/*
 d88888b  .d8b.   .o88b. d88888b d8888b. db   dD
 88'     d8' `8b d8P  Y8 88'     88  `8D 88 ,8P'
 88ooo   88ooo88 8P      88ooooo 88oooY' 88,8P
 88~~~   88~~~88 8b      88~~~~~ 88~~~b. 88`8b
 88      88   88 Y8b  d8 88.     88   8D 88 `88.
 YP      YP   YP  `Y88P' Y88888P Y8888P' YP   YD
 */


%group FBMessenger


// %hook FBRichTextComponentView
//
// -(id)init {
// 	id x = %orig;
// 	if (isEnabled) {
// 		applyInvertFilter((UIView*)self);
// 	}
// 	return x;
// }
//
// %end


%hook FBRichTextView

-(id)init {
	id x = %orig;
	if (isEnabled) {
		applyInvertFilter((UIView*)self);
	}
	return x;
}

%end

%hook MNComposerBar

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		UIView* bgView = MSHookIvar<UIView*>(self, "_backgroundView");
		[bgView setBackgroundColor: NAV_COLOR];

	}
}

%end

%hook MNMaskedProfileImageView

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {

		for (UIImageView* view in [self subviews]) {
			if ([view respondsToSelector:@selector(setImage:)]) {
				view.alpha = 0;
			}
		}

	}
}

%end

@interface MNThreadCollectionProfileImageView : UIView
@end

%hook MNThreadCollectionProfileImageView

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {

		for (UIImageView* view in [self subviews]) {
			if ([view respondsToSelector:@selector(setImage:)]) {
				view.alpha = 0;
			}
		}

	}
}

%end

%hook MNProfileImageView
-(void)layoutSubviews {
	%orig;

	if (isEnabled) {
		NSMutableArray* _imageViews = MSHookIvar<NSMutableArray*>(self, "_imageViews");

		for (UIImageView* view in _imageViews) {
			view.layer.cornerRadius = view.frame.size.width / 2;
			view.clipsToBounds = YES;
			view.layer.borderWidth = 1.0f;
			view.layer.borderColor = selectedTintColor().CGColor;
		}
	}

}

%end

/*
 %hook MNBadgedProfileImageView

 - (void)layoutSubviews {
 %orig;
 if (isEnabled) {
 UIImageView* _maskImageView = MSHookIvar<UIImageView*>(self, "_maskImageView");
 [_maskImageView  setHidden:YES];

 UIImageView* _profileImageView = MSHookIvar<UIImageView*>(self, "_profileImageView");

 _profileImageView.layer.cornerRadius = _profileImageView.frame.size.width / 2;
 _profileImageView.clipsToBounds = YES;
 _profileImageView.layer.borderWidth = 1.0f;
 _profileImageView.layer.borderColor = selectedTintColor().CGColor;
 }
 }

 %end
 */

%hook MNGroupItemView

- (void)layoutSubviews {
	%orig;
	if (isEnabled) {
		UIImageView* _backgroundImageView = MSHookIvar<UIImageView*>(self, "_backgroundImageView");
		_backgroundImageView.image = nil;

		UIImageView* _groupImageMaskView = MSHookIvar<UIImageView*>(self, "_groupImageMaskView");
		_groupImageMaskView.image = nil;
	}
}


%end

%hook MNSettingsUserInfoCell

- (void)layoutSubviews {
	%orig;
	if (isEnabled) {
		UIImageView* _messengerBadge = MSHookIvar<UIImageView*>(self, "_messengerBadge");
		_messengerBadge.image = nil;

		UIImageView* _profilePhotoView = MSHookIvar<UIImageView*>(self, "_profilePhotoView");
		_profilePhotoView.layer.cornerRadius = _profilePhotoView.frame.size.width / 2;
		_profilePhotoView.clipsToBounds = YES;
		_profilePhotoView.layer.borderWidth = 1.0f;
		_profilePhotoView.layer.borderColor = selectedTintColor().CGColor;
	}
}

%end

// %hook FBTextView
//
// -(void)setFrame:(CGRect)arg1 {
// 	%orig;
//
// 	[self setTextColor:TEXT_COLOR];
// }
//
// %end

%hook MNPeopleCell

- (void)layoutSubviews {
	%orig;
	if (isEnabled) {
		for (UIImageView* view in [[self contentView] subviews]) {
			if ([view respondsToSelector:@selector(setImage:)]) {

				view.layer.cornerRadius = view.frame.size.width / 2;
				view.clipsToBounds = YES;
				view.layer.borderWidth = 1.0f;
				view.layer.borderColor = selectedTintColor().CGColor;

			}
		}
	}

}

%end

%hook MNThreadCell

- (void)layoutSubviews {
	%orig;
	if (isEnabled) {
		UIImageView* _presenceIndicator = MSHookIvar<UIImageView*>(self, "_presenceIndicator");
		//_presenceIndicator.image = nil;

		_presenceIndicator.layer.cornerRadius = _presenceIndicator.frame.size.width / 2;
		_presenceIndicator.clipsToBounds = YES;
		_presenceIndicator.layer.borderWidth = 1.0f;
		_presenceIndicator.layer.borderColor = [UIColor clearColor].CGColor;
	}

}

%end

%end
