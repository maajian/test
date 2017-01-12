
//
//  SignManager.m
//  zhundao
//
//  Created by zhundao on 2016/12/20.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "SignManager.h"
@interface SignManager ()
{
    
}
@end
@implementation SignManager
+(SignManager *)shareManager
{
    static SignManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(manager==nil)
        {
            manager = [[super allocWithZone:nil]init];
    }
    });
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self shareManager];
    
}
- (id)copy
{
    return self;
}

- (NSString *)getaccseekey
{
    NSString *acc =[[NSUserDefaults standardUserDefaults]objectForKey:AccessKey];
    NSString *uid = [[NSUserDefaults standardUserDefaults]objectForKey:WX_UNION_ID];
    if (acc) {
        _accesskey = [acc copy];
    }
    if (uid) {
        _accesskey = [uid copy];
    }
    return _accesskey;
}
- (void)createDatabase
{
    NSString *path =NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)[0];
    path = [path stringByAppendingString:@"list.sqlite"];
    NSLog(@"path = %@",path);
    _dataBase = [FMDatabase databaseWithPath:path];
    BOOL open = [_dataBase open];
    if (open) {
        NSLog(@"数据库打开成功");
    }
    else
    {
        NSLog(@"数据库打开失败");
    }
  

    
    }


@end
