/*
 ____          _ _
 / ___|   _  __| (_) __ _
 | |  | | | |/ _` | |/ _` |
 | |__| |_| | (_| | | (_| |
 \____\__, |\__,_|_|\__,_|
 |___/
 */

%group CydiaApp

static NSString* cyJS = @"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'white'; document.getElementsByTagName('html')[0].style.backgroundColor= 'transparent'; var x = document.getElementsByTagName('fieldset'); var i; for (i = 0; i < x.length; i++) { x[i].style.backgroundColor = 'transparent'; };";



static BOOL isPaidCydiaPackage;

%hook CyteWebView

- (void)webView:(id)arg1 didFinishLoadForFrame:(id)arg2 {
	%orig;
	if (isEnabled) {
		//[self.view setBackgroundColor:[UIColor blackColor]];
		NSString *setJavaScript = cyJS;
		[arg1 stringByEvaluatingJavaScriptFromString:setJavaScript];
		//[readerWebView setBackgroundColor:[UIColor blackColor]]; // doesn't solve it
		//[self.scrollView setBackgroundColor:[UIColor blackColor]];

	}
}

-(void)layoutSubviews {
	%orig;
}


%end

%hook Package

- (bool) isCommercial {
	return %orig;
}

%end

%hook PackageCell

- (void) setPackage:(id)package asSummary:(bool)summary {

	isPaidCydiaPackage = (bool)[package isCommercial];

	%orig;
}

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

%end


%end
