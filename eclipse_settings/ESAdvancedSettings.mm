#import <Preferences/Preferences.h>

@interface ESAdvancedSettings: PSListController {
}
@end

@implementation ESAdvancedSettings

- (instancetype)init {
	self = [super init];
    
	if (self) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Advanced" target:self] retain];
	}
    
	return self;
}

@end
// vim:ft=objc
