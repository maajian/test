//
//  ZDActivityPrintVcodeVM.m
//  zhundao
//
//  Created by zhundao on 2017/7/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDActivityPrintVcodeVM.h"
@implementation ZDActivityPrintVcodeVM
- (NSMutableArray *)getID :(NSArray * )nowArray model:(ZDActivityListModel*)model
{
    NSMutableArray *lastArray = [NSMutableArray array];
    @autoreleasepool {
        for (NSString *numberStr in nowArray) {
            if ([numberStr isEqualToString:@"姓名"]) {
                if (model.UserName) [lastArray addObject:model.UserName];
                else [lastArray addObject:@""];
               
            }
           else if ([numberStr isEqualToString:@"手机"]) {
                if (model.Mobile) [lastArray addObject:model.Mobile];
                else [lastArray addObject:@""];
               
            }
           else if ([numberStr isEqualToString:@"性别"]) {
                if ([model.Sex integerValue]==1) [lastArray addObject:@"男"];
                else if ([model.Sex integerValue]==2)  [lastArray addObject:@"女"];
                else [lastArray addObject:@""];
               
            }
          else  if ([numberStr isEqualToString:@"单位"]) {
                if (model.Company) [lastArray addObject:model.Company];
                else [lastArray addObject:@""];
                
            }
          else  if ([numberStr isEqualToString:@"部门"]) {
                if (model.Depart) [lastArray addObject:model.Depart];
                else [lastArray addObject:@""];
                
            }
           else if ([numberStr isEqualToString:@"职务"]) {
                if (model.Duty) [lastArray addObject:model.Duty];
                else [lastArray addObject:@""];
                
            }
           else if ([numberStr isEqualToString:@"身份证"]) {
                if (model.IDcard) [lastArray addObject:model.IDcard];
                else [lastArray addObject:@""];
               
            }
          else  if ([numberStr isEqualToString:@"行业"]) {
                if (model.Industry) [lastArray addObject:model.Industry];
                else [lastArray addObject:@""];
                
            }
          else  if ([numberStr isEqualToString:@"邮箱"]) {
                if (model.Email) [lastArray addObject:model.Email];
                else [lastArray addObject:@""];
               
            }
          else  if ([numberStr isEqualToString:@"地址"]) {
                if (model.Address) [lastArray addObject:model.Address];
                else [lastArray addObject:@""];
                
            }
           else{
                if (model.AdminRemark) [lastArray addObject:model.AdminRemark];
                else [lastArray addObject:@""];
                
            }
            
        }
    }
    return lastArray;
}


- (NSArray *)getNameArray
{
    NSArray *array = nil;
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"printArray"]) {
        array = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printArray"] copy];
        return array;
    }else{
        return @[@""];
    }
}
@end
