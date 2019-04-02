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

#import "UIColor+Eclipse.h"
#import "Interfaces.h"

#define colorWithHexString(h,a) [UIColor colorWithHexString:h alpha:a]
#define darkerColorForColor(c) [UIColor darkerColorForColor:c]

@implementation UIColor(Eclipse)

//Switches

+(BOOL)eclipseCustomNavColorsEnabled {
    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    //return (prefs) ? [prefs[@"customNavColorsEnabled"] boolValue] : YES;
    return (prefs) ? [prefs[@"customColorsEnabled"] boolValue] : YES;
}

+(BOOL)eclipseCustomThemeColorsEnabled {
    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    //return (prefs) ? [prefs[@"customThemeColorsEnabled"] boolValue] : YES;
    return (prefs) ? [prefs[@"customColorsEnabled"] boolValue] : YES;
}

+(BOOL)eclipseCustomTintColorsEnabled {
    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    //return (prefs) ? [prefs[@"customTintColorsEnabled"] boolValue] : YES;
    return (prefs) ? [prefs[@"customColorsEnabled"] boolValue] : YES;
}

+(BOOL)eclipseCustomStatusbarColorsEnabled {
    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    //return (prefs) ? [prefs[@"customStatusbarColorsEnabled"] boolValue] : YES;
    return (prefs) ? [prefs[@"customColorsEnabled"] boolValue] : YES;
}

+(BOOL)eclipseCustomTextColorsEnabled {
    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    //return (prefs) ? [prefs[@"customTextColorsEnabled"] boolValue] : YES;
    return (prefs) ? [prefs[@"customColorsEnabled"] boolValue] : YES;
}

//Hex Colors

-(NSDictionary*)eclipsePrefs {
    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    return prefs;
}

+(UIColor*)eclipseTextHexColor {
     NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    NSString* hex = [prefs objectForKey:@"customTextHex"];

    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;
}

+(UIColor*)eclipseThemeHexColor {
     NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    NSString* hex = [prefs objectForKey:@"customThemeHex"];

    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;
}

+(UIColor*)eclipseNavHexColor {
     NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    NSString* hex = [prefs objectForKey:@"customNavBarHex"];

    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;
}

+(UIColor*)eclipseStatusbarHexColor {
     NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    NSString* hex = [prefs objectForKey:@"customStatusbarHex"];
    hex = [hex stringByReplacingOccurrencesOfString:@" " withString:@""];

    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;
}

+(UIColor*)eclipseTintHexColor {
     NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    NSString* hex = [prefs objectForKey:@"customTintHex"];
    hex = [hex stringByReplacingOccurrencesOfString:@" " withString:@""];

    if (![hex isEqualToString:@""]) {
        return colorWithHexString(hex,1);
    }
    return nil;
}

//Color Choices

+(UIColor*)eclipseSelectedTextColor {
    if ([self eclipseCustomTextColorsEnabled]) {
        if ([UIColor eclipseTextHexColor]) {
            return [UIColor eclipseTextHexColor];
        }
    }

    return [UIColor colorWithRed:230.0/255.0f green:230.0/255.0f blue:230.0/255.0f alpha:1.0f];
}

+(UIColor*)eclipseSelectedViewColor {
    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];

    int number = [[prefs objectForKey:@"selectedTheme"] intValue];

    if ([self eclipseCustomThemeColorsEnabled]) {
        if ([UIColor eclipseThemeHexColor]) {
            return darkerColorForColor([UIColor eclipseThemeHexColor]);
        }
    }

    if (number == -1) {
        return MIDNIGHT_VIEW_COLOR;
    }
    else if (number == 0) {
        return NIGHT_VIEW_COLOR;
    }
    else if (number == 1) {
        return GRAPHITE_VIEW_COLOR;
    }
    else if (number == 2) {
        return SILVER_VIEW_COLOR;
    }
    else if (number == 3) {
        return CRIMSON_VIEW_COLOR;
    }
    else if (number == 4) {
        return ROSE_PINK_VIEW_COLOR;
    }
    else if (number == 5) {
        return GRAPE_VIEW_COLOR;
    }
    else if (number == 6) {
        return WINE_VIEW_COLOR;
    }
    else if (number == 7) {
        return VIOLET_VIEW_COLOR;
    }
    else if (number == 8) {
        return SKY_VIEW_COLOR;
    }
    else if (number == 9) {
        return LAPIS_VIEW_COLOR;
    }
    else if (number == 10) {
        return NAVY_VIEW_COLOR;
    }
    else if (number == 11) {
        return DUSK_VIEW_COLOR;
    }
    else if (number == 12) {
        return JUNGLE_VIEW_COLOR;
    }
    else if (number == 13) {
        return BAMBOO_VIEW_COLOR;
    }
    else if (number == 14) {
        return SAFFRON_VIEW_COLOR;
    }
    else if (number == 15) {
        return CITRUS_VIEW_COLOR;
    }
    else if (number == 16) {
        return AMBER_VIEW_COLOR;
    }


    else {
        return NIGHT_VIEW_COLOR;
    }

}

+(UIColor*)eclipseSelectedTableColor {
    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];

    int number = [[prefs objectForKey:@"selectedTheme"] intValue];

    if ([self eclipseCustomThemeColorsEnabled]) {
        if ([UIColor eclipseThemeHexColor]) {
            return [UIColor eclipseThemeHexColor];
        }
    }

    if (number == -1) {
        return MIDNIGHT_TABLE_COLOR;
    }

    else if (number == 0) {
        return NIGHT_TABLE_COLOR;
    }
    else if (number == 1) {
        return GRAPHITE_TABLE_COLOR;
    }
    else if (number == 2) {
        return SILVER_TABLE_COLOR;
    }
    else if (number == 3) {
        return CRIMSON_TABLE_COLOR;
    }
    else if (number == 4) {
        return ROSE_PINK_TABLE_COLOR;
    }
    else if (number == 5) {
        return GRAPE_TABLE_COLOR;
    }
    else if (number == 6) {
        return WINE_TABLE_COLOR;
    }
    else if (number == 7) {
        return VIOLET_TABLE_COLOR;
    }
    else if (number == 8) {
        return SKY_TABLE_COLOR;
    }
    else if (number == 9) {
        return LAPIS_TABLE_COLOR;
    }
    else if (number == 10) {
        return NAVY_TABLE_COLOR;
    }
    else if (number == 11) {
        return DUSK_TABLE_COLOR;
    }
    else if (number == 12) {
        return JUNGLE_TABLE_COLOR;
    }
    else if (number == 13) {
        return BAMBOO_TABLE_COLOR;
    }
    else if (number == 14) {
        return SAFFRON_TABLE_COLOR;
    }
    else if (number == 15) {
        return CITRUS_TABLE_COLOR;
    }
    else if (number == 16) {
        return AMBER_TABLE_COLOR;
    }

    else {
        return NIGHT_TABLE_COLOR;
    }

}

+(UIColor*)eclipseSelectedNavColor {
    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];

    int number = [[prefs objectForKey:@"selectedNavColor"] intValue];

    if ([self eclipseCustomNavColorsEnabled]) {
        if ([UIColor eclipseNavHexColor]) {
            return [UIColor eclipseNavHexColor];
        }
    }

    if (number == -1) {
        return MIDNIGHT_BAR_COLOR;
    }
    else if (number == 0) {
        return NIGHT_BAR_COLOR;
    }
    else if (number == 1) {
        return GRAPHITE_BAR_COLOR;
    }
    else if (number == 2) {
        return SILVER_BAR_COLOR;
    }
    else if (number == 3) {
        return CRIMSON_BAR_COLOR;
    }
    else if (number == 4) {
        return ROSE_PINK_BAR_COLOR;
    }
    else if (number == 5) {
        return GRAPE_BAR_COLOR;
    }
    else if (number == 6) {
        return WINE_BAR_COLOR;
    }
    else if (number == 7) {
        return VIOLET_BAR_COLOR;
    }
    else if (number == 8) {
        return SKY_BAR_COLOR;
    }
    else if (number == 9) {
        return LAPIS_BAR_COLOR;
    }
    else if (number == 10) {
        return NAVY_BAR_COLOR;
    }
    else if (number == 11) {
        return DUSK_BAR_COLOR;
    }
    else if (number == 12) {
        return JUNGLE_BAR_COLOR;
    }
    else if (number == 13) {
        return BAMBOO_BAR_COLOR;
    }
    else if (number == 14) {
        return SAFFRON_BAR_COLOR;
    }
    else if (number == 15) {
        return CITRUS_BAR_COLOR;
    }
    else if (number == 16) {
        return AMBER_BAR_COLOR;
    }


    else {
        return NIGHT_BAR_COLOR;
    }
}

+(UIColor*)eclipseSelectedStatusbarTintColor {
    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    int number = [[prefs objectForKey:@"statusbarTint"] intValue];

    if ([self eclipseCustomStatusbarColorsEnabled]) {
        if ([UIColor eclipseStatusbarHexColor]) {
            return [UIColor eclipseStatusbarHexColor];
        }
    }

    if (number == 0) {
        //return textColor(); //White
        return WHITE_COLOR;
    }
    else if (number == 1) {
        return BABY_BLUE_COLOR;
    }
    else if (number == 2) {
        return DARK_ORANGE_COLOR;
    }
    else if (number == 3) {
        return PINK_COLOR;
    }
    else if (number == 4) {
        return GREEN_COLOR;
    }
    else if (number == 5) {
        return PURPLE_COLOR;
    }
    else if (number == 6) {
        return RED_COLOR;
    }
    else if (number == 7) {
        return YELLOW_COLOR;
    }

    else {
        //return textColor(); //White
        return WHITE_COLOR;
    }

}

+(UIColor*)eclipseSelectedTintColor {
    NSDictionary* prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_FILE_PATH];
    int number = [[prefs objectForKey:@"selectedTint"] intValue];

    if ([self eclipseCustomTintColorsEnabled]) {
        if ([UIColor eclipseTintHexColor]) {
            return [UIColor eclipseTintHexColor];
        }
    }

    if (number == 0) {
        return BABY_BLUE_COLOR;
    }
    if (number == 1) {
        return WHITE_COLOR;
    }
    if (number == 2) {
        return DARK_ORANGE_COLOR;
    }
    if (number == 3) {
        return PINK_COLOR;
    }
    if (number == 4) {
        return GREEN_COLOR;
    }
    if (number == 5) {
        return PURPLE_COLOR;
    }
    if (number == 6) {
        return RED_COLOR;
    }
    if (number == 7) {
        return YELLOW_COLOR;
    }
    if (number == 8) {


        NSArray* availableColors = @[BABY_BLUE_COLOR, WHITE_COLOR, PINK_COLOR, DARK_ORANGE_COLOR, GREEN_COLOR, PURPLE_COLOR, RED_COLOR, YELLOW_COLOR];

        UIColor* rand = availableColors.count == 0 ? nil : availableColors[arc4random_uniform(availableColors.count)];

        return rand;

        /*
         CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
         CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
         CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
         UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];

         return color;
         */
    }
    else {
        return BABY_BLUE_COLOR;
    }

}


+(UIColor*)darkerColorForSelectionColor:(UIColor *)c {
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a]) {

        return [UIColor colorWithRed:MAX(r - 0.2, 0.0) green:MAX(g - 0.2, 0.0)
                                blue:MAX(b - 0.2, 0.0) alpha:a];
    }
    return c;
}

+(BOOL)color:(UIColor *)color1 isEqualToColor:(UIColor *)color2 withTolerance:(CGFloat)tolerance {
    //tolerance = TOLERANCE;

    CGFloat r1, g1, b1, a1, r2, g2, b2, a2;
    [color1 getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [color2 getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    return
    fabs(r1 - r2) <= tolerance &&
    fabs(g1 - g2) <= tolerance &&
    fabs(b1 - b2) <= tolerance &&
    fabs(a1 - a2) <= tolerance;
}

+(UIColor*)colorWithHexString:(NSString *)hexStr alpha:(int)alpha {

    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    hexStr = [hexStr uppercaseString];
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];

    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];

    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];

    return color;


    /*
    hexStr = [hexStr stringByReplacingOccurrencesOfString:@"#" withString:@""];
    hexStr = [hexStr uppercaseString];
    int hexInt = [hexStr intValue];

    return [UIColor colorWithRed:((float)((hexInt & 0xFF0000) >> 16))/255.0  green:((float)((hexInt & 0xFF00) >> 8))/255.0  blue:((float)(hexInt & 0xFF))/255.0 alpha:alpha];
     */

}

+(UIColor*)darkerColorForColor:(UIColor *)c {
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a]) {

        return [UIColor colorWithRed:MAX(r - 0.04, 0.0) green:MAX(g - 0.04, 0.0)
                                blue:MAX(b - 0.04, 0.0) alpha:a];
    }
    return c;
}

+ (UIColor*)changeBrightness:(UIColor*)color amount:(CGFloat)amount
{

    CGFloat hue, saturation, brightness, alpha;
    if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
        brightness += (amount-1.0);
        brightness = MAX(MIN(brightness, 1.0), 0.0);
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    }

    CGFloat white;
    if ([color getWhite:&white alpha:&alpha]) {
        white += (amount-1.0);
        white = MAX(MIN(white, 1.0), 0.0);
        return [UIColor colorWithWhite:white alpha:alpha];
    }

    return nil;
}

struct pixel {
    unsigned char r, g, b, a;
};

+(UIColor*) getDominantColor:(UIImage*)image
{
    NSUInteger red = 0;
    NSUInteger green = 0;
    NSUInteger blue = 0;


    // Allocate a buffer big enough to hold all the pixels

    struct pixel* pixels = (struct pixel*) calloc(1, image.size.width * image.size.height * sizeof(struct pixel));
    if (pixels != nil)
    {

        CGContextRef context = CGBitmapContextCreate(
                                                 (void*) pixels,
                                                 image.size.width,
                                                 image.size.height,
                                                 8,
                                                 image.size.width * 4,
                                                 CGImageGetColorSpace(image.CGImage),
                                                 kCGImageAlphaPremultipliedLast
                                                 );

        if (context != NULL)
        {
            // Draw the image in the bitmap

            CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), image.CGImage);

            // Now that we have the image drawn in our own buffer, we can loop over the pixels to
            // process it. This simple case simply counts all pixels that have a pure red component.

            // There are probably more efficient and interesting ways to do this. But the important
            // part is that the pixels buffer can be read directly.

            NSUInteger numberOfPixels = image.size.width * image.size.height;
            for (int i=0; i<numberOfPixels; i++) {
                red += pixels[i].r;
                green += pixels[i].g;
                blue += pixels[i].b;
            }


            red /= numberOfPixels;
            green /= numberOfPixels;
            blue/= numberOfPixels;


            CGContextRelease(context);
        }

        free(pixels);
    }
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];
}

// + (UIColor*) getDominantColor:(UIImage*)image {
//     CGSize size = {1, 1};
//     UIGraphicsBeginImageContext(size);
//     CGContextRef ctx = UIGraphicsGetCurrentContext();
//     CGContextSetInterpolationQuality(ctx, kCGInterpolationMedium);
//     [image drawInRect:(CGRect){.size = size} blendMode:kCGBlendModeCopy alpha:1];
//     uint8_t *data = CGBitmapContextGetData(ctx);
//     UIColor *color = [UIColor colorWithRed:data[0] / 255.f green:data[1] / 255.f blue:data[2] / 255.f alpha:1];
//     UIGraphicsEndImageContext();
//     return color;
// }
/*
struct pixel {
    unsigned char r, g, b, a;
};

+ (UIColor*) getDominantColor:(UIImage*)image
{
    NSUInteger red = 0;
    NSUInteger green = 0;
    NSUInteger blue = 0;


    // Allocate a buffer big enough to hold all the pixels

    struct pixel* pixels = (struct pixel*) calloc(1, image.size.width * image.size.height * sizeof(struct pixel));
    if (pixels != nil)
    {

        CGContextRef context = CGBitmapContextCreate(
                                                     (void*) pixels,
                                                     image.size.width,
                                                     image.size.height,
                                                     8,
                                                     image.size.width * 4,
                                                     CGImageGetColorSpace(image.CGImage),
                                                     kCGImageAlphaPremultipliedLast
                                                     );

        if (context != NULL)
        {
            // Draw the image in the bitmap

            CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), image.CGImage);

            // Now that we have the image drawn in our own buffer, we can loop over the pixels to
            // process it. This simple case simply counts all pixels that have a pure red component.

            // There are probably more efficient and interesting ways to do this. But the important
            // part is that the pixels buffer can be read directly.

            NSUInteger numberOfPixels = image.size.width * image.size.height;
            for (int i=0; i<numberOfPixels; i++) {
                red += pixels[i].r;
                green += pixels[i].g;
                blue += pixels[i].b;
            }


            red /= numberOfPixels;
            green /= numberOfPixels;
            blue/= numberOfPixels;


            CGContextRelease(context);
        }

        free(pixels);
    }
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];
}
*/
//Table Colors

+(UIColor*)midnightTableColor {
    return [UIColor colorWithRed:20.0f/255.0f green:20.0f/255.0f blue:20.0f/255.0f alpha:1.0];
}

+(UIColor*)nightTableColor {
    return [UIColor colorWithRed:30.0f/255.0f green:30.0f/255.0f blue:30.0f/255.0f alpha:1.0];
}

+(UIColor*)graphiteTableColor {
    return [UIColor colorWithRed:72.0f/255.0f green:72.0f/255.0f blue:72.0f/255.0f alpha:1.0];
}

+(UIColor*)silverTableColor {
    return [UIColor colorWithRed:98.0f/255.0f green:112.0f/255.0f blue:127.0f/255.0f alpha:1.0];
}

+(UIColor*)crimsonTableColor {
    return [UIColor colorWithRed:143.0f/255.0f green:29.0f/255.0f blue:33.0f/255.0f alpha:1.0];
}

+(UIColor*)rosePinkTableColor {
    return [UIColor colorWithRed:246.0f/255.0f green:36.0f/255.0f blue:89.0f/255.0f alpha:1.0];
}

+(UIColor*)grapeTableColor {
    return [UIColor colorWithRed:142.0f/255.0f green:68.0f/255.0f blue:173.0f/255.0f alpha:1.0];
}

+(UIColor*)wineTableColor {
    return [UIColor colorWithRed:118.0f/255.0f green:53.0f/255.0f blue:104.0f/255.0f alpha:1.0];
}

+(UIColor*)violetTableColor {
    return [UIColor colorWithRed:91.0f/255.0f green:50.0f/255.0f blue:86.0f/255.0f alpha:1.0];
}

+(UIColor*)skyTableColor {
    return [UIColor colorWithRed:77.0f/255.0f green:143.0f/255.0f blue:172.0f/255.0f alpha:1.0];
}

+(UIColor*)lapisTableColor {
    return [UIColor colorWithRed:31.0f/255.0f green:71.0f/255.0f blue:136.0f/255.0f alpha:1.0];
}

+(UIColor*)navyTableColor {
   return [UIColor colorWithRed:0.0f/255.0f green:49.0f/255.0f blue:113.0f/255.0f alpha:1.0];
}

+(UIColor*)duskTableColor {
    return [UIColor colorWithRed:38.0f/255.0f green:67.0f/255.0f blue:72.0f/255.0f alpha:1.0];
}

+(UIColor*)jungleTableColor {
    return [UIColor colorWithRed:38.0f/255.0f green:166.0f/255.0f blue:91.0f/255.0f alpha:1.0];
}

+(UIColor*)bambooTableColor {
    return [UIColor colorWithRed:0.0f/255.0f green:100.0f/255.0f blue:66.0f/255.0f alpha:1.0];
}

+(UIColor*)saffronTableColor {
    return [UIColor colorWithRed:244.0f/255.0f green:208.0f/255.0f blue:63.0f/255.0f alpha:1.0];
}

+(UIColor*)citrusTableColor {
    return [UIColor colorWithRed:249.0f/255.0f green:105.0f/255.0f blue:14.0f/255.0f alpha:1.0];
}

+(UIColor*)amberTableColor {
    return [UIColor colorWithRed:202.0f/255.0f green:105.0f/255.0f blue:36.0f/255.0f alpha:1.0];
}

//View Colors

+(UIColor*)midnightViewColor {
    return [UIColor colorWithRed:17.0f/255.0f green:17.0f/255.0f blue:17.0f/255.0f alpha:1.0];
}

+(UIColor*)nightViewColor {
    return [UIColor colorWithRed:27.0f/255.0f green:27.0f/255.0f blue:27.0f/255.0f alpha:1.0];
}

+(UIColor*)graphiteViewColor {
    return [UIColor colorWithRed:62.0f/255.0f green:62.0f/255.0f blue:62.0f/255.0f alpha:1.0];
}

+(UIColor*)silverViewColor {
    return [UIColor colorWithRed:88.0f/255.0f green:102.0f/255.0f blue:117.0f/255.0f alpha:1.0];
}

+(UIColor*)crimsonViewColor {
    return [UIColor colorWithRed:133.0f/255.0f green:19.0f/255.0f blue:23.0f/255.0f alpha:1.0];
}

+(UIColor*)rosePinkViewColor {
    return [UIColor colorWithRed:231.0f/255.0f green:21.0f/255.0f blue:74.0f/255.0f alpha:1.0];
}

+(UIColor*)grapeViewColor {
    return [UIColor colorWithRed:127.0f/255.0f green:53.0f/255.0f blue:158.0f/255.0f alpha:1.0];
}

+(UIColor*)wineViewColor {
    return [UIColor colorWithRed:108.0f/255.0f green:43.0f/255.0f blue:94.0f/255.0f alpha:1.0];
}

+(UIColor*)violetViewColor {
    return [UIColor colorWithRed:81.0f/255.0f green:40.0f/255.0f blue:76.0f/255.0f alpha:1.0];
}

+(UIColor*)skyViewColor {
    return [UIColor colorWithRed:67.0f/255.0f green:133.0f/255.0f blue:162.0f/255.0f alpha:1.0];
}

+(UIColor*)lapisViewColor {
    return [UIColor colorWithRed:21.0f/255.0f green:61.0f/255.0f blue:126.0f/255.0f alpha:1.0];
}

+(UIColor*)navyViewColor {
    return [UIColor colorWithRed:0.0f/255.0f green:39.0f/255.0f blue:103.0f/255.0f alpha:1.0];
}

+(UIColor*)duskViewColor {
    return [UIColor colorWithRed:28.0f/255.0f green:57.0f/255.0f blue:62.0f/255.0f alpha:1.0];
}

+(UIColor*)jungleViewColor {
    return [UIColor colorWithRed:28.0f/255.0f green:156.0f/255.0f blue:81.0f/255.0f alpha:1.0];
}

+(UIColor*)bambooViewColor {
    return [UIColor colorWithRed:0.0f/255.0f green:90.0f/255.0f blue:56.0f/255.0f alpha:1.0];
}

+(UIColor*)saffronViewColor {
    return [UIColor colorWithRed:234.0f/255.0f green:198.0f/255.0f blue:53.0f/255.0f alpha:1.0];
}

+(UIColor*)citrusViewColor {
    return [UIColor colorWithRed:239.0f/255.0f green:95.0f/255.0f blue:4.0f/255.0f alpha:1.0];
}

+(UIColor*)amberViewColor {
    return [UIColor colorWithRed:192.0f/255.0f green:95.0f/255.0f blue:26.0f/255.0f alpha:1.0];
}

//Nav Bar Colors

+(UIColor*)midnightBarColor {
    return [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0];
}
+(UIColor*)nightBarColor {
    return [UIColor colorWithRed:10.0f/255.0f green:10.0f/255.0f blue:10.0f/255.0f alpha:1.0];
}
+(UIColor*)graphiteBarColor {
    return [UIColor colorWithRed:34.0f/255.0f green:34.0f/255.0f blue:34.0f/255.0f alpha:1.0];
}
+(UIColor*)silverBarColor {
    return [UIColor colorWithRed:78.0f/255.0f green:92.0f/255.0f blue:107.0f/255.0f alpha:1.0];
}
+(UIColor*)crimsonBarColor {
    return [UIColor colorWithRed:113.0f/255.0f green:0.0f/255.0f blue:3.0f/255.0f alpha:1.0];
}
+(UIColor*)rosePinkBarColor {
    return [UIColor colorWithRed:216.0f/255.0f green:6.0f/255.0f blue:59.0f/255.0f alpha:1.0];
}
+(UIColor*)grapeBarColor {
    return [UIColor colorWithRed:102.0f/255.0f green:28.0f/255.0f blue:133.0f/255.0f alpha:1.0];
}
+(UIColor*)wineBarColor {
    return [UIColor colorWithRed:88.0f/255.0f green:23.0f/255.0f blue:74.0f/255.0f alpha:1.0];
}
+(UIColor*)violetBarColor {
    return [UIColor colorWithRed:61.0f/255.0f green:20.0f/255.0f blue:56.0f/255.0f alpha:1.0];
}
+(UIColor*)skyBarColor {
    return [UIColor colorWithRed:47.0f/255.0f green:113.0f/255.0f blue:142.0f/255.0f alpha:1.0];
}
+(UIColor*)lapisBarColor {
    return [UIColor colorWithRed:1.0f/255.0f green:41.0f/255.0f blue:106.0f/255.0f alpha:1.0];
}
+(UIColor*)navyBarColor {
    return [UIColor colorWithRed:0.0f/255.0f green:19.0f/255.0f blue:83.0f/255.0f alpha:1.0];
}
+(UIColor*)duskBarColor {
    return [UIColor colorWithRed:8.0f/255.0f green:37.0f/255.0f blue:42.0f/255.0f alpha:1.0];
}
+(UIColor*)jungleBarColor {
    return [UIColor colorWithRed:8.0f/255.0f green:136.0f/255.0f blue:61.0f/255.0f alpha:1.0];
}
+(UIColor*)bambooBarColor {
    return [UIColor colorWithRed:0.0f/255.0f green:70.0f/255.0f blue:36.0f/255.0f alpha:1.0];
}
+(UIColor*)saffronBarColor {
    return [UIColor colorWithRed:214.0f/255.0f green:178.0f/255.0f blue:33.0f/255.0f alpha:1.0];
}
+(UIColor*)citrusBarColor {
    return [UIColor colorWithRed:219.0f/255.0f green:75.0f/255.0f blue:4.0f/255.0f alpha:1.0];
}
+(UIColor*)amberBarColor {
    return [UIColor colorWithRed:172.0f/255.0f green:75.0f/255.0f blue:6.0f/255.0f alpha:1.0];
}

//Tint Colors

+(UIColor*)eclipseBabyBlueTintColor {
    return [UIColor colorWithRed:0/255.0f green:163/255.0f blue:235/255.0f alpha:1.0f];
}
+(UIColor*)eclipseWhiteTintColor {
    return [UIColor whiteColor];
}
+(UIColor*)eclipsePinkTintColor {
    return [UIColor colorWithRed:255/255.0f green:74/255.0f blue:85/255.0f alpha:1.0f];
}
+(UIColor*)eclipseDarkOrangeTintColor {
    return [UIColor colorWithRed:255/255.0f green:102/255.0f blue:0/255.0f alpha:1.0f];
}
+(UIColor*)eclipseGreenTintColor {
    return [UIColor colorWithRed:46/255.0f green:225/255.0f blue:79/255.0f alpha:1.0f];
}
+(UIColor*)eclipsePurpleTintColor {
    return [UIColor colorWithRed:179/255.0f green:1/255.0f blue:255/255.0f alpha:1.0f];
}
+(UIColor*)eclipseRedTintColor {
    return [UIColor colorWithRed:188/255.0f green:39/255.0f blue:0/255.0f alpha:1.0f];
}
+(UIColor*)eclipseYellowTintColor {
    return [UIColor colorWithRed:255/255.0f green:234/255.0f blue:0/255.0f alpha:1.0f];
}

@end
