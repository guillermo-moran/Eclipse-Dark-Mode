/*
 .88b  d88.  .d8b.  d888888b db
 88'YbdP`88 d8' `8b   `88'   88
 88  88  88 88ooo88    88    88
 88  88  88 88~~~88    88    88
 88  88  88 88   88   .88.   88booo.
 YP  YP  YP YP   YP Y888888P Y88888P
*/

%group MailApp

%hook UITableViewCellSelectedBackground

- (void)drawRect:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        UIView* fixView = [[UIView alloc] init];
        fixView.frame = [self frame];
        fixView.backgroundColor = VIEW_COLOR;
        [self addSubview:fixView];
        [fixView release];
    }
    //I'm lazy as fuck.
}



%end

//Possibly invert this?

%hook MFMessageWebLayer

static NSString* css = @"font-face { font-family: 'Chalkboard'; src: local('ChalkboardSE-Regular'); } body { background-color: none; color: #C7C7C7; font-family: Chalkboard;} a { color: #3E98BD; text-decoration: none;}";

-(void)setFrame:(CGRect)arg1 {
    %orig;
    if (isEnabled) {
        [self setOpaque:NO];

    }
}

- (void)_webthread_webView:(id)arg1 didFinishDocumentLoadForFrame:(id)arg2 {
    if (isEnabled) {
        [self setUserStyleSheet:css];
    }
    %orig;

}

- (void)_webthread_webView:(id)arg1 didFinishLoadForFrame:(id)arg2 {
    if (isEnabled) {
        [self setUserStyleSheet:css];
    }
    %orig;
}

- (void)webView:(id)arg1 didFinishLoadForFrame:(id)arg2 {
    if (isEnabled) {
        [self setUserStyleSheet:css];
    }
    %orig;
}

- (void)webThreadWebView:(id)arg1 resource:(id)arg2 didFinishLoadingFromDataSource:(id)arg3 {
    if (isEnabled) {
        [self setUserStyleSheet:css];
    }
    %orig;
}

%end


%hook MFSubjectWebBrowserView


-(void)loadHTMLString:(id)arg1 baseURL:(id)arg2 {

    if (isEnabled) {
        arg1 = [arg1 stringByReplacingOccurrencesOfString:@"color: #000"
                                               withString:@"color: #C7C7C7"];
        [self setOpaque:NO];
    }


    %orig(arg1, arg2);
}

%end

%hook MailboxContentViewCell
-(UIColor*)deselectedBackgroundColor {
    if (isEnabled) {
        return VIEW_COLOR;
    }
    return %orig;
}

%end

%hook _CellStaticView

- (void)layoutSubviews {
    if (isEnabled) {
        [self setBackgroundColor:VIEW_COLOR];
    }
}

%end

%end

//Do not group (Body compose view)

%hook MFMailComposeView

-(id)bodyTextView {
    id view = %orig;
    if (isEnabled) {
        [view setTextColor:TEXT_COLOR];
    }
    return view;
}

%end
