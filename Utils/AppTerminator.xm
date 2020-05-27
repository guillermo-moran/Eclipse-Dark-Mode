static void quitAllApps() {

    id applicationController = [%c(SBApplicationController) sharedInstance];
    NSArray* runningApplications = [applicationController runningApplications];

    UIApplication *currentApp = [UIApplication sharedApplication];
    [currentApp performSelector:@selector(suspend)];

    for (NSString* id in runningApplications) {
        UIApplication* app = [applicationController applicationWithBundleIdentifier: id];
        [app terminateWithSuccess];
    }
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
