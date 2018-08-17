/*
 d8888b. d88888b .88b  d88. d888888b d8b   db d8888b. d88888b d8888b. .d8888.
 88  `8D 88'     88'YbdP`88   `88'   888o  88 88  `8D 88'     88  `8D 88'  YP
 88oobY' 88ooooo 88  88  88    88    88V8o 88 88   88 88ooooo 88oobY' `8bo.
 88`8b   88~~~~~ 88  88  88    88    88 V8o88 88   88 88~~~~~ 88`8b     `Y8b.
 88 `88. 88.     88  88  88   .88.   88  V888 88  .8D 88.     88 `88. db   8D
 88   YD Y88888P YP  YP  YP Y888888P VP   V8P Y8888D' Y88888P 88   YD `8888Y'
*/

%group RemindersApp

%hook RemindersSearchView

#warning Reminders needs work
-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        UIView* searchView = MSHookIvar<UIView*>(self, "_searchResultsView");
    }

}

%end

%hook RemindersCardBackgroundView

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        [self setAlpha:0.9];
        for (UIView* view in [self subviews]) {

            //[view setAlpha:0.7];
            [view setBackgroundColor:[VIEW_COLOR colorWithAlphaComponent:0.8]];
        }
    }
}

%end

%end
