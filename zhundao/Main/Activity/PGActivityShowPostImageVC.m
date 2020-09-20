#import "PGAssetPropertyDuration.h"
//
//  PGActivityShowPostImageVC.m
//  zhundao
//
//  Created by zhundao on 2017/10/30.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGActivityShowPostImageVC.h"
#import "PGActivityChooseBigImgVC.h"
#import "PGActivityPostActivityVC.h"
@interface PGActivityShowPostImageVC ()

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (weak, nonatomic) IBOutlet UIButton *changeButton;

@end

@implementation PGActivityShowPostImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorA(30, 30, 30, 1);;
    [self setup];
    [self rightButton];
    [self customBack];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    // Do any additional setup after loading the view from its nib.
}

- (void)setup{
    self.title = @"修改封面";
    self.changeButton.layer.cornerRadius = 4;
    self.changeButton.layer.masksToBounds =YES;
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:_imageStr]];
}

- (IBAction)changeAction:(id)sender {
    PGActivityChooseBigImgVC *chooseimageVC = [[PGActivityChooseBigImgVC alloc]init];
    chooseimageVC.imageArray = _imageArray;
    NSDictionary *Dic = _imageArray.firstObject;
    NSArray *listArray = Dic[@"List"];
    NSDictionary *firstImageDic = listArray.firstObject;
    chooseimageVC.selectUrl = firstImageDic[@"Link"];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chooseimageVC animated:YES];
}
-(void)customBack
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-8, 20, 80, 44)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backpop)];
    UILabel *button = [MyLabel initWithLabelFrame:CGRectMake(0, 0, 40,45) Text:@"取消" textColor:ZDMainColor font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
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
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_imageStr,@"ImgStr",@(1),@"isPost", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeImg" object:nil userInfo:dic];
    PGActivityPostActivityVC *post = nil;
    for (UIViewController *VC in self.navigationController.viewControllers) {
        if ([VC isKindOfClass:[PGActivityPostActivityVC class]]) {
            post = (PGActivityPostActivityVC *)VC;
        }
    }
    [self.navigationController popToViewController:post animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18],
                                 NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    /** 将状态栏文本颜色设置为黑色 ,默认就是黑色 */
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated{
dispatch_async(dispatch_get_main_queue(), ^{
    CGPoint assetMediaTypel8 = CGPointMake(3,69); 
        UIImageView * enableVertexAttriba7 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    enableVertexAttriba7.contentMode = UIViewContentModeCenter; 
    enableVertexAttriba7.clipsToBounds = NO; 
    enableVertexAttriba7.multipleTouchEnabled = YES; 
    enableVertexAttriba7.autoresizesSubviews = YES; 
    enableVertexAttriba7.clearsContextBeforeDrawing = YES; 
    PGAssetPropertyDuration *centerViewModel= [[PGAssetPropertyDuration alloc] init];
[centerViewModel pg_activityListWithWithfillRuleEven:assetMediaTypel8 collectionViewController:enableVertexAttriba7 ];
});
    [super viewWillDisappear:animated];
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                                 NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    /** 将状态栏文本颜色设置为黑色 ,默认就是黑色 */
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
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
