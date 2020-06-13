/*
 ____          _ _
 / ___| _  __| (_) __ _
 | |  | | | |/ _` | |/ _` |
 | |__| |_| | (_| | | (_| |
 \____\__, |\__,_|_|\__,_|
 |		___/
 */

extern "C" void UISetColor(CGColorRef color);

%group CydiaApp

// static NSString* cyJS = @"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'white'; document.getElementsByTagName('html')[0].style.backgroundColor= 'transparent'; var x = document.getElementsByTagName('fieldset'); var i; for (i = 0; i < x.length; i++) { x[i].style.backgroundColor = 'transparent'; };";

static BOOL isPaidCydiaPackage;

%hook UIView

-(void)layoutSubviews {
	%orig;
	if (isEnabled && isLightColor(self.backgroundColor) && ![self.backgroundColor isEqual:[UIColor clearColor]]) {
        [self setBackgroundColor: VIEW_COLOR];
    }
}

-(UIColor*)backgroundColor {
	UIColor* color = %orig;
	if (isEnabled && isLightColor(color) && ![color isEqual:[UIColor clearColor]]) {
        return VIEW_COLOR;
    }
	return color;
}

%end

%hook UITabBar

-(UIColor *)unselectedItemTintColor {
    UIColor* originalColor = %orig;
	if (isEnabled) {
		return createEclipseDynamicColor(originalColor, [UIColor whiteColor]);
	}
	return %orig;
}

// -(void)layoutSubviews {
// 	%orig;
// 	if (isEnabled) {
// 		[self setUnselectedItemTintColor: [UIColor whiteColor]];
// 	}
// }

%end

%hook _UIBarBackground

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor: NAV_COLOR];
	}
}

%end

%hook UILabel 

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setTextColor: TEXT_COLOR];
	}
}

-(UIColor*)textColor {
	if (isEnabled) {
		return TEXT_COLOR;
	}
	return %orig;
}

-(void)setTextColor:(UIColor*)color {
	if (isEnabled) {
		%orig(TEXT_COLOR);
	}
	return %orig;
}

%end

%hook UIWebScrollView

-(id)init {
	id x = %orig;
	[self setBackgroundColor: VIEW_COLOR];
	return x;
}

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor: VIEW_COLOR];
	}
}

%end

%hook CyteTableViewCellContentView

-(id)init {
	id x = %orig;
	if (isEnabled) {
		[self setBackgroundColor: TABLE_COLOR];
	}
	return x;
}

-(void)didMoveToWindow {
	%orig;
	[self setBackgroundColor: TABLE_COLOR];
}

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor: TABLE_COLOR];
	}
}

-(void)setBackgroundColor:(UIColor*)color {
	if (isEnabled) {
		%orig(TABLE_COLOR);
		return;
	}
	%orig;
}

-(id)backgroundColor {
	if (isEnabled) {
		return TABLE_COLOR;
	}
	return %orig;
}

%end

%hook CyteWebView

- (void)webView:(id)arg1 didFinishLoadForFrame:(id)arg2 {
	%orig;
	if (isEnabled) {
		//[self.view setBackgroundColor:[UIColor blackColor]];
		NSString *setJavaScript = darkCydiaJS;
		[arg1 stringByEvaluatingJavaScriptFromString:setJavaScript];
		//[readerWebView setBackgroundColor:[UIColor blackColor]]; // doesn't solve it
		// [self.scrollView setBackgroundColor:[UIColor blackColor]];
		[self setBackgroundColor: VIEW_COLOR];
	}
}

-(void)layoutSubviews {
	%orig;
}


%end

%hook _UITableViewCellHeaderFooterContentView

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor: VIEW_COLOR];
	}
}

%end

%hook UITableViewIndex

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setBackgroundColor: [UIColor clearColor]];
	}
}

-(UIColor*)backgroundColor {
	if (isEnabled) {
		return [UIColor clearColor];
	}
	return %orig;
}

%end

%hook UITableViewCell 

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
        [self setBackgroundColor: TABLE_COLOR];
    }
}

-(UIColor*)backgroundColor {
	UIColor* color = %orig;
	if (isEnabled) {
        return TABLE_COLOR;
    }
	return color;
}

%end

%hook PackageCell

- (void) setPackage:(id)package asSummary:(bool)summary {
	isPaidCydiaPackage = (bool)[package isCommercial];
	%orig;
}

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
        [self setBackgroundColor: TABLE_COLOR];
    }
}

-(UIColor*)backgroundColor {
	UIColor* color = %orig;
	if (isEnabled) {
        return TABLE_COLOR;
    }
	return color;
}

// - (void) drawSummaryContentRect:(CGRect)rect {
// 	%orig;
// 	if (isEnabled) {
// 		UISetColor([UIColor redColor].CGColor);
// 	}
// }

// - (void) drawNormalContentRect:(CGRect)rect {
// 	%orig;
// 	if (isEnabled) {
// 		UISetColor([UIColor redColor].CGColor);
// 	}
// }

%end

%hook NSString

-(CGSize)drawAtPoint:(CGPoint)arg1 forWidth:(double)arg2 withFont:(id)arg3 lineBreakMode:(long long)arg4 {

	// if (isPaidCydiaPackage) {
	//   [selectedTintColor() set];
	// }
	//else {
	if (isEnabled) {
		[TEXT_COLOR set];
	}
	//}
	return %orig;
}

%end

%hook UISearchBarTextField

-(UIColor*)backgroundColor {
	if (isEnabled) {
		return VIEW_COLOR;
	}
	return %orig;
}

-(void)layoutSubviews {
	%orig;
	if (isEnabled) {
		[self setTextColor: TEXT_COLOR];
	}
}

%end


%end
