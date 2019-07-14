//
//  muliSignViewController.m
//  zhundao
//
//  Created by zhundao on 2017/3/22.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "muliSignViewController.h"
#import "UIImage+mask.h"
#import "muliotherViewController.h"
#import "Time.h"
#define Top_Height 0.2*kScreenHeight
// 中间View的宽度
#define MiddleWidth 0.8*kScreenWidth
static NSString *saoText = @"将二维码/条形码放入框内，即可自动扫描";
@interface muliSignViewController ()
{
    Reachability *r;
        NSInteger flag;
}
@end

@implementation muliSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    [self creatBackGroundView];
    [self creatUI];
    flag=0;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
    [self panduanNetWithStr:stringValue];
}
- (void)panduanNetWithStr:(NSString *)stringValue
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
             NSLog(@"暂无网络");
        {
            [self dontHaveNetWithStr:stringValue];
        }
            break;
        case ReachableViaWiFi:
            NSLog(@"wifi");
        {
            [self netWorkWithstringValue:stringValue];
        }
            break;
        case ReachableViaWWAN:
            NSLog(@"wan");
        {
            [self netWorkWithstringValue:stringValue];
        }
            break;
        default:
            break;
    }
}

- (void)dontHaveNetWithStr :(NSString *)stringValue
{
 
    [[SignManager shareManager] createDatabase];
    if ([[SignManager shareManager].dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM muliSignList WHERE signID = %li",(long)self.signID];
        FMResultSet * rs = [[SignManager shareManager].dataBase executeQuery:sql];
        while ([rs next]) {
            
            if ([[rs stringForColumn:@"VCode"] isEqualToString:stringValue]) {
                [self searchStatusWithStr:stringValue withrs:rs];
                  flag=1;
            }
        }
        if (flag==0) {
            _signStatusBlock(2,rs); // 签到失败 凭证码无效
            [self backAction];
        }
          [[SignManager shareManager].dataBase close];
    }
}
- (void)searchStatusWithStr :(NSString *)stringValue withrs :(FMResultSet *) rs
{
     if ([[rs stringForColumn:@"Status"]integerValue]==0) {
         [self notNetUpdataWithStr:stringValue];
         _signStatusBlock(1,rs);  //1 签到成功
         [self backAction];
         
     }
       else
    {
        _signStatusBlock(0,rs);  //0 已经签到
        [self backAction];
    }
}

- (void)notNetUpdataWithStr :(NSString *)stringValue  //更新数据库元素
{
     NSString *timeStr = [[Time alloc]nextDateWithNumber:0];
     [[SignManager shareManager].dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE muliSignList SET Status = '1'  where VCode = '%@' AND signID = %li",stringValue,(long)self.signID]];
      [[SignManager shareManager].dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE muliSignList SET post = '0'  where VCode = '%@' AND signID = %li",stringValue,(long)self.signID]];
      [[SignManager shareManager].dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE muliSignList SET addTime = '%@'  where VCode = '%@' AND signID = %li",timeStr,stringValue,(long)self.signID]];
}
- (void)netWorkWithstringValue:(NSString *)stringValue {
  NSString *str = [NSString stringWithFormat:@"%@api/CheckIn/AddCheckInListByQrcode?accessKey=%@&vCode=%@&checkInId=%li&checkInWay=6",zhundaoApi,_acckey,stringValue,(long)self.signID];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        [self succseeresponseObject:dic WithStr:stringValue];
        [self backAction];
    } fail:^(NSError *error) {
        
    }];
}
- (void)haveNetUpdataWithStr :(NSString *)stringValue  //更新数据库元素
{
    [[SignManager shareManager] createDatabase];
    NSString *timeStr = [[Time alloc]nextDateWithNumber:0];
    if ([[SignManager shareManager].dataBase open]) {
    [[SignManager shareManager].dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE muliSignList SET Status = '1'  where VCode = '%@' AND signID = %li",stringValue,(long)self.signID]];
    [[SignManager shareManager].dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE muliSignList SET post = '1'  where VCode = '%@' AND signID = %li",stringValue,(long)self.signID]];
        [[SignManager shareManager].dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE muliSignList SET addTime = '%@'  where VCode = '%@' AND signID = %li",timeStr,stringValue,(long)self.signID]];
        [[SignManager shareManager].dataBase close];
    }
}
- (void)succseeresponseObject:(NSDictionary *)dic WithStr :(NSString *)stringValue
{
    NSInteger res =[dic[@"Res"]integerValue];
    NSString *Url = dic[@"Url"];
    if (res==0&&[Url isEqualToString:@"100"]) {  //签到成功  1 签到成功
        [self haveNetUpdataWithStr:stringValue];
        NSMutableDictionary *dic1 = [dic[@"Data"] mutableCopy];
        [dic1 setObject:stringValue forKey:@"VCode"];
        self.haveNetBlock(1,[dic1 copy]);
    }
    else  if (res==0&&[Url isEqualToString:@"101"]) {//已经签到  0 已经签到
        NSMutableDictionary *dic1 = [dic[@"Data"] mutableCopy];
        [dic1 setObject:stringValue forKey:@"VCode"];
        self.haveNetBlock(0,[dic1 copy]);
    } else   //签到失败 凭证码无效  2
    {
        self.haveNetBlock(2,dic);
    }
}
-(void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
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
    [self otherView];
}
- (void)viewtap:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag==102) {
        
        muliotherViewController *other = [[muliotherViewController alloc]init];
        other.signid = self.signID;
        other.acckey = _acckey;
        [self presentViewController:other animated:YES completion:^{
            [other.textf becomeFirstResponder];
        }];
       other.haveNetBlock = ^(NSInteger status,NSDictionary *dic)
        {
            _haveNetBlock(status,dic);
        };
        other.signStatusBlock = ^(NSInteger status,FMResultSet *rs)
        {
            _signStatusBlock(status,rs);
            
        };
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
