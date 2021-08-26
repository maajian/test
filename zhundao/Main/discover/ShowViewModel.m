//
//  ShowViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/9/28.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ShowViewModel.h"

@implementation ShowViewModel

- (void)saveData :(NSMutableDictionary *)dic textView :(UITextView *)textView{
    [dic setObject:@(textView.tag) forKey:@"tag"];
    const CGFloat *color = CGColorGetComponents(textView.textColor.CGColor);
    [dic setObject:textView.text forKey:@"text"];
    [dic setObject:NSStringFromCGRect(textView.frame) forKey:@"rect"];
    [dic setObject:@(textView.font.pointSize) forKey:@"fontsize"];
    [dic setObject:@(color[0]) forKey:@"R"];
    [dic setObject:@(color[1]) forKey:@"G"];
    [dic setObject:@(color[2]) forKey:@"B"];
   
}

- (void)saveImageData :(NSMutableDictionary *)dic imageView :(UIImageView *)imageView{
    [dic setObject:@(imageView.tag) forKey:@"tag"];
    [dic setObject:NSStringFromCGRect(imageView.frame) forKey:@"rect"];
}

- (void)savaToPlist :(NSArray *)fixArray customArray :(NSArray *)customArray str:imageStr
               name :(NSString *)name
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-invite.plist",name]];
    NSString *namePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"inviteName.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        [fileManager removeItemAtPath:path error:nil];
    }
     NSString *path1 = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-invite.plist",name]];
    NSMutableArray *array = [NSMutableArray array];
    
    /*! 保存本地 */
    if (fixArray) [array addObject:fixArray];
    else [array addObject:@[]];
        
    if (customArray) [array addObject:customArray];
    else [array addObject:@[]];
    
    [array addObject:imageStr];
    [array writeToFile:path1 atomically:YES];
    
    /*! 名称保存本地 */
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:namePath];
    if (dic==nil)  dic = [NSMutableDictionary dictionary];
    [dic setObject:name forKey:name];
    [dic writeToFile:namePath atomically:YES];
    
}

- (NSArray *)writeFixArray:(NSString *)name{
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-invite.plist",name]];
    NSArray *array = [NSArray arrayWithContentsOfFile:path].firstObject;
    DDLogVerbose(@"Fixarray = %@",array);
    return array;
    
}

- (NSArray *)writeCustomArray :(NSString *)name{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-invite.plist",name]];
    NSArray *array = [[NSArray arrayWithContentsOfFile:path] objectAtIndex:1];
    DDLogVerbose(@"CustomArray = %@",array);
    return array;
}





- (void)setTextViewFrame :(UITextView *)textView{
    CGSize size = [textView.text boundingRectWithSize:CGSizeMake(kScreenWidth-40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : textView.font} context:nil].size;
    if (CGRectGetMinX(textView.frame)==0) {
        textView.frame = CGRectMake(CGRectGetMinX(textView.frame), CGRectGetMinY(textView.frame), size.width+20, size.height+20);
    }else if (CGRectGetMaxX(textView.frame)==0){
        textView.frame = CGRectMake(kScreenWidth -(size.width+20) , CGRectGetMinY(textView.frame), size.width+20, size.height+20);
    }
    else if (textView.center.x == kScreenWidth/2){
        textView.center = CGPointMake(textView.center.x, textView.center.y);
        textView.bounds = CGRectMake(0, 0, size.width+20, size.height+20);
    }else{
        textView.frame = CGRectMake(CGRectGetMinX(textView.frame), CGRectGetMinY(textView.frame), size.width+20, size.height+20);
    }
}



@end
