/*
  .d8b.  d8888b. d8888b. d8888b. d88888b .d8888. .d8888. d8888b. db   dD
 d8' `8b 88  `8D 88  `8D 88  `8D 88'     88'  YP 88'  YP 88  `8D 88 ,8P'
 88ooo88 88   88 88   88 88oobY' 88ooooo `8bo.   `8bo.   88oooY' 88,8P
 88~~~88 88   88 88   88 88`8b   88~~~~~   `Y8b.   `Y8b. 88~~~b. 88`8b
 88   88 88  .8D 88  .8D 88 `88. 88.     db   8D db   8D 88   8D 88 `88.
 YP   YP Y8888D' Y8888D' 88   YD Y88888P `8888Y' `8888Y' Y8888P' YP   YD
*/

%group ContactsApp

%hook UITextView

-(void)drawRect:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        if (!isLightColor(self.backgroundColor)) {

            if (![self.superview isKindOfClass:[UIImageView class]]) {

                id balloon = objc_getClass("CKBalloonTextView");

                if ([self class] == balloon) {
                    return;
                }
                else {
                    [self setBackgroundColor:[UIColor clearColor]];
                    [self setTextColor:TEXT_COLOR];
                }
            }
        }
    }
}

%end
%end

//DO NOT GROUP THIS.


//iOS 7.1+
%hook ABStyleProvider

- (id)membersBackgroundColor {
    if (isEnabled) {
        return VIEW_COLOR;
    }
    return %orig;
}

- (id)memberNameTextColor {
    if (isEnabled) {
        return TEXT_COLOR;
    }
    return %orig;

}

- (id)membersHeaderContentViewBackgroundColor {
    if (isEnabled) {
        return NAV_COLOR;
    }
    return %orig;
}


%end

%hook ABContactView

-(id)backgroundColor {
    if (isEnabled) {
        return TABLE_COLOR;
    }
    return %orig;
}

%end
