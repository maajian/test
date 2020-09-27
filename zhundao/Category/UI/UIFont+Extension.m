#import "UIFont+Extension.h"
@implementation UIFont (Extension)
+ (UIFont *)systemMediumFonWithSize:(CGFloat)size {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:size weight:UIFontWeightMedium];
    } else {
        return [UIFont boldSystemFontOfSize:size];
    }
}
@end
