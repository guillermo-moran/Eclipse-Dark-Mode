//Invert Colors Filter
//By Andy Wiik
struct CAColorMatrix {
    float m11, m12, m13, m14, m15;
    float m21, m22, m23, m24, m25;
    float m31, m32, m33, m34, m35;
    float m41, m42, m43, m44, m45;
};

#import "Utils/CAFilter.h"

void applyInvertFilter(UIView *view) {

    NSMutableArray *currentFilters = [NSMutableArray new];
    for (CAFilter *filter in view.layer.filters) {
        if ([filter.name isEqualToString:@"invertFilter"]) {
            return;
        } else {
            [filter setValue:[NSNumber numberWithBool:NO] forKey:@"inputReversed"];
            [currentFilters addObject:filter];

        }
    }
    CAFilter *invertFilter = [CAFilter filterWithType:@"colorMatrix"];
    [invertFilter setValue:[NSValue valueWithCAColorMatrix:(CAColorMatrix){-1,0,0,0,1,0,-1,0,0,1,0,0,-1,0,1,0,0,0,1,0}] forKey:@"inputColorMatrix"];
    //invertFilter.isDarkModeFilter = YES;
    [currentFilters addObject:invertFilter];
    [view.layer setFilters:currentFilters];

}

void removeAllFilters(UIView* view) {
    NSMutableArray *emptyFilters = [NSMutableArray new];

    [view.layer setFilters:emptyFilters];
}
