/*
 db    db d888888b db       .d8b.  d8888b. d88888b db
 88    88   `88'   88      d8' `8b 88  `8D 88'     88
 88    88    88    88      88ooo88 88oooY' 88ooooo 88
 88    88    88    88      88~~~88 88~~~b. 88~~~~~ 88
 88b  d88   .88.   88booo. 88   88 88   8D 88.     88booo.
 ~Y8888P' Y888888P Y88888P YP   YP Y8888P' Y88888P Y88888P
*/



@interface UILabel(Eclipse)
-(void)override;
@end

%hook UILabel



-(void)drawRect:(CGRect)arg1 {
    %orig;

    if (isEnabled) {
        if (!isLightColor(self.superview.backgroundColor)) {

            if (isTextDarkColor(self.textColor)) {
                //self.tag = 52961101;
                [self setBackgroundColor:[UIColor clearColor]];
                [self setTextColor:TEXT_COLOR];
            }
        }
    }

}

-(void)setFrame:(CGRect)arg1 {
    %orig;

    if (isEnabled) {
        if (!isLightColor(self.superview.backgroundColor)) {

            if (isTextDarkColor(self.textColor)) {
                //self.tag = 52961101;
                [self setBackgroundColor:[UIColor clearColor]];
                [self setTextColor:TEXT_COLOR];
            }
        }
    }

}

-(void)didMoveToSuperview {
    %orig;

    if (isEnabled) {
        if (!isLightColor(self.superview.backgroundColor)) {

            if (isTextDarkColor(self.textColor)) {
                //self.tag = 52961101;
                [self setBackgroundColor:[UIColor clearColor]];
                [self setTextColor:TEXT_COLOR];
            }
        }
    }

}



-(void)setTextColor:(id)color {

    if (isEnabled) {
        // if (self.tag == 52961101) {
        //     color = TEXT_COLOR;
        //     %orig(color);
        //     return;
        // }
        if (!isLightColor(self.superview.backgroundColor)) {

            if (isTextDarkColor(color)) {
                //self.tag = 52961101;
                self.backgroundColor = [UIColor clearColor];
                color = TEXT_COLOR;
            }
        }
    }


    %orig(color);
}

%end
