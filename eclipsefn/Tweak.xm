/*
 _______  _______  _       _________ _______  _______  _______
 (  ____ \(  ____ \( \      \__   __/(  ____ )(  ____ \(  ____ \
 | (    \/| (    \/| (         ) (   | (    )|| (    \/| (    \/
 | (__    | |      | |         | |   | (____)|| (_____ | (__
 |  __)   | |      | |         | |   |  _____)(_____  )|  __)
 | (      | |      | |         | |   | (            ) || (
 | (____/\| (____/\| (____/\___) (___| )      /\____) || (____/\
 (_______/(_______/(_______/\_______/|/       \_______)(_______/

 NIGHT MODE FOR IOS - Foundation Hook
 COPYRIGHT © 2020 MOONISTA, LLC

 */

%hook NSBundle

-(NSDictionary *)infoDictionary {
    NSDictionary* originalDict = %orig;
    NSMutableDictionary* mutableDict = [originalDict mutableCopy];
    [mutableDict removeObjectForKey: @"UIUserInterfaceStyle"];
    return mutableDict;
}

-(id)objectForInfoDictionaryKey:(NSString*)key {
    if ([key isEqualToString: @"UIUserInterfaceStyle"]) {
        return nil;
    }
    return %orig;
}

%end