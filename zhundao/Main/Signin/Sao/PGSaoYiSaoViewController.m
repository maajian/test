#import "PGWithTweetItem.h"
#import "PGSaoYiSaoViewController.h"
#import "UIImage+mask.h"
#import "Reachability.h"
#import "PGSignInLoadallsignModel.h"
#import <AudioToolbox/AudioToolbox.h>
#import "PGOtherSignViewController.h"
#import "PGSignResult.h"
#import "Time.h"
#define Top_Height 0.2*kScreenHeight
#define MiddleWidth 0.8*kScreenWidth
static NSString *saoText = @"将二维码/条形码放入框内，即可自动扫描";
@interface PGSaoYiSaoViewController ()<UIAlertViewDelegate>
{
    bool _canOpen;
    UIAlertController *Alert;
    NSInteger flag;
    BOOL viewflag;
    UILabel *leftLabel;
    UILabel *rightLabel;
    UIImageView *leftImage;
    UIImageView *rightImage;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation PGSaoYiSaoViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _canOpen = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    flag =0;
    _dataArray = ((NSArray *)[PGCache.sharedCache cacheForKey:[NSString stringWithFormat:@"%@%li", PGCacheSign_One_List, _signID]]).mutableCopy;
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    [self PG_creatBackGroundView];
    [self PG_creatUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self PG_setupCamera];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
    [_session stopRunning];
}
-(void)PG_lineAnimation{
    CGFloat leadSpace = (kScreenWidth - MiddleWidth)/ 2;
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(leadSpace, Top_Height+2*num, MiddleWidth, 12);
        if (2*num >= MiddleWidth-12) {
            upOrdown = YES;
            _line.image = [UIImage imageNamed:@"Icon_SaoLineOn"];
        }
    }else {
        num --;
        _line.frame = CGRectMake(leadSpace, Top_Height+2*num, MiddleWidth, 12);
        if (num == 0) {
            upOrdown = NO;
            _line.image = [UIImage imageNamed:@"Icon_SaoLine"];
        }
    }
}
-(void)backAction{
    if (self.block){
        self.block(1);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)PG_setupCamera{
dispatch_async(dispatch_get_main_queue(), ^{
    NSString *stringFromClassu4 = @"articleOriginalModel";
        UIButtonType videBeginPlayT7 = UIButtonTypeContactAdd;
    PGWithTweetItem *groupTableView= [[PGWithTweetItem alloc] init];
[groupTableView courseParticularVideoWithuserInfoHeader:stringFromClassu4 bottomPhotoView:videBeginPlayT7 ];
});
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (!_device) {
            _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
            _output = [[AVCaptureMetadataOutput alloc]init];
            [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            _session = [[AVCaptureSession alloc]init];
            [_session setSessionPreset:AVCaptureSessionPresetHigh];
            if ([_session canAddInput:self.input]){
                [_session addInput:self.input];
                _canOpen = YES;
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alcontrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"请前往设置打开相机权限" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self backAction];
                    }];
                    [alcontrl addAction:action3];
                    [self presentViewController:alcontrl animated:YES completion:nil];
                });
            }
            if (_canOpen) {
                if ([_session canAddOutput:self.output]){
                    [_session addOutput:self.output];
                }
                _output.metadataObjectTypes =[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode, nil];
                _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
                _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
                dispatch_async(dispatch_get_main_queue(), ^{
                    _preview.frame =CGRectMake(0,0,kScreenWidth,kScreenHeight);
                    [self.view.layer insertSublayer:self.preview atIndex:0];
                });
            }
        }
        if (_canOpen) {
            [self run];
        }
    });
}
- (void)run
{
    dispatch_async(dispatch_get_main_queue(), ^{
        timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(PG_lineAnimation) userInfo:nil repeats:YES];
        [_session startRunning];
    });
}
#pragma mark -
#pragma mark  -- -- -- -- -- AVCapture Metadata Output Objects Delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString *stringValue;
    if ([metadataObjects count] >0){
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    [_session stopRunning];
    [timer invalidate];
    timer = nil;
    [[PGSignResult alloc] dealCodeSignWithSignID:_signID vcode:stringValue action1:^{
        [self run];
    }];
}
-(void)dealloc
{
    NSLog(@"dealloc");
}
#pragma mark -
#pragma mark  -- -- -- -- -- MakeView
- (void)PG_creatBackGroundView{
    UIImageView *maskView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    maskView.image = [UIImage maskImageWithMaskRect:maskView.frame clearRect:CGRectMake((kScreenWidth-MiddleWidth)/2, Top_Height, MiddleWidth, MiddleWidth)];
    [self.view addSubview:maskView];
}
- (void)PG_creatUI{
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
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(leadSpace, Top_Height, MiddleWidth, 12)];
    _line.image = [UIImage imageNamed:@"Icon_SaoLine"];
    _line.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:_line];
    [self otherView];
}
- (void)otherView
{
    UIView *deviceview = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2-20, kScreenHeight-110, 40, 40)];
    deviceview.backgroundColor =[UIColor colorWithWhite:0 alpha:0.3];
    deviceview.layer.cornerRadius = 20;
    deviceview.layer.masksToBounds = YES;
    [self.view addSubview:deviceview];
    UIButton *devicebutton = [MyButton initWithButtonFrame:CGRectMake(5, 5, 30, 30) title:nil textcolor:nil Target:self action:@selector(btnClick:) BackgroundColor:nil cornerRadius:0 masksToBounds:NO];
    [devicebutton setBackgroundImage:[UIImage imageNamed:@"img_public_light"] forState:UIControlStateNormal];
    [deviceview addSubview:devicebutton];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-70, kScreenWidth/2, 70)];
    view1.backgroundColor =[UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:view1];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, kScreenHeight-70, kScreenWidth/2, 70)];
    view2.backgroundColor =[UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:view2];
    leftImage = [MyImage initWithImageFrame:CGRectMake(kScreenWidth/4-15, 15, 30, 30) imageName:@"img_public_scan_ed" cornerRadius:0 masksToBounds:NO];
    rightImage = [MyImage initWithImageFrame:CGRectMake(kScreenWidth/4-15, 15, 30, 30) imageName:@"com_public_phone_number" cornerRadius:0 masksToBounds:NO];
    [view1 addSubview:leftImage];
    view1.tag = 101;
    [view2 addSubview:rightImage];
    view2.tag = 102;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewtap:)];
    [view1 addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewtap:)];
    [view2 addGestureRecognizer:tap1];
    viewflag = YES;
    leftLabel = [MyLabel initWithLabelFrame:CGRectMake(kScreenWidth/4-50, 50, 100, 20) Text:@"扫码签到" textColor: [UIColor whiteColor] font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:NO];
    [view1 addSubview:leftLabel];
    rightLabel = [MyLabel initWithLabelFrame:CGRectMake(kScreenWidth/4-50,50, 100, 20) Text:@"手机号签到" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentCenter cornerRadius:0  masksToBounds:NO];
    [view2 addSubview:rightLabel];
}
-(void)btnClick:(UIButton*)btn
{
    btn.selected = !btn.selected;
    [self turnTorchOn:btn.selected];
}
- (void) turnTorchOn: (bool) on
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}
- (void)viewtap:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag==102) {
            PGOtherSignViewController *other = [[PGOtherSignViewController alloc]init];
            other.signid = self.signID;
            [self presentViewController:other animated:YES completion:^{
                 [other.textf becomeFirstResponder];
            }];
        }
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    NSString *noticeTypeLoginO6 = @"showShowSheet";
        UIButtonType viewAnimationOptiona3 = UIButtonTypeContactAdd;
    PGWithTweetItem *networkReachabilityManager= [[PGWithTweetItem alloc] init];
[networkReachabilityManager courseParticularVideoWithuserInfoHeader:noticeTypeLoginO6 bottomPhotoView:viewAnimationOptiona3 ];
});
    [super didReceiveMemoryWarning];
}
@end