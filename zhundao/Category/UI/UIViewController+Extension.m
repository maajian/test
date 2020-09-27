#import "UIViewController+Extension.h"
@implementation UIViewController (Extension)
- (BOOL)ZD_isTop {
    if (self.navigationController) {
        return self.navigationController.topViewController == self;
    }
    return NO;
}
@end
