//Fix Wifi Connection Image
//Thanks to @MidnightChips for this code

%group WiFiKitFix

%hook WFAssociationStateView

@interface WFAssociationStateView : UIView
@end

-(void)layoutSubviews{
  %orig;
  self.backgroundColor = [UIColor clearColor];
}
%end
//Color Glyphs in Wifi
%hook WFNetworkListCell
-(void)layoutSubviews{
  %orig;
  //Lock Glyph
  UIImageView *lock = MSHookIvar<UIImageView*>(self, "_lockImageView");
  lock.image = [lock.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [lock setTintColor:selectedTintColor()];
  //Wifi Glyph
  UIImageView *wifi = MSHookIvar<UIImageView*>(self, "_signalImageView");
  wifi.image = [wifi.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [wifi setTintColor:selectedTintColor()];

}
%end

%end
