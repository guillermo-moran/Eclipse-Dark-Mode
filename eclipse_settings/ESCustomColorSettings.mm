#import <Preferences/Preferences.h>

@interface ESCustomColorSettings: PSListController {
    
}

@end

@implementation ESCustomColorSettings

- (instancetype)init {
	self = [super init];
    
	if (self) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"CustomColors" target:self] retain];
	}
    
	return self;
}

/*
- (void)viewWillAppear:(BOOL)animated
{
    [self clearCache];
    [self reload];
    [super viewWillAppear:animated];
}
*/
@end
// vim:ft=objc
