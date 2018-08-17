/*

 d888888b db    db .88b  d88. d8888b. db      d8888b.
 `~~88~~' 88    88 88'YbdP`88 88  `8D 88      88  `8D
 88    88    88 88  88  88 88oooY' 88      88oobY'
 88    88    88 88  88  88 88~~~b. 88      88`8b
 88    88b  d88 88  88  88 88   8D 88booo. 88 `88.
 YP    ~Y8888P' YP  YP  YP Y8888P' Y88888P 88   YD
 */

%group TumblrApp

/*
 %hook TMAttributedTextView

 - (void)setAttributedText:(id)arg1 frame:(struct __CTFrame *)arg2 {
 NSAttributedString* _attributedText = MSHookIvar<NSAttributedString*>(self, "_attributedText");



 %orig(_attributedText, arg2);
 }

 %end
 */

%end
