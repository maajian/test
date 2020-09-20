#import "PGUserDomainMask.h"
//
//  PGDiscoverMuliotherVC.m
//  zhundao
//
//  Created by zhundao on 2017/4/7.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGDiscoverMuliotherVC.h"
#import "Time.h"
@interface PGDiscoverMuliotherVC ()
{
    Reachability *r;
    MBProgressHUD *hud;
    NSInteger flag;
}
@property(nonatomic,strong)NSString *textFieldStr;
@end

@implementation PGDiscoverMuliotherVC

- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle viewCellIdentifierN5 = UITableViewStylePlain; 
        UIActivityIndicatorView *userInfoWithm8= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; 
    userInfoWithm8.hidden = YES; 
    userInfoWithm8.hidesWhenStopped = YES; 
    PGUserDomainMask *oscillatoryAnimationWith= [[PGUserDomainMask alloc] init];
[oscillatoryAnimationWith pg_resourceWithTypeWithloginWithPerson:viewCellIdentifierN5 alipaySuccNotification:userInfoWithm8 ];
});
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)sure
{
    _textFieldStr = [self.textf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    if ([r currentReachabilityStatus] ==NotReachable) {
        [self NotReachable];
    }
    else
    {
        hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
        [self haveNet];
    }
}
- (void)NotReachable
{
    [[PGSignManager shareManager] createDatabase];
    if ([[PGSignManager shareManager].dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM muliSignList WHERE signID = %li",(long)self.signid];
         FMResultSet * rs = [[PGSignManager shareManager].dataBase executeQuery:sql];
        while ([rs next]) {
            
            if ([[rs stringForColumn:@"phone"] isEqualToString:_textFieldStr]) {
                [self searchStatusWithStr:_textFieldStr withrs:rs];
                flag=1;
            }
        }
        if (flag!=1) {
            _signStatusBlock(2,rs); // 签到失败 凭证码无效
            [self backroot];
        }
         [[PGSignManager shareManager].dataBase close];
    }
}
- (void)searchStatusWithStr :(NSString *)stringValue withrs :(FMResultSet *)rs
{
    if ([[rs stringForColumn:@"Status"]integerValue]==0) {
        [self notNetUpdataWithStr];
        _signStatusBlock(1,rs);  //1 签到成功
        [self backroot];
        
    }
    else
    {
        _signStatusBlock(0,rs);  //0 已经签到
        [self backroot];
    }
}
- (void)notNetUpdataWithStr  //更新数据库元素
{
     NSString *timeStr = [[Time alloc]nextDateWithNumber:0];
    [[PGSignManager shareManager].dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE muliSignList SET Status = '1'  where phone = '%@' AND signID = %li",self.textFieldStr,(long)self.signid]];
    [[PGSignManager shareManager].dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE muliSignList SET post = '0'  where phone = '%@' AND signID = %li",_textFieldStr,(long)self.signid]];
    [[PGSignManager shareManager].dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE muliSignList SET addTime = '%@'  where phone = '%@' AND signID = %li",timeStr,_textFieldStr,(long)self.signid]];
}
 -(void)haveNet
{
    NSString *urlstr = [NSString stringWithFormat:@"%@api/CheckIn/AddCheckInListByPhone?accessKey=%@&phone=%@&checkInId=%li&checkInWay=11",zhundaoApi,_acckey,self.textFieldStr,(long)self.signid];
    [ZD_NetWorkM getDataWithMethod:urlstr parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        [self succseeresponseObject:dic];
        [self backroot];
    } fail:^(NSError *error) {
        
    }];
}
- (void)succseeresponseObject:(NSDictionary *)dic
{
    NSInteger res =[dic[@"Res"]integerValue];
    NSString *Url = dic[@"Url"];
    if (res==0&&[Url isEqualToString:@"100"]) {  //签到成功  1 签到成功
         [self haveNetUpdataWithStr];
        NSMutableDictionary *dic1 = [dic[@"Data"] mutableCopy];
        [dic1 setObject:[self searchVcode] forKey:@"VCode"];
        self.haveNetBlock(1,[dic1 copy]);
    }
    else  if (res==1&&[Url isEqualToString:@"101"]) {//已经签到  0 已经签到
        NSMutableDictionary *dic1 = [dic[@"Data"] mutableCopy];
        [dic1 setObject:[self searchVcode] forKey:@"VCode"];
        self.haveNetBlock(0,[dic1 copy]);
    } else   //签到失败 凭证码无效  2
    {
        self.haveNetBlock(2,dic);
    }
}

- (NSString *)searchVcode
{
    NSString *str = nil;
    [[PGSignManager shareManager] createDatabase];
    if ([[PGSignManager shareManager].dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM muliSignList WHERE signID = %li",(long)self.signid];
        FMResultSet * rs = [[PGSignManager shareManager].dataBase executeQuery:sql];
        while ([rs next]) {
            if ([[rs stringForColumn:@"phone"] isEqualToString:_textFieldStr])
            {
                str =[rs stringForColumn:@"VCode"];
            }
        }
        [[PGSignManager shareManager].dataBase close];
    }
    return str;
}
- (void)haveNetUpdataWithStr //更新数据库元素
{
    [[PGSignManager shareManager] createDatabase];
    if ([[PGSignManager shareManager].dataBase open]) {
        [self notNetUpdataWithStr];
        [[PGSignManager shareManager].dataBase close];
    }
}
#pragma mark 返回
- (void)backroot
{
    UIViewController *rootVC = self.presentingViewController;
    
    while (rootVC.presentingViewController) {
        rootVC = rootVC.presentingViewController;
    }
    [rootVC dismissViewControllerAnimated:YES completion:nil];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle trainTableViewA7 = UITableViewStylePlain; 
        UIActivityIndicatorView *javaScriptAlertf5= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; 
    javaScriptAlertf5.hidden = YES; 
    javaScriptAlertf5.hidesWhenStopped = YES; 
    PGUserDomainMask *albumCloudShared= [[PGUserDomainMask alloc] init];
[albumCloudShared pg_resourceWithTypeWithloginWithPerson:trainTableViewA7 alipaySuccNotification:javaScriptAlertf5 ];
});
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
