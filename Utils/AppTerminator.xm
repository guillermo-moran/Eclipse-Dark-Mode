static void quitAllApps() {

    // id model = [%c(SBAppSwitcherModel) sharedInstance];
    // id recentAppLayouts = MSHookIvar<id>(model, "_recents");
    // NSMutableArray* allRecents = MSHookIvar<NSMutableArray*>(recentAppLayouts, "_allRecents");

    // id applicationController = [%c(SBApplicationController) _sharedInstanceCreateIfNecessary:YES];
    // NSArray* runningApplications = [applicationController runningApplications];

    // UIApplication *currentApp = [UIApplication sharedApplication];
    // [currentApp performSelector:@selector(suspend)];

    // os_log(OS_LOG_DEFAULT, "ECLIPSE: Running Apps: %@", runningApplications);

    // for (NSString* id in runningApplications) {
    //     UIApplication* app = [applicationController applicationWithBundleIdentifier: id];
    //     [app terminateWithSuccess];
    // }
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
