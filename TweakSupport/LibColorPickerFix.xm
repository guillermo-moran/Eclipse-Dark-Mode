@interface PFColorViewController : UIViewController{}
@end

%hook PFColorViewController

- (id)initForContentSize:(CGSize)size {
    id cat = %orig;

    if (isEnabled) {
        UIView* _pushedView = MSHookIvar<UIView*>(self, "_pushedView");
        UIView* transparent = MSHookIvar<UIView*>(self, "transparent");
        UIView* controlsContainer = MSHookIvar<UIView*>(self, "controlsContainer");

        _pushedView.tag = VIEW_EXCLUDE_TAG;
        transparent.tag = VIEW_EXCLUDE_TAG;
        controlsContainer.tag = VIEW_EXCLUDE_TAG;

        self.view.tag = VIEW_EXCLUDE_TAG;
    }

    return cat;
}
%end
