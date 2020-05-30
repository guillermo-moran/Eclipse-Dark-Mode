/*
 d88888b  .d8b.   .o88b. d88888b d8888b. db   dD
 88'     d8' `8b d8P  Y8 88'     88  `8D 88 ,8P'
 88ooo   88ooo88 8P      88ooooo 88oooY' 88,8P
 88~~~   88~~~88 8b      88~~~~~ 88~~~b. 88`8b
 88      88   88 Y8b  d8 88.     88   8D 88 `88.
 YP      YP   YP  `Y88P' Y88888P Y8888P' YP   YD
 */


%group Facebook

// // %hook FBRichTextComponentView

// // -(void)layoutSubviews {
// // 	%orig;
// // 	[RED_COLOR set];
// // 	[self setColor: RED_COLOR];
// // }

// // -(void)setColor:(UIColor*)color {
// // 	[RED_COLOR set];
// // 	%orig(RED_COLOR);
// // }

// // -(UIColor*)color {
// // 	return RED_COLOR;
// // }

// // %end

// %hook FBRichTextView

// -(void)layoutSubviews {
// 	%orig;
// 	[self setColor: RED_COLOR];
// 	NSAttributedString* originalAttrStr = [self attributedString];
// 	NSString* string = [originalAttrStr string];
// 	// NSDictionary *attrs = @{ NSForegroundColorAttributeName : RED_COLOR };
// 	[originalAttrStr addAttribute:NSForegroundColorAttributeName value: RED_COLOR range:NSMakeRange(0, string.length)];
// 	// NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:string attributes:attrs];
// 	[self setAttributedString: originalAttrStr];	
// }


// -(void)setColor:(UIColor*)color {
// 	%orig(RED_COLOR);
// 	[RED_COLOR set];
// }

// -(UIColor*)color {
// 	return RED_COLOR;
// }

// %end

%end
