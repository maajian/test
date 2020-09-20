//
//  PGActivityNewPersonViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/7/10.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^addBlock) (NSInteger isSuccess);
typedef void(^feeBlock) (NSInteger feeid);
@interface PGActivityNewPersonViewModel : NSObject
@property(nonatomic,copy)addBlock blcok;
//发送网络请求
- (void)addPersonNetWork :(NSDictionary *)dic feeid :(NSInteger)feeid;


//通过 userinfo 的ID 获取名称
- (NSMutableArray *)getBaseName :(NSString *)str;


//通知左边count 获取右边的数组
- (NSMutableArray *)getRightArray :(NSArray *)baseArray allOptionArray:(NSArray *)allOptionArray;

//获取fee选择项
- (NSMutableArray *)getFeeArray :(NSArray *)feeArray;

//获取右边基础必填项
- (NSMutableArray *)getBaseRightArray :(NSArray *)allRight count :(NSInteger )count;

//获取费用id
- (void)getFeeidFromArray :(NSArray *)feeArray selectStr :(NSString *)str feeidBlock : (feeBlock) feeBlock ;
@end
