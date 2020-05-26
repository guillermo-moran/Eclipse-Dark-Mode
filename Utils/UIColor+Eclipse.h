/*
 _______  _______  _       _________ _______  _______  _______
 (  ____ \(  ____ \( \      \__   __/(  ____ )(  ____ \(  ____ \
 | (    \/| (    \/| (         ) (   | (    )|| (    \/| (    \/
 | (__    | |      | |         | |   | (____)|| (_____ | (__
 |  __)   | |      | |         | |   |  _____)(_____  )|  __)
 | (      | |      | |         | |   | (            ) || (
 | (____/\| (____/\| (____/\___) (___| )      /\____) || (____/\
 (_______/(_______/(_______/\_______/|/       \_______)(_______/
 
 NIGHT MODE FOR IOS - UIColor Extensions
 COPYRIGHT © 2014 GUILLERMO MORAN
 */

@interface UIColor(Eclipse)


-(NSDictionary*)eclipsePrefs;

+(UIColor*)createDynamicEclipseColor:(UIColor*)defaultColor darkColor:(UIColor*)darkColor;

+(UIColor*)darkerColorForSelectionColor:(UIColor *)c;
+ (UIColor*)changeBrightness:(UIColor*)color amount:(CGFloat)amount;

+(BOOL)color:(UIColor *)color1 isEqualToColor:(UIColor *)color2 withTolerance:(CGFloat)tolerance;
+ (UIColor*) getDominantColor:(UIImage*)image;

+(UIColor*)eclipseSelectedViewColor;
+(UIColor*)eclipseSelectedTableColor;
+(UIColor*)eclipseSelectedNavColor;
+(UIColor*)eclipseSelectedTextColor;
+(UIColor*)eclipseSelectedStatusbarTintColor;
+(UIColor*)eclipseSelectedTintColor;

+(BOOL)eclipseCustomNavColorsEnabled;
+(BOOL)eclipseCustomThemeColorsEnabled;
+(BOOL)eclipseCustomTintColorsEnabled;
+(BOOL)eclipseCustomStatusbarColorsEnabled;
+(BOOL)eclipseCustomTextColorsEnabled;

+(UIColor*)eclipseThemeHexColor;
+(UIColor*)eclipseNavHexColor;
+(UIColor*)eclipseTextHexColor;
+(UIColor*)eclipseStatusbarHexColor;
+(UIColor*)eclipseTintHexColor;

+(UIColor*)colorWithHexString:(NSString *)hexStr alpha:(int)alpha;
+(UIColor*)darkerColorForColor:(UIColor *)c;

+(UIColor*)midnightTableColor;
+(UIColor*)nightTableColor;
+(UIColor*)graphiteTableColor;
+(UIColor*)silverTableColor;
+(UIColor*)crimsonTableColor;
+(UIColor*)rosePinkTableColor;
+(UIColor*)grapeTableColor;
+(UIColor*)wineTableColor;
+(UIColor*)violetTableColor;
+(UIColor*)skyTableColor;
+(UIColor*)lapisTableColor;
+(UIColor*)navyTableColor;
+(UIColor*)duskTableColor;
+(UIColor*)jungleTableColor;
+(UIColor*)bambooTableColor;
+(UIColor*)saffronTableColor;
+(UIColor*)citrusTableColor;
+(UIColor*)amberTableColor;

+(UIColor*)midnightViewColor;
+(UIColor*)nightViewColor;
+(UIColor*)graphiteViewColor;
+(UIColor*)silverViewColor;
+(UIColor*)crimsonViewColor;
+(UIColor*)rosePinkViewColor;
+(UIColor*)grapeViewColor;
+(UIColor*)wineViewColor;
+(UIColor*)violetViewColor;
+(UIColor*)skyViewColor;
+(UIColor*)lapisViewColor;
+(UIColor*)navyViewColor;
+(UIColor*)duskViewColor;
+(UIColor*)jungleViewColor;
+(UIColor*)bambooViewColor;
+(UIColor*)saffronViewColor;
+(UIColor*)citrusViewColor;
+(UIColor*)amberViewColor;

+(UIColor*)midnightBarColor;
+(UIColor*)nightBarColor;
+(UIColor*)graphiteBarColor;
+(UIColor*)silverBarColor;
+(UIColor*)crimsonBarColor;
+(UIColor*)rosePinkBarColor;
+(UIColor*)grapeBarColor;
+(UIColor*)wineBarColor;
+(UIColor*)violetBarColor;
+(UIColor*)skyBarColor;
+(UIColor*)lapisBarColor;
+(UIColor*)navyBarColor;
+(UIColor*)duskBarColor;
+(UIColor*)jungleBarColor;
+(UIColor*)bambooBarColor;
+(UIColor*)saffronBarColor;
+(UIColor*)citrusBarColor;
+(UIColor*)amberBarColor;

//Tint Colors
+(UIColor*)eclipseBabyBlueTintColor;
+(UIColor*)eclipseWhiteTintColor;
+(UIColor*)eclipsePinkTintColor;
+(UIColor*)eclipseDarkOrangeTintColor;
+(UIColor*)eclipseGreenTintColor;
+(UIColor*)eclipsePurpleTintColor;
+(UIColor*)eclipseRedTintColor;
+(UIColor*)eclipseYellowTintColor;

@end