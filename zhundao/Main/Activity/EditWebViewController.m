//
//  EditWebViewController.m
//  zhundao
//
//  Created by zhundao on 2017/5/12.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "EditWebViewController.h"
#import "LMWordViewController.h"
#import "LMWordView.h"
@interface EditWebViewController ()

@property (nonatomic, strong) LMWordViewController *wordViewController;
@property (nonatomic, weak) UIViewController *currentViewController;
@property (strong, nonatomic)  UIView *container;
@property(nonatomic,assign)NSInteger flag;
@end

@implementation EditWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customBack];
    [self rightButton];
    _flag=0;
    [self.view addSubview:self.container];
    self.currentViewController.view.frame = self.container.bounds;
    self.title = @"编辑活动详情";
    [self changeSegment:nil];
}
-(void)customBack
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-8, 20, 80, 44)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backpop)];
    UILabel *button = [MyLabel initWithLabelFrame:CGRectMake(0, 0, 40,45) Text:@"取消" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
    [view addSubview:button];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = item;
    [view addGestureRecognizer:tap3];
}
- (void)backpop
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定放弃编辑活动详情描述?" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)rightButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    NSDictionary *dic = @{NSFontAttributeName : KHeitiSCMedium(17),
                          NSForegroundColorAttributeName:ZDMainColor};
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)save
{
    if ([self.wordViewController exportHTML]) {
        if (_block) {
            _block(self.wordViewController.textView.attributedText,[self.wordViewController exportHTML],self.wordViewController.textView.titleTextField.text);
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (LMWordViewController *)wordViewController {
    
    if (!_wordViewController) {
        _wordViewController = [[LMWordViewController alloc] init];
    }
    return _wordViewController;
}
- (UIView *)container
{
    if (!_container) {
        _container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    }
    return _container;
}

- (void)changeSegment:(UISegmentedControl *)sender {
    
    if (self.currentViewController) {
        [self.currentViewController removeFromParentViewController];
        [self.currentViewController.view removeFromSuperview];
    }
    
    UIViewController *viewController = self.wordViewController ;
    self.wordViewController.imageArray = self.imageArray;
    [self addChildViewController:viewController];
    [self.container addSubview:viewController.view];
    if (_flag==0) {
        if (_pushText.length>0) {
            self.wordViewController.textView.attributedText = [_pushText copy];
        }
        _flag+=1;
    }
    viewController.view.frame = self.container.bounds;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable =NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable =YES;
}
@end
