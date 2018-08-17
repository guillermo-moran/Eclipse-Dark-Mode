/*
 _______  _______  _       _________ _______  _______  _______
 (  ____ \(  ____ \( \      \__   __/(  ____ )(  ____ \(  ____ \
 | (    \/| (    \/| (         ) (   | (    )|| (    \/| (    \/
 | (__    | |      | |         | |   | (____)|| (_____ | (__
 |  __)   | |      | |         | |   |  _____)(_____  )|  __)
 | (      | |      | |         | |   | (            ) || (
 | (____/\| (____/\| (____/\___) (___| )      /\____) || (____/\
 (_______/(_______/(_______/\_______/|/       \_______)(_______/

 NIGHT MODE FOR IOS - UIImage Extensions
 COPYRIGHT © 2014 GUILLERMO MORAN
 */

@interface UIImage(Eclipse)

- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha;
+ (UIImage *)colorImage:(UIImage*)image withColor:(UIColor *)color;

@end
