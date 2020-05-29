/*
 db    db d888888b  .o88b.  .d88b.  db       .d88b.  d8888b.
 88    88   `88'   d8P  Y8 .8P  Y8. 88      .8P  Y8. 88  `8D
 88    88    88    8P      88    88 88      88    88 88oobY'
 88    88    88    8b      88    88 88      88    88 88`8b
 88b  d88   .88.   Y8b  d8 `8b  d8' 88booo. `8b  d8' 88 `88.
 ~Y8888P' Y888888P  `Y88P'  `Y88P'  Y88888P  `Y88P'  88   YD
*/

// AUTO REPLACE COLOR BETA

%group AutoReplaceColor

%hook UIColor
//such hacky

+(id)blackColor {
    if (isEnabled) {
        return TEXT_COLOR;
    }
    return %orig;
}

+(id)colorWithRed:(double)red green:(double)green blue:(double)blue alpha:(double)alpha {

    if (isEnabled) {
        if ((red == 0.0) && (green == 0.0) && (blue == 0.0) && (alpha < 0.7)) {
            return TEXT_COLOR;
        }
    }
    return %orig;
}

+(id)colorWithWhite:(float)arg1 alpha:(float)arg2 {

    id color = %orig;

    if (isEnabled) {
        if ((arg1 < .5)) {
            return [TEXT_COLOR colorWithAlphaComponent:0.4];
        }
    }
    return %orig;
}
%end

%hook UIImageView

-(void)layoutSubviews {
    %orig;

    if (isEnabled) {
        if ([UIColor color:[UIColor getDominantColor:self.image] isEqualToColor:[UIColor whiteColor] withTolerance:0.5]) {
            //if ([UIColor color:[self.image averageColor] isEqualToColor:[UIColor whiteColor] withTolerance:0.9]) {

            //self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            //[self setTintColor:VIEW_COLOR];

            [self setAlpha:0.3];
        }

    }

}
%end
%end

// REPLACE SYSTEM COLORS

%group SystemUIColors

%hook UIColor

static BOOL bazziInstalled = [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/Bazzi.dylib"] || [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/Bazzi2.dylib"];

+(UIColor*)systemGreenColor {
    if (isEnabled && (selectedTintColor() != WHITE_COLOR) && !bazziInstalled) {
        return selectedTintColor();
    }
    return %orig;
}

+(UIColor*)systemBlueColor {
    if (isEnabled) {
        return selectedTintColor();
    }
    return %orig;
}


// System Colors

// Thanks for this one @skittyblock
// + (id)colorWithRed:(double)red green:(double)green blue:(double)blue alpha:(double)alpha {
//     UIColor* orig = %orig(red, green, blue, alpha);
// 	if (red == 0.0 && green == 122.0/255.0 && blue == 1.0) {
// 		return createEclipseDynamicColor(orig, VIEW_COLOR);
// 	}
// 	return %orig;
// }

// // Default tint
// + (id)systemBlueColor {
// 	return (getPrefBool(@"customTintColor") || currentProfile[@"tintColor"]) ? tint : %orig;
// }
// + (id)_systemBlueColor2 {
// 	return (getPrefBool(@"customTintColor") || currentProfile[@"tintColor"]) ? tint : %orig;
// }

// // Selection point
// + (id)insertionPointColor {
// 	return (getPrefBool(@"customTintColor") || currentProfile[@"tintColor"]) ? tint : %orig;
// }
// // Selection highlight
// + (id)selectionHighlightColor {
// 	return (getPrefBool(@"customTintColor") || currentProfile[@"tintColor"]) ? highlight : %orig;
// }
// // Selection grabbers
// + (id)selectionGrabberColor {
// 	return (getPrefBool(@"customTintColor") || currentProfile[@"tintColor"]) ? tint : %orig;
// }
// // Links
// + (id)linkColor {
// 	return (getPrefBool(@"customTintColor") || currentProfile[@"tintColor"]) ? tint : %orig;
// }

// Primary color
+ (id)systemBackgroundColor {
    UIColor* orig = %orig;
	return createEclipseDynamicColor(orig, VIEW_COLOR);
}
+ (id)systemGroupedBackgroundColor {
    UIColor* orig = %orig;
	return createEclipseDynamicColor(orig, TABLE_COLOR);
}
+ (id)groupTableViewBackgroundColor {
    UIColor* orig = %orig;
	return createEclipseDynamicColor(orig, TABLE_COLOR);
}
+ (id)tableBackgroundColor {
    UIColor* orig = %orig;
	return createEclipseDynamicColor(orig, TABLE_COLOR);
}
+ (id)tableCellPlainBackgroundColor {
    UIColor* orig = %orig;
	return createEclipseDynamicColor(orig, VIEW_COLOR);
}
+ (id)tableCellGroupedBackgroundColor {
    UIColor* orig = %orig;
	return createEclipseDynamicColor(orig, TABLE_COLOR);
}

// Secondary color
+ (id)secondarySystemBackgroundColor {
    UIColor* orig = %orig;
	return createEclipseDynamicColor(orig, VIEW_COLOR);
}
+ (id)secondarySystemGroupedBackgroundColor {
    UIColor* orig = %orig;
	return createEclipseDynamicColor(orig, VIEW_COLOR);
}

// Tertiary color
+ (id)tertiarySystemBackgroundColor {
    UIColor* orig = %orig;
	return createEclipseDynamicColor(orig, VIEW_COLOR);
}
+ (id)tertiarySystemGroupedBackgroundColor {
    UIColor* orig = %orig;
	return createEclipseDynamicColor(orig, VIEW_COLOR);
}

// Separator color
// + (id)separatorColor {
// 	return dynamicColorWithOptions(%orig, @"lightSeparatorColor", @"darkSeparatorColor");
// }
// + (id)opaqueSeparatorColor {
// 	return dynamicColorWithOptions(%orig, @"lightSeparatorColor", @"darkSeparatorColor");
// }
// + (id)tableSeparatorColor {
// 	return dynamicColorWithOptions(%orig, @"lightSeparatorColor", @"darkSeparatorColor");
// }

// Label colors
// + (id)labelColor {
// 	return dynamicColorWithOptions(%orig, @"lightLabelColor", @"darkLabelColor");
// }
// + (id)secondaryLabelColor {
// 	return dynamicColorWithOptions(%orig, @"lightSecondaryLabelColor", @"darkSecondaryLabelColor");
// }
// + (id)placeholderLabelColor {
// 	return dynamicColorWithOptions(%orig, @"lightPlaceholderLabelColor", @"darkPlaceholderLabelColor");
// }
// + (id)tertiaryLabelColor {
// 	return dynamicColorWithOptions(%orig, @"lightTertiaryLabelColor", @"darkTertiaryLabelColor");
// }

// + (id)tablePlainHeaderFooterBackgroundColor {
// 	return dynamicColorWithOptions(%orig, @"lightTertiaryLabelColor", @"darkTertiaryLabelColor");
// }

// UITableViewCell selection color
// + (id)systemGray4Color {
// 	return dynamicColorWithOptions(%orig, @"lightTableViewCellSelectionColor", @"darkTableViewCellSelectionColor");
// }
// + (id)systemGray5Color {
// 	return dynamicColorWithOptions(%orig, @"lightTableViewCellSelectionColor", @"darkTableViewCellSelectionColor");
// }


%end
%end

