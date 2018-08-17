/*
 d8b   db  .d88b.  d888888b d88888b .d8888.
 888o  88 .8P  Y8. `~~88~~' 88'     88'  YP
 88V8o 88 88    88    88    88ooooo `8bo.
 88 V8o88 88    88    88    88~~~~~   `Y8b.
 88  V888 `8b  d8'    88    88.     db   8D
 VP   V8P  `Y88P'     YP    Y88888P `8888Y'
*/




%group NotesApp

/*
%hook UIColor
//such hacky

+(id)colorWithWhite:(float)arg1 alpha:(float)arg2 {

    id color = %orig;

    if (isEnabled) {
        if (arg1 < .5) {
            return TEXT_COLOR;
        }
    }
    return %orig;
}
%end

*/
// 
// %hook _UITextContainerView
//
// -(void)layoutSubviews {
//     %orig;
//     if (isEnabled) {
//         applyInvertFilter((UIView*)self);
//     }
// }
//
// %end

%hook _UINavigationBarBackground

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setBackgroundColor:NAV_COLOR];
    }
}

%end

%hook NotesTextureView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        //[self removeFromSuperview];
		[self setBackgroundColor:NAV_COLOR];
    }
}

%end

%end
