
%group TwitterApp

%hook UIColor

+ (id)tfn_cellAccessoryColor {
	id orig = %orig;
	if (isEnabled) {
		return createEclipseDynamicColor(orig, TINT_COLOR);
	}
	return orig;
}
+ (id)tfn_selectedCheckmarkColor {
	id orig = %orig;
	if (isEnabled) {
		return createEclipseDynamicColor(orig, TINT_COLOR);
	}
	return orig;
}
+ (id)tfn_dataViewModalBackgroundColor {
	id orig = %orig;
	if (isEnabled) {
		return createEclipseDynamicColor(orig, VIEW_COLOR);
	}
	return orig;
}
+ (id)tfn_dataViewBackgroundColor {
	id orig = %orig;
	if (isEnabled) {
		return createEclipseDynamicColor(orig, VIEW_COLOR);
	}
	return orig;
}
+ (id)tfn_groupedCellBorderColor {
	id orig = %orig;
	if (isEnabled) {
		return createEclipseDynamicColor(orig, TABLE_COLOR);
	}
	return orig;
}
+ (id)tfn_cellSeparatorColor {
	id orig = %orig;
	if (isEnabled) {
		return createEclipseDynamicColor(orig, TABLE_SEPARATOR_COLOR);
	}
	return orig;
}
+ (id)tfn_highlightCellBackgroundColor {
	id orig = %orig;
	if (isEnabled) {
		return createEclipseDynamicColor(orig, TINT_COLOR);
	}
	return orig;
}
+ (id)tfn_cellBackgroundColor {
	id orig = %orig;
	if (isEnabled) {
		return createEclipseDynamicColor(orig, TABLE_COLOR);
	}
	return orig;
}

%end

%end
