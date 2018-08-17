static void quitAllApps() {

    [[%c(SBSyncController) sharedInstance] _killApplicationsIfNecessary];


    id _recents = [[%c(SBAppSwitcherModel) sharedInstance] valueForKey:@"_recents"];
    [[%c(SBAppSwitcherModel) sharedInstance] remove:_recents];



}

extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

static void quitAppsRequest(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

    /*
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Please Wait"
                         message:@"Killing All Applications..."
                          delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:nil];
    [alert show];
    */

    quitAllApps();

    //[alert dismissWithClickedButtonIndex:0 animated:YES];
}
