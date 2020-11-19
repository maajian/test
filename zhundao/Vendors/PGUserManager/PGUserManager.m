#import "PGUserManager.h"
#import "PGLoginMainVC.h"
@implementation PGUserManager
+ (instancetype)shareManager {
    static PGUserManager *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[PGUserManager alloc] init];
    });
    return user;
}
- (void)initWithDic:(NSDictionary *)dic {
    self.userID = ZD_SafeIntValue(dic[@"id"]);
    self.balance = dic[@"balance"] ? [dic[@"balance"] floatValue] : 0;
    self.factorageRate = dic[@"factorageRate"] ? [dic[@"factorageRate"] floatValue] : 0;
    self.gradeId = dic[@"gradeId"] ? [dic[@"gradeId"] integerValue]: 1;
    self.hasPayPassWord = dic[@"hasPayPassWord"] ? [dic[@"hasPayPassWord"] boolValue] : NO;
    self.userSex = ZD_SafeIntValue(dic[@"sex"]);
    self.address = ZD_SafeStringValue(dic[@"address"]);
    self.company = ZD_SafeStringValue(dic[@"company"]);
    self.duty = ZD_SafeStringValue(dic[@"duty"]);
    self.email = ZD_SafeStringValue(dic[@"email"]);
    self.headImgUrl = ZD_SafeStringValue(dic[@"headImgUrl"]);
    self.idCard = ZD_SafeStringValue(dic[@"idCard"]);
    self.industry = ZD_SafeStringValue(dic[@"industry"]);
    self.nickName = ZD_SafeStringValue(dic[@"nickName"]);
    self.openid = ZD_SafeStringValue(dic[@"openid"]);
    self.phone = ZD_SafeStringValue(dic[@"phone"]);
    self.trueName = ZD_SafeStringValue(dic[@"trueName"]);
}
#pragma mark --- getter, setter
- (BOOL)hasShowPrivacy {
    return [[NSUserDefaults standardUserDefaults] boolForKey:ZDUserDefault_HasShowPrivacy];
}
- (void)setHasShowPrivacy:(BOOL)hasShowPrivacy {
    [[NSUserDefaults standardUserDefaults] setBool:hasShowPrivacy forKey:ZDUserDefault_HasShowPrivacy];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)loginExpired {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:ZDUserDefault_LoginTime]) {
        NSString *dayStr = [[NSUserDefaults standardUserDefaults] objectForKey:ZDUserDefault_LoginTime];
        NSInteger day = [NSDate getDifferenceByDate:dayStr];
        return day >=7;
    } else {
        [self saveLoginTime];
        return false;
    }
}
- (void)saveLoginTime {
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate getCurrentDayStr] forKey:ZDUserDefault_LoginTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setIsAdmin:(BOOL)isAdmin {
    [[NSUserDefaults standardUserDefaults] setBool:isAdmin forKey:ZDUserDefault_IsAdmin];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)isAdmin {
    return [[NSUserDefaults standardUserDefaults] boolForKey:ZDUserDefault_IsAdmin];
}
- (NSString *)token {
    return [[PGSignManager shareManager] getToken];
}
- (NSString *)loginAccount {
    return ZD_SafeStringValue([ZD_UserDefaults objectForKey:ZDUserDefault_LoginAccount]);
}
- (void)setLoginAccount:(NSString *)loginAccount {
    [ZD_UserDefaults setObject:loginAccount forKey:ZDUserDefault_LoginAccount];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark --- 签到判断
- (BOOL)hasLocalSign:(NSInteger)signID {
    return [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@%li", ZDUserDefault_Sign_Mark, signID]];
}
- (void)markLocalSign:(NSInteger)signID {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@%li", ZDUserDefault_Sign_Mark, signID]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)removeLocalSign:(NSInteger)signID {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:[NSString stringWithFormat:@"%@%li", ZDUserDefault_Sign_Mark, signID]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark --- 本地数据
- (void)didLogout
{
    
    if ([[PGSignManager shareManager].dataBase open])
    {
        NSString *updateSql = [NSString stringWithFormat:@"DROP TABLE signList"];
        [[PGSignManager shareManager].dataBase executeUpdate:updateSql];
        NSString *updateSql1 = [NSString stringWithFormat:@"DROP TABLE muliSignList"];
        [[PGSignManager shareManager].dataBase executeUpdate:updateSql1];
        NSString *updateSql12 = [NSString stringWithFormat:@"DROP TABLE contact"];
        [[PGSignManager shareManager].dataBase executeUpdate:updateSql12];
        [[PGSignManager shareManager].dataBase close];
    }
    PGLoginMainVC *login = [[PGLoginMainVC alloc]init];
    [UIApplication sharedApplication].delegate.window.rootViewController = [[PGBaseNavVC alloc] initWithRootViewController:login];
}
@end
