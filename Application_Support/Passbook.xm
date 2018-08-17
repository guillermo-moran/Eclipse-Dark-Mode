/*
 d8888b.  .d8b.  .d8888. .d8888. d8888b.  .d88b.   .d88b.  db   dD
 88  `8D d8' `8b 88'  YP 88'  YP 88  `8D .8P  Y8. .8P  Y8. 88 ,8P'
 88oodD' 88ooo88 `8bo.   `8bo.   88oooY' 88    88 88    88 88,8P
 88~~~   88~~~88   `Y8b.   `Y8b. 88~~~b. 88    88 88    88 88`8b
 88      88   88 db   8D db   8D 88   8D `8b  d8' `8b  d8' 88 `88.
 88      YP   YP `8888Y' `8888Y' Y8888P'  `Y88P'   `Y88P'  YP   YD
*/

%group PassbookApp

%hook WLEasyToHitCustomView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        for (UIView* button in [self subviews]) {
            if ([button isKindOfClass:[UIButton class]]) {
                [button setBackgroundColor:[UIColor clearColor]];
            }
        }
    }
}

%end

%end
