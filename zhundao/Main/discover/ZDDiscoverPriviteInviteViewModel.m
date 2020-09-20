//
//  ZDDiscoverPriviteInviteViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/9/15.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDDiscoverPriviteInviteViewModel.h"

@implementation ZDDiscoverPriviteInviteViewModel

- (NSDictionary *)writeNameFromPlist {
    NSString *namePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"inviteName.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:namePath];
    
    return dic;
}

- (UIImage *)writeImage :(NSString *)name{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-invite.plist",name]];
    NSString *str = [NSArray arrayWithContentsOfFile:path].lastObject;
    NSData *data = [[NSData alloc]initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}



- (void)removePlistWithName:(NSString *)name{
     NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-invite.plist",name]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        [fileManager removeItemAtPath:path error:nil];
    }
     NSString *namePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"inviteName.plist"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:namePath];
    [dic removeObjectForKey:name];
    [dic writeToFile:namePath atomically:YES];
}




- (NSInteger)getCurrentIndex{
    NSInteger index ;
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"selectInvite"]) {
        index = [[NSUserDefaults standardUserDefaults]integerForKey:@"selectInvite"];
        return index;
    }else{
        return 0;
    }
}






- (void)savaCurrentIndex:(NSInteger)index{
    [[NSUserDefaults standardUserDefaults]setInteger:index  forKey:@"selectInvite"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


@end
