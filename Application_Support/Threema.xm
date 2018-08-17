/*
 d888888b db   db d8888b. d88888b d88888b .88b  d88.  .d8b.
 `~~88~~' 88   88 88  `8D 88'     88'     88'YbdP`88 d8' `8b
 88    88ooo88 88oobY' 88ooooo 88ooooo 88  88  88 88ooo88
 88    88~~~88 88`8b   88~~~~~ 88~~~~~ 88  88  88 88~~~88
 88    88   88 88 `88. 88.     88.     88  88  88 88   88
 YP    YP   YP 88   YD Y88888P Y88888P YP  YP  YP YP   YP
 */

%group ThreemaApp

@interface ChatBar : UIImageView
+ (int)perceivedBrightness:(UIColor *)aColor;
+ (UIColor *)contrastBWColor:(UIColor *)aColor;
+ (UIImage *)_imageWithColor:(UIColor *)color;
-(id)initWithFrame:(CGRect)arg1;
@end

%hook ChatBar
%new
+ (int)perceivedBrightness:(UIColor *)aColor
{
	CGFloat r = 0, g = 0, b = 0, a = 1;
	if ( [aColor getRed:&r green:&g blue:&b alpha:&a] ) {
		r=255*r; g=255*g; b=255*b;
		return (int)sqrt(r * r * .241 + g * g * .691 + b * b * .068);
	} else if ([aColor getWhite:&r alpha:&a]) {
		return (255*r);
	}
	return 255;
}

%new
+ (UIColor *)contrastBWColor:(UIColor *)aColor {
	if ( [self perceivedBrightness:aColor] > 130 ) {
		return [UIColor blackColor];
	} else {
		return [UIColor whiteColor];
	}
}

%new
+ (UIImage *)_imageWithColor:(UIColor *)color {
	CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);

	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return image;
}

-(id)initWithFrame:(CGRect)arg1 {
	self = %orig;
	if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
		//NSLog(@"ChatBar init");
		UIColor* barBgColor = NAV_COLOR; //Eclipse Theme Color
		UIColor* barTopLineColor = [[self class] contrastBWColor:selectedTintColor()]; //Eclipse tint Color
		[self setImage:[[self class] _imageWithColor:barBgColor]];
		for(UIView* view in self.subviews){
			if([view isKindOfClass:[UIImageView class]]){
				[((UIImageView *)view) setImage:nil];
			}
		}
		UIImageView* topLineView = [[UIImageView alloc] initWithImage:[[self class] _imageWithColor:barTopLineColor]];
		[topLineView setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self addSubview:topLineView];
		NSArray* constraintsDef = @[@{@"attribute": @(NSLayoutAttributeCenterX), @"multiplier": @1, @"constant": @0},
									@{@"attribute": @(NSLayoutAttributeTop), @"multiplier": @1, @"constant": @0},
									@{@"attribute": @(NSLayoutAttributeWidth), @"multiplier": @1, @"constant": @0},
									@{@"attribute": @(NSLayoutAttributeHeight), @"multiplier": @0, @"constant": @1}];
		for (NSDictionary* cDict in constraintsDef) {
			NSLayoutConstraint *myConstraint = [NSLayoutConstraint constraintWithItem:topLineView
																			attribute:[cDict[@"attribute"] integerValue]
																			relatedBy:NSLayoutRelationEqual
																			   toItem:self
																			attribute:[cDict[@"attribute"] integerValue]
																		   multiplier:[cDict[@"multiplier"] floatValue]
																			 constant:[cDict[@"constant"] floatValue]];
			myConstraint.priority = 700;
			[self addConstraint:myConstraint];
		}
		[self setNeedsUpdateConstraints];
		//NSLog(@"ChatBar init END");
	}
	return self;
}

%end

%hook TTTAttributedLabel

-(id)textColor {
	if (isEnabled) {
		return [UIColor darkGrayColor];
	}
	return %orig;
}

%end
%end
