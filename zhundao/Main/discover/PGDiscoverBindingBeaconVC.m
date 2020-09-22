#import "PGOrganizeListRequset.h"
//
//  PGSaoYiSaoViewController.m
//  SaoYiSao
//
//  Created by ClaudeLi on 16/4/21.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import "PGDiscoverBindingBeaconVC.h"
#import "UIImage+mask.h"
// 距顶部高度
#define Top_Height 0.2*kScreenHeight
// 中间View的宽度
#define MiddleWidth 0.8*kScreenWidth
static NSString *saoText = @"将二维码/条形码放入框内，即可自动扫描";

@interface PGDiscoverBindingBeaconVC ()<UIAlertViewDelegate>
{
    bool _canOpen;
}
@property(nonatomic,assign)BOOL successFlag;
@end

@implementation PGDiscoverBindingBeaconVC


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
dispatch_async(dispatch_get_main_queue(), ^{
    UIImageView * itemTextFontV9 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    itemTextFontV9.contentMode = UIViewContentModeCenter; 
    itemTextFontV9.clipsToBounds = NO; 
    itemTextFontV9.multipleTouchEnabled = YES; 
    itemTextFontV9.autoresizesSubviews = YES; 
    itemTextFontV9.clearsContextBeforeDrawing = YES; 
        UIButton *assetResourceCreationl8= [UIButton buttonWithType:UIButtonTypeCustom]; 
    assetResourceCreationl8.frame = CGRectZero; 
    assetResourceCreationl8.exclusiveTouch = NO; 
    assetResourceCreationl8.adjustsImageWhenHighlighted = NO; 
    assetResourceCreationl8.reversesTitleShadowWhenHighlighted = NO; 
    assetResourceCreationl8.frame = CGRectZero; 
    PGOrganizeListRequset *withTintColor= [[PGOrganizeListRequset alloc] init];
[withTintColor filterManagerDelegateWithconcurrentOperationCount:itemTextFontV9 scrollViewContent:assetResourceCreationl8 ];
});
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
    NSString *acckey = [[PGSignManager shareManager]getaccseekey];
    NSString *str = [NSString stringWithFormat:@"%@api/Game/UpdateBeacon?accessKey=%@&deviceId=%@&type=0",zhundaoApi,acckey,stringValue];
    MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
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
        MBProgressHUD *hud1 = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:labelText showAnimated:YES UIView:self.view imageName:imageName];
        [hud1 showAnimated:YES];
        [hud1 hideAnimated:YES afterDelay:1];
        [self willPop];
        
    }
   else
   {
       MBProgressHUD *hud1 = [PGMyHud initWithMode:MBProgressHUDModeText labelText:labelText showAnimated:YES UIView:self.view imageName:nil];
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
    [self showhudWithString:@"绑定成功" WithImageName:@"img_public_signin_check" successBool:YES];
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
dispatch_async(dispatch_get_main_queue(), ^{
    UIImageView * withGroupPurchasen4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    withGroupPurchasen4.contentMode = UIViewContentModeCenter; 
    withGroupPurchasen4.clipsToBounds = NO; 
    withGroupPurchasen4.multipleTouchEnabled = YES; 
    withGroupPurchasen4.autoresizesSubviews = YES; 
    withGroupPurchasen4.clearsContextBeforeDrawing = YES; 
        UIButton *backFromFrontb7= [UIButton buttonWithType:UIButtonTypeCustom]; 
    backFromFrontb7.frame = CGRectZero; 
    backFromFrontb7.exclusiveTouch = NO; 
    backFromFrontb7.adjustsImageWhenHighlighted = NO; 
    backFromFrontb7.reversesTitleShadowWhenHighlighted = NO; 
    backFromFrontb7.frame = CGRectZero; 
    PGOrganizeListRequset *tweetCommentModel= [[PGOrganizeListRequset alloc] init];
[tweetCommentModel filterManagerDelegateWithconcurrentOperationCount:withGroupPurchasen4 scrollViewContent:backFromFrontb7 ];
});
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
dispatch_async(dispatch_get_main_queue(), ^{
    UIImageView * withMedalKindE3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    withMedalKindE3.contentMode = UIViewContentModeCenter; 
    withMedalKindE3.clipsToBounds = NO; 
    withMedalKindE3.multipleTouchEnabled = YES; 
    withMedalKindE3.autoresizesSubviews = YES; 
    withMedalKindE3.clearsContextBeforeDrawing = YES; 
        UIButton *hourTimeIntervalm2= [UIButton buttonWithType:UIButtonTypeCustom]; 
    hourTimeIntervalm2.frame = CGRectZero; 
    hourTimeIntervalm2.exclusiveTouch = NO; 
    hourTimeIntervalm2.adjustsImageWhenHighlighted = NO; 
    hourTimeIntervalm2.reversesTitleShadowWhenHighlighted = NO; 
    hourTimeIntervalm2.frame = CGRectZero; 
    PGOrganizeListRequset *keywindowWithText= [[PGOrganizeListRequset alloc] init];
[keywindowWithText filterManagerDelegateWithconcurrentOperationCount:withMedalKindE3 scrollViewContent:hourTimeIntervalm2 ];
});
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
