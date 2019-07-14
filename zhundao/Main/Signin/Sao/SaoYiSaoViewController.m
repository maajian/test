//
//  SaoYiSaoViewController.m
//  SaoYiSao
//
//  Created by ClaudeLi on 16/4/21.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import "SaoYiSaoViewController.h"
#import "UIImage+mask.h"
#import "Reachability.h"
#import "LoadallsignModel.h"
#import <AudioToolbox/AudioToolbox.h>
#import "otherSignViewController.h"
#import "signResult.h"
#import "Time.h"
// 距顶部高度
#define Top_Height 0.2*kScreenHeight
// 中间View的宽度
#define MiddleWidth 0.8*kScreenWidth

static NSString *saoText = @"将二维码/条形码放入框内，即可自动扫描";

@interface SaoYiSaoViewController ()<UIAlertViewDelegate>
{
    bool _canOpen;
    
    NSString *acckey;
     Reachability *r;
    NSMutableArray *array;
    NSMutableArray *array1;
    NSMutableArray *array2;
    
    NSMutableArray *dataarr;
    NSMutableArray *dataarr1;
    NSMutableArray *dataarr2;
    NSString *vcode;
    UIAlertController *Alert;
    NSInteger flag;
    BOOL viewflag;
    UILabel *leftLabel;
    UILabel *rightLabel;
    UIImageView *leftImage;
    UIImageView *rightImage;
}

@end

@implementation SaoYiSaoViewController

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
 array = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"all%li",(long)self.signID]] mutableCopy];
    array1 = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"sign%li",(long)self.signID]] mutableCopy];
    array2 = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"signed%li",(long)self.signID]]mutableCopy];
  

    SignManager *manager= [SignManager shareManager];
    acckey = [manager getaccseekey];
    
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    [self creatBackGroundView];
    [self creatUI];
}

-(void)viewWillAppear:(BOOL)animated
{  [super viewWillAppear:animated];
    [self setupCamera];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
    [_session stopRunning];
}

-(void)lineAnimation{
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

- (void)setupCamera{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Device
        if (!_device) {
            _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            // Input
            _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
            
            // Output
            _output = [[AVCaptureMetadataOutput alloc]init];
            [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            
            // Session
            _session = [[AVCaptureSession alloc]init];
            [_session setSessionPreset:AVCaptureSessionPresetHigh];
            if ([_session canAddInput:self.input]){
                [_session addInput:self.input];
                _canOpen = YES;
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    //回到主线程
//                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"打开相机权限" preferredStyle:UIAlertControllerStyleAlert]
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
                // 条形码/二维码
                _output.metadataObjectTypes =[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode, nil];
                // 只支持二维码
//                _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
                
                // Preview
                _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
                _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
                dispatch_async(dispatch_get_main_queue(), ^{
                    //回到主线程
                    _preview.frame =CGRectMake(0,0,kScreenWidth,kScreenHeight);
                    [self.view.layer insertSublayer:self.preview atIndex:0];
                });
            }
        }
        // Start
        if (_canOpen) {
            [self run];
        }
    });
}
- (void)run
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //回到主线程
        timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(lineAnimation) userInfo:nil repeats:YES];
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
    NSLog(@"string = %@",stringValue);
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"暂无网络");
        {
            SignManager *manager = [SignManager shareManager];
            [manager createDatabase];
            NSString *timeStr = [[Time alloc]nextDateWithNumber:0];
            dataarr = [NSMutableArray array];
            dataarr1 = [NSMutableArray array];
              dataarr2 = [NSMutableArray array];
            if ([manager.dataBase open]) {
                NSString *sql = [NSString stringWithFormat:@"SELECT * FROM signList WHERE signID = %li",(long)_signID];
                FMResultSet * rs = [manager.dataBase executeQuery:sql];
                while ([rs next]) {
                    if ([[rs stringForColumn:@"VCode"] isEqualToString:stringValue]) {  //如果找到vcode一致的
                        flag=1;
               [manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET Status = '1'  where VCode = '%@' AND signID = %li",stringValue,(long)_signID]];   //更新数据库的vcode
             [manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET post = '0'  where VCode = '%@' AND signID = %li",stringValue,(long)_signID]];
            [manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET addTime = '%@'  where VCode = '%@' AND signID = %li",timeStr,stringValue,(long)_signID]];
                        for (int i=0; i<array.count; i++) {
                            NSDictionary *acdic = [array objectAtIndex:i];
                            NSMutableDictionary *e =  [acdic mutableCopy];
                          
                            for (NSString *keystr in acdic.allKeys) {
                                
                                if ([keystr isEqualToString:@"VCode"]) {
                                      NSLog(@"status = %@",[acdic valueForKey:@"Status"]);
                                    if ([[acdic valueForKey:keystr] isEqualToString:stringValue]) {
                                     
                                        if ([[acdic valueForKey:@"Status"]integerValue]==0) {
                                            [e  setValue:@"1" forKey:@"Status"];
                                            [array removeObjectAtIndex:i];
                                            [array addObject:e];            
                                            [array2 addObject:e];  //array2   已经签到
                                            SystemSoundID soundID = 1102;
                                            AudioServicesPlaySystemSound(soundID);
                                            [[signResult alloc]showallWithFMResultSet:rs withdic:acdic actionWithTitle1:@"返回主界面" actionWithTitle2:@"继续扫码" withAction1:^(TYAlertAction *action1) {
                                                [self backAction];
                                            } withAction2:^(TYAlertAction *action1) {
                                                [self run];
                                            } otherSign:NO withCtr:self];
                                           
                                            
                                        }
                                        if ([[acdic valueForKey:@"Status"]integerValue]==1) {
                                            SystemSoundID soundID = 1102;
                                            AudioServicesPlaySystemSound(soundID);
                                            [[signResult alloc]showallWithFMResultSet:rs withdic:acdic actionWithTitle1:@"返回主界面" actionWithTitle2:@"继续扫码" withAction1:^(TYAlertAction *action1) {
                                                [self backAction];
                                            } withAction2:^(TYAlertAction *action1) {
                                                [self run];
                                            } otherSign:NO withCtr:self];
                                        }
                                    }
                               
                                }
                                
                            }
                         
                          
                    }
                      
                        
                        for (int i=0; i<array1.count; i++) {
                            NSDictionary *acdic = [array1 objectAtIndex:i];
        
                            for (NSString *keystr in acdic.allKeys) {
                                
                                if ([keystr isEqualToString:@"VCode"]) {
                                    if ([[acdic valueForKey:keystr] isEqualToString:stringValue])  {
                                    
                                    [array1 removeObjectAtIndex:i];
                                    break;
                                }
                                }
                            }
                            
                            
                        }
                }
                    dataarr = [array copy];
                    dataarr1 = [array1 copy];
                    dataarr2 = [array2 copy];
            }
                if (flag==0)
                    
                {  SystemSoundID soundID = 1102;
                    AudioServicesPlaySystemSound(soundID);
                    [[SignManager shareManager]showAlertWithTitle:@"扫描结果" WithMessage:@"签到失败 凭证码无效" WithTitleOne:@"返回主界面" WithActionOne:^(TYAlertAction *action1) {
                          [self backAction];
                    } WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:@"继续扫码" WithActionTwo:^(TYAlertAction *action1) {
                        [self run];
                    } WithCTR:self];
                }
                [manager.dataBase close];
                [[NSUserDefaults standardUserDefaults]setObject:dataarr forKey:[NSString stringWithFormat:@"all%li",(long)_signID]];
                
                [[NSUserDefaults standardUserDefaults]setObject:dataarr1 forKey:[NSString stringWithFormat:@"sign%li",(long)_signID]];
                [[NSUserDefaults standardUserDefaults]setObject:dataarr2 forKey:[NSString stringWithFormat:@"signed%li",(long)_signID]];
                  [[NSUserDefaults standardUserDefaults]synchronize];
            }
            
        
        }
       
            break;
        case ReachableViaWiFi:{
            NSLog(@"使用wifi");
            NSString *str = [NSString stringWithFormat:@"%@api/CheckIn/AddCheckInListByQrcode?accessKey=%@&vCode=%@&checkInId=%li&checkInWay=6",zhundaoApi,acckey,stringValue,(long)self.signID];

            AFmanager *manager = [AFmanager shareManager];
            [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"respondse = %@",responseObject);
                NSDictionary *dic= [NSDictionary dictionaryWithDictionary:responseObject];
                
                [self getDataWithData:dic WithStringValue:stringValue];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error = %@",error);
            }];
        }
            
            break;
        case ReachableViaWWAN:
        {
            NSLog(@"使用流量");
            NSString *str = [NSString stringWithFormat:@"%@api/CheckIn/AddCheckInListByQrcode?accessKey=%@&vCode=%@&checkInId=%li&checkInWay=6",zhundaoApi,acckey,stringValue,(long)self.signID];
            
            AFmanager *manager = [AFmanager shareManager];
            [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"respondse = %@",responseObject);
                NSDictionary *dic= [NSDictionary dictionaryWithDictionary:responseObject];
                [self getDataWithData:dic WithStringValue:stringValue];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error = %@",error);
            }];
        }
            break;
        default:
            break;
    }
}
-(void)getDataWithData:(NSDictionary *)dic  WithStringValue:(NSString *)stringValue
{
    NSMutableDictionary *Data = nil;
    if ( ! [dic[@"Data"] isEqual:[NSNull null]]){
         Data =[dic[@"Data"] mutableCopy];
         for (NSString *keystr in Data.allKeys) {
        if ([[Data valueForKey:keystr] isEqual:[NSNull null]]) {
            [Data setObject:@"" forKey:keystr];
        }
    }
    }
    NSInteger res =[dic[@"Res"]integerValue];
    NSString *Url = dic[@"Url"];
    
    NSString *phone = nil;
    NSString *Mobile =Data[@"Phone"];
    if (Mobile.length>7) {
        phone = [Mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    
    if (res==0&&[Url isEqualToString:@"100"]) {
        SystemSoundID soundID = 1102;
        AudioServicesPlaySystemSound(soundID);
        [[signResult alloc]getDataWithData:Data WithStringValue:stringValue withID:_signID WithSignBool:1 withSigncheckInWay:6 WithPhone:phone Withtitle1:@"返回主界面" Withtitle2:@"继续扫码" WithAction1:^(TYAlertAction *action1) {
            [self backAction];
        } WithAction1:^(TYAlertAction *action1) {
            [self run];
        } otherSign:NO WithCtr:self];
    }
    else  if (res==0&&[Url isEqualToString:@"101"]) {
        SystemSoundID soundID = 1102;
        AudioServicesPlaySystemSound(soundID);
        [[signResult alloc]getDataWithData:Data WithStringValue:stringValue withID:_signID WithSignBool:0 withSigncheckInWay:6 WithPhone:phone Withtitle1:@"返回主界面" Withtitle2:@"继续扫码" WithAction1:^(TYAlertAction *action1) {
            [self backAction];
        } WithAction1:^(TYAlertAction *action1) {
            [self run];
        } otherSign:NO WithCtr:self];
    
    }
    else
    {
        
        SystemSoundID soundID = 1102;
        AudioServicesPlaySystemSound(soundID);
        [[SignManager shareManager]showAlertWithTitle:@"扫描结果" WithMessage:@"签到失败 凭证码无效"  WithTitleOne:@"返回主界面" WithActionOne:^(TYAlertAction *action1) {
            [self backAction];
        } WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:@"继续扫码"  WithActionTwo:^(TYAlertAction *action1) {
            [self run];
        } WithCTR:self];
    }
    

}

-(void)dealloc
{
    NSLog(@"dealloc");
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
    [devicebutton setBackgroundImage:[UIImage imageNamed:@"灯光"] forState:UIControlStateNormal];
    [deviceview addSubview:devicebutton];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-70, kScreenWidth/2, 70)];
    view1.backgroundColor =[UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:view1];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, kScreenHeight-70, kScreenWidth/2, 70)];
    view2.backgroundColor =[UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:view2];
    leftImage = [MyImage initWithImageFrame:CGRectMake(kScreenWidth/4-15, 15, 30, 30) imageName:@"扫码签到ed" cornerRadius:0 masksToBounds:NO];
    rightImage = [MyImage initWithImageFrame:CGRectMake(kScreenWidth/4-15, 15, 30, 30) imageName:@"手机号" cornerRadius:0 masksToBounds:NO];
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

            otherSignViewController *other = [[otherSignViewController alloc]init];
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
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
