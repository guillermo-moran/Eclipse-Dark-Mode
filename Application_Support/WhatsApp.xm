/*
 db   d8b   db db   db  .d8b.  d888888b .d8888.  .d8b.  d8888b. d8888b.
 88   I8I   88 88   88 d8' `8b `~~88~~' 88'  YP d8' `8b 88  `8D 88  `8D
 88   I8I   88 88ooo88 88ooo88    88    `8bo.   88ooo88 88oodD' 88oodD'
 Y8   I8I   88 88~~~88 88~~~88    88      `Y8b. 88~~~88 88~~~   88~~~
 `8b d8'8b d8' 88   88 88   88    88    db   8D 88   88 88      88
 `8b8' `8d8'  YP   YP YP   YP    YP    `8888Y' YP   YP 88      88
 */


%group WhatsappApp

%hook WAActionSheetButton

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor: VIEW_COLOR];
    }
}

%end

%hook WALabel

-(id)initWithFrame:(CGRect)frame {
   id meh = %orig;

   if (isEnabled) {

	   [self setTextColor:RED_COLOR];
   }
   return meh;
}

%end

%hook WATextMessageCell

-(void)layoutSubviews {
   %orig;
   if (isEnabled) {
	   for (UILabel* label in [[self contentView] subviews]) {
		   if ([(UILabel*)label respondsToSelector:@selector(setTextColor:)]) {

			   //Random Color
			   /*
				NSArray* availableColors = @[BABY_BLUE_COLOR, PINK_COLOR, DARK_ORANGE_COLOR, GREEN_COLOR, PURPLE_COLOR, RED_COLOR, YELLOW_COLOR];

				UIColor* rand = availableColors.count == 0 ? nil : availableColors[arc4random_uniform(availableColors.count)];
				*/

			   [label setTextColor:RED_COLOR];
		   }
	   }
   }
}

%end

%hook WAInputTextView

-(void)drawRect:(CGRect)arg1 {
   %orig;

   if (isEnabled) {
	   [self setTextColor:TEXT_COLOR];

   }

}

%end


%hook WAChatBar

-(void)layoutSubviews {
   %orig;
   if (isEnabled) {
	   UIButton* _sendButton = MSHookIvar<UIButton*>(self, "_sendButton");
	   UIButton* _attachMediaButton = MSHookIvar<UIButton*>(self, "_attachMediaButton");
	   UIButton* _cameraButton = MSHookIvar<UIButton*>(self, "_cameraButton");
	   UIButton* _pttButton = MSHookIvar<UIButton*>(self, "_pttButton");

	   [_sendButton setTintColor:selectedTintColor()];
	   [_attachMediaButton setTintColor:selectedTintColor()];
	   [_cameraButton setTintColor:selectedTintColor()];
	   [_pttButton setTintColor:selectedTintColor()];
   }

}

%end

%hook WAMessageFooterView

- (void)layoutSubviews {
   %orig;
   if (isEnabled) {
	   UILabel* _timestampLabel = MSHookIvar<UILabel*>(self, "_timestampLabel");
	   [_timestampLabel setTextColor:RED_COLOR];
   }
}

%end

%hook WAEventBubbleView

- (void)layoutSubviews {
   %orig;
   if (isEnabled) {
	   UILabel* labelEvent = MSHookIvar<UILabel*>(self, "_labelEvent");
	   [labelEvent setTextColor:RED_COLOR];
   }
}

%end

%hook WADateBubbleView

- (void)layoutSubviews {
   %orig;
   if (isEnabled) {
	   UILabel* titleLabel = MSHookIvar<UILabel*>(self, "_titleLabel");
	   [titleLabel setTextColor:RED_COLOR];
   }


}

%end

%hook WAChatButton

-(void)layoutSubviews {
   %orig;
   if (isEnabled) {
	   [self setTintColor:selectedTintColor()];
   }
}

%end

%hook WAChatSessionCell

-(void)layoutSubviews {
   %orig;
   if (isEnabled) {
	   UILabel* messageLabel = MSHookIvar<UILabel*>(self, "_messageLabel");
	   if (shouldColorDetailText()) {
		   //[messageLabel setTextColor:selectedTintColor()];
	   }
	   else {
		   //[messageLabel setTextColor:TEXT_COLOR];
	   }
   }
}

%end

%hook WAContactNameLabel

- (id)textColor {
   if (isEnabled) {
	   [self setBackgroundColor:[UIColor clearColor]];
	   return TEXT_COLOR;
   }
   return %orig;
}

- (void)setTextColor:(id)fp8 {
   if (isEnabled) {
	   %orig(TEXT_COLOR);
	   [self setBackgroundColor:[UIColor clearColor]];
	   return;
   }
   %orig;
}

%end
/*
 %hook _WANoBlurNavigationBar

 - (void)layoutSubviews {
 %orig;
 if (isEnabled) {
 UIView* bgView = MSHookIvar<UIView*>(self, "_grayBackgroundView");
 [bgView setBackgroundColor:NAV_COLOR];
 }

 }

 - (id)initWithFrame:(struct CGRect)arg1 {
 id bar = %orig;
 if (isEnabled) {
 UIView* bgView = MSHookIvar<UIView*>(self, "_grayBackgroundView");
 [bgView setBackgroundColor:NAV_COLOR];
 }
 return bar;
 }

 %end
 */

 %end
