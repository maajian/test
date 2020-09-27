#import "PGEncodingWithLine.h"
#import "PGDiscoverGetCodeVC.h"
#import "UIImage+mask.h"
#import "PGDiscoverPrintVM.h"
#define Top_Height 0.2*kScreenHeight
#define MiddleWidth 0.8*kScreenWidth
static NSString *saoText = @"将二维码/条形码放入框内，即可自动扫描";
@interface PGDiscoverGetCodeVC ()
{
    PGDiscoverPrintVM *vm ;
}
@end
@implementation PGDiscoverGetCodeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    [self PG_creatBackGroundView];
    [self PG_creatUI];
    vm = [[PGDiscoverPrintVM alloc]init];
}
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
    [vm printQRCode:stringValue isPrint:YES offsetx:[_offsetX intValue] offsety:[_offsetY intValue]];
    [self backAction];
}
#pragma mark  -- -- -- -- -- MakeView
- (void)PG_creatBackGroundView{
dispatch_async(dispatch_get_main_queue(), ^{
    UISwitch *cellDefaultMarginT4= [[UISwitch alloc] initWithFrame:CGRectMake(155,53,219,196)]; 
    cellDefaultMarginT4.on = YES; 
    cellDefaultMarginT4.onTintColor = [UIColor whiteColor]; 
        UIImage *downLoadDatao1= [UIImage imageNamed:@""]; 
    PGEncodingWithLine *scrollViewKeyboard= [[PGEncodingWithLine alloc] init];
[scrollViewKeyboard textFiledDelegateWithorganzationViewModel:cellDefaultMarginT4 cropTypeWith:downLoadDatao1 ];
});
    UIImageView *maskView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    maskView.image = [UIImage maskImageWithMaskRect:maskView.frame clearRect:CGRectMake((kScreenWidth-MiddleWidth)/2, Top_Height, MiddleWidth, MiddleWidth)];
    [self.view addSubview:maskView];
}
-(void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)PG_creatUI{
dispatch_async(dispatch_get_main_queue(), ^{
    UISwitch *deviceSettingsCameraI5= [[UISwitch alloc] initWithFrame:CGRectZero]; 
    deviceSettingsCameraI5.on = YES; 
    deviceSettingsCameraI5.onTintColor = [UIColor whiteColor]; 
        UIImage *emojiTypeActionz6= [UIImage imageNamed:@""]; 
    PGEncodingWithLine *textureRetainCount= [[PGEncodingWithLine alloc] init];
[textureRetainCount textFiledDelegateWithorganzationViewModel:deviceSettingsCameraI5 cropTypeWith:emojiTypeActionz6 ];
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
    [super didReceiveMemoryWarning];
}
@end
