/*
 d88888b  .d8b.   .o88b. d88888b d8888b. db   dD
 88'     d8' `8b d8P  Y8 88'     88  `8D 88 ,8P'
 88ooo   88ooo88 8P      88ooooo 88oooY' 88,8P
 88~~~   88~~~88 8b      88~~~~~ 88~~~b. 88`8b
 88      88   88 Y8b  d8 88.     88   8D 88 `88.
 YP      YP   YP  `Y88P' Y88888P Y8888P' YP   YD
 */


%group Facebook

%hook FBRichTextComponentView

-(id)init {
	id orig = %orig;
	if (isEnabled) {
		applyInvertFilter((UIView*)self);
	}
	return orig;
}

%end

%end
