
//
//  SignInViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/7/28.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "SignInViewModel.h"
@implementation SignInViewModel
//本地如果保存的不是model 移除本地数据
- (void)removeObject{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"signdata"]||[[NSUserDefaults standardUserDefaults]objectForKey:@"signdata1"]) {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"signdata"] isKindOfClass:[NSArray class]]) {
            NSArray *array =[[[NSUserDefaults standardUserDefaults]objectForKey:@"signdata"]copy];
            NSArray *array1 = [[[NSUserDefaults standardUserDefaults]objectForKey:@"signdata1"]copy];
            if (array.count>0) {
                if ([array.firstObject isKindOfClass:[NSDictionary class]]) {
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"signdata"];
                }
            }
            if(array.count==0){
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"signdata"];
            }
            if (array1.count>0) {
                if ([array.firstObject isKindOfClass:[NSDictionary class]]) {
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"signdata1"];
                }
            }
            if(array1.count==0){
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"signdata1"];
            }
        }
    }
}





@end
