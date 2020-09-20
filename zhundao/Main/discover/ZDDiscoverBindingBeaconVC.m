//
//  ZDSaoYiSaoViewController.m
//  SaoYiSao
//
//  Created by ClaudeLi on 16/4/21.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import "ZDDiscoverBindingBeaconVC.h"
#import "UIImage+mask.h"
// 距顶部高度
#define Top_Height 0.2*kScreenHeight
// 中间View的宽度
#define MiddleWidth 0.8*kScreenWidth
static NSString *saoText = @"将二维码/条形码放入框内，即可自动扫描";

@interface ZDDiscoverBindingBeaconVC ()<UIAlertViewDelegate>
{
    bool _canOpen;
}
@property(nonatomic,assign)BOOL successFlag;
@end

@implementation ZDDiscoverBindingBeaconVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    [self creatBackGroundView];
    [self creatUI];
    _successFlag = 0;
}

-(void)backAction{
    if (_successFlag) {
         _backblock(_successFlag);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark  -- -- -- -- -- AVCapture Metadata Output Objects Delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString *stringValue;
    if ([metadataObjects count] >0){
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    [self.session stopRunning];
    [timer invalidate];
    timer = nil;
    NSLog(@"%@",stringValue);
    [self netWorkWithstringValue:stringValue];
}
- (void)netWorkWithstringValue:(NSString *)stringValue
{
    NSString *acckey = [[ZDSignManager shareManager]getaccseekey];
    NSString *str = [NSString stringWithFormat:@"%@api/Game/UpdateBeacon?accessKey=%@&deviceId=%@&type=0",zhundaoApi,acckey,stringValue];
    MBProgressHUD *hud = [ZDMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        [hud hideAnimated:YES];
        [self succseeresponseObject:dic];
    } fail:^(NSError *error) {
        [hud hideAnimated:YES];
        [self showhudWithString:@"绑定失败" WithImageName:nil successBool:0];
    }];
}
- (void)showhudWithString :(NSString *)labelText WithImageName :(NSString *)imageName successBool :(BOOL )isSuccess
{
    
    if (isSuccess) {
        MBProgressHUD *hud1 = [ZDMyHud initWithMode:MBProgressHUDModeCustomView labelText:labelText showAnimated:YES UIView:self.view imageName:imageName];
        [hud1 showAnimated:YES];
        [hud1 hideAnimated:YES afterDelay:1];
        [self willPop];
        
    }
   else
   {
       MBProgressHUD *hud1 = [ZDMyHud initWithMode:MBProgressHUDModeText labelText:labelText showAnimated:YES UIView:self.view imageName:nil];
       [hud1 showAnimated: YES];
        [hud1 hideAnimated:YES afterDelay:1];
       [self willPop];
   }
}
- (void)willPop
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self backAction];
    });
}
- (void)succseeresponseObject:(NSDictionary *)dic
{
    NSInteger isSeccess = [dic[@"Res"] integerValue];
    if (isSeccess) {
        _successFlag = 0;
         [self showhudWithString:dic[@"Msg"] WithImageName:nil successBool:0];
    }
    else
    {
        _successFlag =1;
    [self showhudWithString:@"绑定成功" WithImageName:@"签到打勾" successBool:YES];
    }
}


#pragma mark -
#pragma mark  -- -- -- -- -- MakeView

- (void)creatBackGroundView{
    UIImageView *maskView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    maskView.image = [UIImage maskImageWithMaskRect:maskView.frame clearRect:CGRectMake((kScreenWidth-MiddleWidth)/2, Top_Height, MiddleWidth, MiddleWidth)];
    [self.view addSubview:maskView];
}

- (void)creatUI{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.frame = CGRectMake(10, 24, 32, 32);
    [backBtn setImage:[[UIImage imageNamed:@"anniu"] imageWithRenderingMode:
                       UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(0, Top_Height+MiddleWidth + 20, kScreenWidth, 35)];
    labIntroudction.numberOfLines=2;
    labIntroudction.text= saoText;
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.textColor = [UIColor whiteColor];
    labIntroudction.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:labIntroudction];
    
    CGFloat leadSpace = (kScreenWidth - MiddleWidth)/ 2;
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(leadSpace, Top_Height, MiddleWidth, MiddleWidth)];
    imageView.image = [UIImage imageNamed:@"Icon_SaoYiSao"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
  self.line = [[UIImageView alloc] initWithFrame:CGRectMake(leadSpace, Top_Height, MiddleWidth, 12)];
   self.line.image = [UIImage imageNamed:@"Icon_SaoLine"];
  self.line.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.line];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
