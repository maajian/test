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
    NSString  *sign;
    NSString *vcode;
    UIAlertController *Alert;
    NSInteger flag;
   
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
    sign = @"0";
    flag =0;
 array = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"all%li",(long)self.signID]] mutableCopy];
    array1 = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"sign%li",(long)self.signID]] mutableCopy];
    array2 = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"signed%li",(long)self.signID]]mutableCopy];
    NSLog(@"array = %@",array);
    
     NSLog(@"array1 = %@",array1);
     NSLog(@"array2 = %@",array2);
  
    
    
    
    
    
    
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
        self.block(sign);
        
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
            dispatch_async(dispatch_get_main_queue(), ^{
                //回到主线程
                timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(lineAnimation) userInfo:nil repeats:YES];
                [_session startRunning];
            });
        }
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
                                            sign =@"1";
                                            
                                            NSString *name = [acdic valueForKey:@"TrueName"];
                                            NSString *phone = [acdic valueForKey:@"Mobile"];
                                            
                                            
                                            UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"扫描结果" message:[NSString stringWithFormat:@"签到成功 姓名:%@ 手机号码:%@",name,phone] preferredStyle:UIAlertControllerStyleAlert];
                                            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                [self backAction];
                                            }];
                                            [alertCtrl addAction:action1];
                                            [self presentViewController:alertCtrl animated:YES completion:nil];
                                            
                                        }
                                        if ([[acdic valueForKey:@"Status"]integerValue]==1) {
                                            UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"扫描结果" message:@"已签到" preferredStyle:UIAlertControllerStyleAlert];
                                            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                [self backAction];
                                            }];
                                            [alertCtrl addAction:action1];
                                            [self presentViewController:alertCtrl animated:YES completion:nil];
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
                    
                {
                    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"扫描结果" message:@"签到失败 凭证码无效" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self backAction];
                    }];
                    [alertCtrl addAction:action1];
                    [self presentViewController:alertCtrl animated:YES completion:nil];
                }
                [manager.dataBase close];
                
                
                
                
                
                SystemSoundID soundID = 1102;
                AudioServicesPlaySystemSound(soundID);
                
                
                
                
                
                
                [[NSUserDefaults standardUserDefaults]setObject:dataarr forKey:[NSString stringWithFormat:@"all%li",(long)_signID]];
                
                [[NSUserDefaults standardUserDefaults]setObject:dataarr1 forKey:[NSString stringWithFormat:@"sign%li",(long)_signID]];
                [[NSUserDefaults standardUserDefaults]setObject:dataarr2 forKey:[NSString stringWithFormat:@"signed%li",(long)_signID]];
                  [[NSUserDefaults standardUserDefaults]synchronize];
            }
            
            
        }
       
            break;
        case ReachableViaWiFi:{
            NSLog(@"使用wifi");
            NSString *str = [NSString stringWithFormat:@"https://open.zhundao.net/api/CheckIn/AddCheckInListByQrcode?accessKey=%@&vCode=%@&checkInId=%li",acckey,stringValue,(long)self.signID];

            AFHTTPSessionManager *manager = [AFmanager shareManager];
            [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"respondse = %@",responseObject);
                NSDictionary *dic= [NSDictionary dictionaryWithDictionary:responseObject];
                NSDictionary *Data =dic[@"Data"];
                NSInteger res =[dic[@"Res"]integerValue];
                NSString *Msg = dic[@"Msg"];
                 NSLog(@"msg = %@",Msg);
                if (res==0&&[Msg isEqualToString:@"签到成功"]) {
                    sign =@"1";
                    SignManager *manager = [SignManager shareManager];
                    [manager createDatabase];
                    if ([manager.dataBase open]) {
                        [manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET Status = '1'  where VCode = '%@' AND signID = %li",stringValue,(long)_signID]];   //更新数据库的vcode
                        [manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET post = '1'  where VCode = '%@' AND signID = %li",stringValue,(long)_signID]];                  }
                        Alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:[NSString stringWithFormat:@"签到成功 姓名:%@ 电话号码:%@",Data[@"Name"],Data[@"Phone"]]  preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self backAction];
                    }];
                    [Alert addAction:action1];
                    [self presentViewController:Alert animated:YES completion:nil];
                    
                }
              else  if (res==1&&[Msg isEqualToString:@"该用户已经签到!"]) {
                     Alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:@"该用户已经签到"  preferredStyle:UIAlertControllerStyleAlert];
                  UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                      [self backAction];
                  }];
                  [Alert addAction:action1];
                  [self presentViewController:Alert animated:YES completion:nil];
                }
                else
                {
                    
                    Alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:@"签到失败 凭证码无效"  preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self backAction];
                    }];
                    [Alert addAction:action1];
                    [self presentViewController:Alert animated:YES completion:nil];
                }
                
                SystemSoundID soundID = 1102;
                AudioServicesPlaySystemSound(soundID);
                
                
                
                
                
                
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error = %@",error);
            }];
        }
            
            
            break;
        case ReachableViaWWAN:
        {
            NSLog(@"使用流量");
            NSString *str = [NSString stringWithFormat:@"https://open.zhundao.net/api/CheckIn/AddCheckInListByQrcode?accessKey=%@&vCode=%@&checkInId=%li",acckey,stringValue,(long)self.signID];
            
            AFHTTPSessionManager *manager = [AFmanager shareManager];
            [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"respondse = %@",responseObject);
                NSDictionary *dic= [NSDictionary dictionaryWithDictionary:responseObject];
                NSInteger res =[dic[@"Res"]integerValue];
                NSString *Msg = dic[@"Msg"];
                NSDictionary *Data =dic[@"Data"];
                if (res==0&&[Msg isEqualToString:@"签到成功"]) {
                   sign =@"1";
                   
                    SignManager *manager = [SignManager shareManager];
                    [manager createDatabase];
                    if ([manager.dataBase open]) {
                        [manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET Status = '1'  where VCode = '%@' AND signID = %li",stringValue,(long)_signID]];   //更新数据库的vcode
                        [manager.dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET post = '1'  where VCode = '%@' AND signID = %li",stringValue,(long)_signID]];
                    }
                    Alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:[NSString stringWithFormat:@"签到成功 姓名:%@ 电话号码:%@",Data[@"Name"],Data[@"Phone"]]  preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self backAction];
                    }];
                    [Alert addAction:action1];
                    [self presentViewController:Alert animated:YES completion:nil];
                    
                }
                else  if (res==1&&[Msg isEqualToString:@"该用户已经签到!"]) {
                    
                    Alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:@"该用户已经签到"  preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self backAction];
                    }];
                    [Alert addAction:action1];
                    [self presentViewController:Alert animated:YES completion:nil];
                }
                else
                {
                    Alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:@"签到失败 凭证码无效"  preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self backAction];
                    }];
                    [Alert addAction:action1];
                    [self presentViewController:Alert animated:YES completion:nil];
                }
                
                
               
                
                SystemSoundID soundID =1102;
                AudioServicesPlaySystemSound(soundID);
                
                
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error = %@",error);
            }];
        }
            break;
        default:
            break;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
