#import "PGTrainCommentView.h"
//
//  PGMeChangeInfoVC.m
//  zhundao
//
//  Created by zhundao on 2017/11/1.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGMeChangeInfoVC.h"
#import "UITextField+TextLeftOffset_ffset.h"
#import "PGMeChangeInfoViewModel.h"
@interface PGMeChangeInfoVC ()

@property(nonatomic,strong)UITextField *textf;

@property(nonatomic,strong)PGMeChangeInfoViewModel *viewModel;
/*! 上传的key的数组 */
@property(nonatomic,copy)NSArray *postKeyArray;

@end

@implementation PGMeChangeInfoVC

- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    NSLineBreakMode zoneWithAbbreviationr0 = NSLineBreakByTruncatingTail; 
        CGRect valueObservingOptionsq1 = CGRectZero;
    PGTrainCommentView *couponTypeIntegral= [[PGTrainCommentView alloc] init];
[couponTypeIntegral userInterfaceIdiomWithshareViewDelegate:zoneWithAbbreviationr0 filterWithCode:valueObservingOptionsq1 ];
});
    [super viewDidLoad];
    _viewModel = [[PGMeChangeInfoViewModel alloc]init];
    [self.view addSubview:self.textf];
     [_textf becomeFirstResponder];
    [self customBack];
    [self rightButton];
    _postKeyArray = @[@"headImgurl",@"trueName",@"nickName",@"mobile",@"email",@"sex",@"company",@"industry",@"duty"];
    // Do any additional setup after loading the view.
}

- (UITextField *)textf{
    if (!_textf) {
        _textf = [myTextField initWithFrame:CGRectMake(0, 8, kScreenWidth, 44) placeholder:nil font:[UIFont systemFontOfSize:14] TextAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        _textf.backgroundColor = [UIColor whiteColor];
        /*! 设置text */
        if ([_oriStr isEqualToString:@"未填写"]) {
            _textf.text = @"";
        }else{
            _textf.text = _oriStr;
        }
        /*! 设置往右移动一点 */
        [_textf setTextOffsetWithLeftViewRect:CGRectMake(0, 0, 20, 44) WithMode:UITextFieldViewModeAlways];
        _textf.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _textf;
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
-(void)rightButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    NSDictionary *dic = @{NSFontAttributeName : KHeitiSCMedium(17),
                          NSForegroundColorAttributeName:ZDMainColor};
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)backpop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)save{
    [self.view endEditing:YES];
    NSDictionary *sexDic = @{_postKeyArray[_cellTag]:_textf.text};
    MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    hud.label.text = @"正在加载";
    __weak typeof(self) weakSelf = self;
    [_viewModel UpdateUserInfo:sexDic successBlock:^(id responseObject) {
        [hud hideAnimated:YES afterDelay:0.5];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    } errorBlock:^(NSError *error) {
        [hud hideAnimated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
