/*
 db   dD d888888b db   dD
 88 ,8P'   `88'   88 ,8P'
 88,8P      88    88,8P
 88`8b      88    88`8b
 88 `88.   .88.   88 `88.
 YP   YD Y888888P YP   YD
 */

#import <QuartzCore/QuartzCore.h>

%group KikApp

%hook TintedUIButton

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setTag:VIEW_EXCLUDE_TAG];
		[self setBackgroundColor:WHITE_COLOR];

	}
}

%end

%hook UICollectionViewCell

-(void)layoutSubviews {
	%orig;

	if (isEnabled) {
		for (UIView* a in [self subviews]) {
			for (UIImageView* b in [a subviews]) {
				if ([b respondsToSelector:@selector(setImage:)]) {
					//b.alpha = 0.0;
				}
			}
		}
	}
}

%end

%hook KikOutgoingContentMessageCell

- (void)layoutCellSubviews {
	%orig;

	if (isEnabled) {
		UIButton* _bubbleButton = MSHookIvar<UIButton*>(self, "_bubbleButton");
		[_bubbleButton setTag:VIEW_EXCLUDE_TAG];
		_bubbleButton.layer.cornerRadius = 20;
		_bubbleButton.layer.masksToBounds = YES;

		[_bubbleButton setBackgroundColor:[UIColor clearColor]]; //Set color, even if Kik won't allow it

		UIImageView* _bubbleMask = MSHookIvar<UIImageView*>(self, "_bubbleMask");
		[_bubbleMask setHidden:YES];
	}

}

%end

%hook KikIncomingContentMessageCell

- (void)layoutCellSubviews {
	%orig;
	if (isEnabled) {
		UIButton* _bubbleButton = MSHookIvar<UIButton*>(self, "_bubbleButton");
		[_bubbleButton setTag:VIEW_EXCLUDE_TAG];
		_bubbleButton.layer.cornerRadius = 20;
		_bubbleButton.layer.masksToBounds = YES;

		[_bubbleButton setBackgroundColor:[UIColor clearColor]]; //Set color, even if Kik won't allow it


		UIImageView* _bubbleMask = MSHookIvar<UIImageView*>(self, "_bubbleMask");
		[_bubbleMask setHidden:YES];
	}
}

%end


%hook KikTextMessageCell

- (void)setupSubviews {
	%orig;

	if (isEnabled) {
		UIButton* _bubbleButton = MSHookIvar<UIButton*>(self, "_bubbleButton");
		[_bubbleButton setTag:VIEW_EXCLUDE_TAG];
		_bubbleButton.layer.cornerRadius = 20;
		_bubbleButton.layer.masksToBounds = YES;


		UIImageView* _bubbleMask = MSHookIvar<UIImageView*>(self, "_bubbleMask");
		[_bubbleMask setHidden:YES];
	}

	//_bubbleMask.layer.cornerRadius = 12;
	//_bubbleMask.layer.masksToBounds = YES;

}



%end

%hook HybridSmileyLabel

- (id)textColor {
	if (isEnabled) {
		return [UIColor darkGrayColor];
	}
	return %orig;
}


%end

%hook BlurryUIView

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor:NAV_COLOR];
	}

}
%end

%hook BlurredRawProfilePictureImageView

- (id)initWithFrame:(struct CGRect)arg1 {
	id kek = %orig;
	if (isEnabled) {
		UIColor* _blurTintColor = MSHookIvar<UIColor*>(self, "_blurTintColor");
		_blurTintColor = VIEW_COLOR;
		[self setAlpha:0.2];
	}
	return kek;
}

%end

%hook CardListTableViewCell


- (void)layoutSubviews {
	%orig;
	if (isEnabled) {
		UIImageView* backgroundImage = MSHookIvar<UIImageView*>(self, "_imgBackground");
		[backgroundImage removeFromSuperview];
	}
}

%end

%hook HPTextViewInternal

- (id)updateTextForSmileys {
	id kek = %orig;
	if (isEnabled) {
		[self setTextColor:TEXT_COLOR];
	}
	return kek;
}

-(void)setPlaceholder:(NSString *)placeholder {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor:VIEW_COLOR];
		[self setOpaque:YES];
		[self setTextColor:TEXT_COLOR];
	}
}
-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor:VIEW_COLOR];
		[self setOpaque:YES];
		[self setTextColor:TEXT_COLOR];
	}
}

-(void)setTextColor:(id)color {
	if (isEnabled) {
		%orig(TEXT_COLOR);
		return;
	}
	%orig;
}

-(id)textColor {
	if (isEnabled) {
		return TEXT_COLOR;
	}
	return %orig;
}

- (void)drawRect:(CGRect)rect {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor:VIEW_COLOR];
		[self setOpaque:YES];
		[self setTextColor:TEXT_COLOR];
	}
}


%end

%end
