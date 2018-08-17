/*
 db   dD d88888b db    db d8888b.  .d88b.   .d8b.  d8888b. d8888b.
 88 ,8P' 88'     `8b  d8' 88  `8D .8P  Y8. d8' `8b 88  `8D 88  `8D
 88,8P   88ooooo  `8bd8'  88oooY' 88    88 88ooo88 88oobY' 88   88
 88`8b   88~~~~~    88    88~~~b. 88    88 88~~~88 88`8b   88   88
 88 `88. 88.        88    88   8D `8b  d8' 88   88 88 `88. 88  .8D
 YP   YD Y88888P    YP    Y8888P'  `Y88P'  YP   YP 88   YD Y8888D'
*/

%hook UIKeyboardDockView

-(void)layoutSubviews {
    %orig;
    if (isEnabled && darkenKeyboard()) {
        [self setBackgroundColor:keyboardColor()];
    }
}

%end

%hook UITextInputTraits


-(int)keyboardAppearance {
    if (isEnabled && darkenKeyboard()) {
        return 0;
    }
    return %orig;
}


%end


%hook UIKBRenderConfig

-(BOOL)lightKeyboard {
    if (isEnabled && darkenKeyboard()) {
        return NO;
    }
    return %orig;
}


%end


%hook UIKeyboard

-(id)initWithFrame:(CGRect)arg1 {
    id meow = %orig;
    if (isEnabled && darkenKeyboard()) {
        [self setBackgroundColor:keyboardColor()];
    }
    return meow;
}

%end
