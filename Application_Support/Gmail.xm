%group GMail

%hook GBTOpenSearchBarGradientView

// -(id)initWithAlpha:(CGFloat)a {
// 	if (isEnabled) {
// 		a = 0;
// 	}
// 	return %orig(a);
// }

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setHidden: true];
	}
}
%end

%hook UILabel

-(id)init {
	id x = %orig;
	if (isEnabled) {
		[self setTextColor: TEXT_COLOR];
	}
	return x;
}

-(UIColor*)textColor {
	if (isEnabled) {
		return TEXT_COLOR;
	}
	return %orig;
}

-(void)setTextColor:(UIColor*)color {
	UIColor* c = color;
	if (isEnabled) {
		color = TEXT_COLOR;
	}
	%orig(color);
}

%end

%end
