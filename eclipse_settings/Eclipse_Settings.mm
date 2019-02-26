#import <Preferences/Preferences.h>
#import <UIKit/UITableViewCell+Private.h>

#define QUIT_APPS_NOTIF "com.gmoran.eclipse.quit-apps"
extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

@interface ESListController: PSListController <UIAlertViewDelegate> {
}
@end

@implementation ESListController



- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}
	return _specifiers;
}

-(void)quitApps {
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR(QUIT_APPS_NOTIF), NULL, NULL, TRUE);
}

-(void)respring {
    system("killall -9 backboardd SpringBoard");
}

-(void)twitter {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=fr0st"]]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=fr0st"]];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/fr0st"]];
    }
}

-(void)mail {
    NSString *url = @"mailto:guillermo@gmoran.me?&subject=Eclipse%20Support";
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0 && [cell respondsToSelector:@selector(_setDrawsSeparatorAtTopOfSection:)]) {
        cell._drawsSeparatorAtTopOfSection = NO;
        cell._drawsSeparatorAtBottomOfSection = NO;
    }
}

@end
