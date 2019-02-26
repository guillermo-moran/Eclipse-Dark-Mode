#import <Preferences/Preferences.h>

@interface ESCreditsPanel: PSListController {
}

-(void)fr0st;
-(void)_mxms;
-(void)beatjunky;
-(void)reddit;

@end

@implementation ESCreditsPanel

- (instancetype)init {
	self = [super init];
    
	if (self) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Credits" target:self] retain];
	}
    
	return self;
}

- (void)fr0st {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=fr0st"]]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=fr0st"]];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/fr0st"]];
    }
}

- (void)_mxms {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=_mxms"]]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=_mxms"]];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/_mxms"]];
    }
}

- (void)beatjunky {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=beatjunky99"]]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=beatjunky99"]];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/beatjunky99"]];
    }
}

- (void)reddit {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://reddit.com/r/jailbreak"]];
    
}

@end
// vim:ft=objc

