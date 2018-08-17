#import <Preferences/Preferences.h>

@interface ESColorSettings: PSListController {
}
@end

@implementation ESColorSettings

- (instancetype)init {
	self = [super init];
    
	if (self) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Colors" target:self] retain];
	}
    
	return self;
}




@end
// vim:ft=objc
