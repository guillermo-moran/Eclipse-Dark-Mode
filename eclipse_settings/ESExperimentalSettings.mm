#import <Preferences/Preferences.h>

@interface ESExperimentalSettings : PSListController {
}
@end

@implementation ESExperimentalSettings

- (instancetype)init {
	self = [super init];
    
	if (self) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Experimental" target:self] retain];
	}
    
	return self;
}

@end
// vim:ft=objc
