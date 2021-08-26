//
//  UIViewController+LBFinder.m
//  LBFinder
//
//  Created by 李兵 on 2018/1/12.
//

#import "UIViewController+LBFinder.h"

@implementation UIViewController (LBFinder)
- (void)lbf_showVC:(UIViewController *)viewController {
    if (!viewController) {
        return;
    }
    if (self.navigationController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }else {
        [self presentViewController:viewController animated:YES completion:nil];
    }
}
@end
