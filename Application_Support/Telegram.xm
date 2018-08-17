/*
 d888888b d88888b db      d88888b  d888b  d8888b.  .d8b.  .88b  d88.
 `~~88~~' 88'     88      88'     88' Y8b 88  `8D d8' `8b 88'YbdP`88
 88    88ooooo 88      88ooooo 88      88oobY' 88ooo88 88  88  88
 88    88~~~~~ 88      88~~~~~ 88  ooo 88`8b   88~~~88 88  88  88
 88    88.     88booo. 88.     88. ~8~ 88 `88. 88   88 88  88  88
 YP    Y88888P Y88888P Y88888P  Y888P  88   YD YP   YP YP  YP  YP
 */

%group TelegramApp

%hook TGBackdropView

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor:NAV_COLOR];
	}
}

%end

%hook TGContactCellContents

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		for (id meh in [self subviews]) {
			if ([meh respondsToSelector:@selector(setTextColor:)]) {
				[meh setTextColor:TEXT_COLOR];
			}
		}
	}

}

%end

%end
