//
//  NewOrEditMV.h
//  zhundao
//
//  Created by zhundao on 2017/6/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^upBlock) (NSString *str);
@interface NewOrEditMV : NSObject
- (NSMutableAttributedString *)setAttrbriteStrWithText:(NSString *)text;  //为*添加富文本变红色

- (void)setKeyboardTypeWithtextf :(UITextField *)TextField;   //添加键盘类型

- (void)isNoDataTextField:(UITextField *)TextField ;   //检测是否为空字符串

+ (void)changeToNetImage :(UIImage *)image block:(upBlock)block;  // 图片转为网络图片url

- (NSMutableArray *)sexChangeWithArray :(NSArray *)dataArray  muArray :(NSMutableArray *)array; //改变sex 的显示 默认 0 1 2

- (NSString *)sexChangeToStr :(NSString * )str ;//性别改变为数字字符串

- (NSString *)searchContactGroupIDFromID:(NSInteger )ID;  // 查询组ID
@end
