/*
 d8888b. db   db  .d88b.  d8b   db d88888b
 88  `8D 88   88 .8P  Y8. 888o  88 88'
 88oodD' 88ooo88 88    88 88V8o 88 88ooooo
 88~~~   88~~~88 88    88 88 V8o88 88~~~~~
 88      88   88 `8b  d8' 88  V888 88.
 88      YP   YP  `Y88P'  VP   V8P Y88888P
*/

@interface PhoneViewController : UIViewController{}
@end

%group PhoneApp


%hook TSSuperBottomBarButton

-(id)init {
    id meh = %orig;
    if (isEnabled) {
        [self setBackgroundColor:selectedTintColor()];
    }
    return meh;
}

%end


%hook PhoneViewController

- (void)viewDidLoad {
    %orig;
    if (isEnabled) {
        [self.view setBackgroundColor:selectedTintColor()];
    }
}

%end

%hook PHHandsetDialerNumberPadButton

-(id)buttonColor {
    if (isEnabled) {
        return selectedTintColor();
    }
    return %orig;
}

%end

%hook PHHandsetDialerDeleteButton

-(void)layoutSubviews {
    %orig;
    if (isEnabled) {
        applyInvertFilter((UIButton*)self);
    }
}

%end

%hook PHHandsetDialerView

- (id)dialerColor {
    if (isEnabled) {
        return VIEW_COLOR;
    }
    return %orig;
}

%end



%hook TPNumberPadButton

+(id)imageForCharacter:(unsigned)arg1 highlighted:(BOOL)arg2 whiteVersion:(BOOL)arg3 {

    if (isEnabled) {
        return %orig(arg1, arg2, YES);
    }
    return %orig;
}

%end
%end

//Disable in Emergency Dial

 %hook PHEmergencyHandsetDialerView


//  - (id)initWithFrame:(struct CGRect)arg1 {
//  isEnabled = NO;
//  id meow = %orig;
//  isEnabled = isTweakEnabled();
//  return meow;

//  }

 %end
