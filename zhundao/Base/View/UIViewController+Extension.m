#import "UIViewController+Extension.h"
#import <objc/runtime.h>
@implementation UIViewController (Extension)
+(void)load {
       Method m1 = class_getInstanceMethod([self class], @selector(presentViewController:animated:completion:));
       Method m2 = class_getInstanceMethod([self class], @selector(skp_presentViewController:animated:completion:));
       method_exchangeImplementations(m1, m2);
}
- (void)skp_presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion {
    viewControllerToPresent.modalPresentationStyle =  UIModalPresentationFullScreen;
    [self skp_presentViewController:viewControllerToPresent animated:flag completion:completion];
}
@end
