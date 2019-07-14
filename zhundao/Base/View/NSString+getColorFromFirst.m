//
//  NSString+getColorFromFirst.m
//  zhundao
//
//  Created by zhundao on 2017/5/24.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "NSString+getColorFromFirst.h"
#import "NSString+ChangeToPinyin.h"

@implementation NSString (getColorFromFirst)
- (UIColor *)getColorWithStr :(NSString *)str
{
    NSArray *array = @[
                       [UIColor colorWithRed:247/255.f green:181/255.f blue:94/255.f alpha:1],
                       [UIColor colorWithRed:95/255.f green:122/255.f blue:167/255.f alpha:1],
                       [UIColor colorWithRed:86/255.f green:138/255.f blue:174/255.f alpha:1],
                       [UIColor colorWithRed:242/255.f green:114/255.f blue:94/255.f alpha:1],
                       [UIColor colorWithRed:78/255.f green:169/255.f blue:235/255.f alpha:1],
                       [UIColor colorWithRed:179/255.f green:137/255.f blue:121/255.f alpha:1],
                       [UIColor colorWithRed:23/255.f green:194/255.f blue:148/255.f alpha:1],  //颜色数组
                       ];
    NSString  *pinyinStr = [[NSString alloc]changeToPinyinWithStr:str];
    UIColor *color = nil;
    
    NSString *lastStr =[pinyinStr substringFromIndex:(pinyinStr.length/2)]; //获取最后一个字母
    int asciiCode = [lastStr characterAtIndex:0]; //将最后字母转换成ASCII码
    if (asciiCode>='a'&&asciiCode<='d') {
        color = array[0];
    }
    else if (asciiCode>='e'&&asciiCode<='h')
    {
        color = array[1];
    }
    else if (asciiCode>='i'&&asciiCode<='l')
    {
        color = array[2];
    }
    else if (asciiCode>='m'&&asciiCode<='p')
    {
        color = array[3];
    }
    else if (asciiCode>='q'&&asciiCode<='t')
    {
        color = array[4];
    }
    else if (asciiCode>='u'&&asciiCode<='w')
    {
        color = array[4];
    }
    else
    {
        color = array[6];
    }
    return color;
}

@end
