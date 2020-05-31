/*
 d8b   db  .d88b.  d888888b d88888b .d8888.
 888o  88 .8P  Y8. `~~88~~' 88'     88'  YP
 88V8o 88 88    88    88    88ooooo `8bo.
 88 V8o88 88    88    88    88~~~~~   `Y8b.
 88  V888 `8b  d8'    88    88.     db   8D
 VP   V8P  `Y88P'     YP    Y88888P `8888Y'
*/




%group NotesApp

%hook UITableViewCellContentView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIColor* original = (UIColor*)[self backgroundColor];
        UIColor* newColor = createEclipseDynamicColor(original, TABLE_COLOR);
        [self setBackgroundColor: newColor];
    }
}

%end

%hook UISearchBar

-(void)drawRect:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        UIColor* original = (UIColor*)[self backgroundColor];
        UIColor* newColor = createEclipseDynamicColor(original, TABLE_COLOR);
        [self setBackgroundColor: newColor];
    }
}

%end

%hook ICNotesListTableViewCell

-(void)drawRect:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        UIColor* original = (UIColor*)[self backgroundColor];
        UIColor* newColor = createEclipseDynamicColor(original, TABLE_COLOR);
        [self setBackgroundColor: newColor];
    }
}

%end

%hook ICNoteContainerTableViewCell

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIColor* original = (UIColor*)[self backgroundColor];
        UIColor* newColor = createEclipseDynamicColor(original, TABLE_COLOR);
        [self setBackgroundColor: newColor];
    }
}

%end

%hook NotesTextureView

-(void)drawRect:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        UIColor* original = (UIColor*)[self backgroundColor];
        UIColor* newColor = createEclipseDynamicColor(original, VIEW_COLOR);
        [self setBackgroundColor: newColor];
    }
}

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIColor* original = (UIColor*)[self backgroundColor];
        UIColor* newColor = createEclipseDynamicColor(original, VIEW_COLOR);
        [self setBackgroundColor: newColor];
    }
}

%end

// // /*
// // %hook UIColor
// // //such hacky
// //
// // +(id)colorWithWhite:(float)arg1 alpha:(float)arg2 {
// //
// //     id color = %orig;
// //
// //     if (isEnabled) {
// //         if (arg1 < .5) {
// //             return TEXT_COLOR;
// //         }
// //     }
// //     return %orig;
// // }
// // %end


// //

// %hook ICNoteEditorToolbarPlusView

// -(id)plainView {
//     id view = %orig;
//     if (isEnabled) {
//         [view setBackgroundColor: VIEW_COLOR];
//     }
//     return view;
// }

// -(id)plusView {
//     id view = %orig;
//     if (isEnabled) {
//         [view setBackgroundColor: TEXT_COLOR];
//     }
//     return view;
// }

// %end

// %hook _UIBarBackground

// -(void)layoutSubviews {
//     %orig;
//     if (isEnabled) {
//         [self setAlpha:0];
//     }
// }

// %end

// %hook _UITextContainerView

// static BOOL hasInvertedTextContainer = false;

// -(void)layoutSubviews {
//     %orig;
//     if (isEnabled && !hasInvertedTextContainer) {
//         applyInvertFilter((UIView*)self);
//         hasInvertedTextContainer = true;
//     }
// }

// %end

// %hook _UINavigationBarBackground

// -(void)layoutSubviews {
//     %orig;
//     if (isEnabled) {
//         [self setBackgroundColor:NAV_COLOR];
//     }
// }

// %end

// %hook NotesTextureView

// -(void)layoutSubviews {
//     %orig;
//     if (isEnabled) {
//         //[self removeFromSuperview];
// 		[self setBackgroundColor:NAV_COLOR];
//     }
// }

// %end

%end
