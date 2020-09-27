#import "PGAlertWithTitle.h"
#import "PGBaseNavVC.h"
@interface PGBaseNavVC ()<UINavigationControllerDelegate>
@end
@implementation PGBaseNavVC
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    self.navigationBar.titleTextAttributes = attributes;
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor blackColor];
    self.navigationBar.barTintColor = ZDBackgroundColor;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
