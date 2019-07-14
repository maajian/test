//
//  FaceDetailViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/7/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^activityBlock) (NSArray *titleArray,NSArray *IDArray);
typedef void(^signBlock) (NSArray *array);
typedef void(^bindBlock) (BOOL isSuccess);
typedef void(^progressBlock)(NSInteger index,NSInteger total);
typedef void(^addNewBlock)(NSDictionary *result);
@interface FaceDetailViewModel : NSObject

//获取活动列表
- (void)activityListDataWithBlock:(activityBlock)activityBlock ;

//获取签到列表
- (void)signListDataWithdic :(NSDictionary *)dic   Block:(signBlock)signBlock;

//绑定签到  http://face.zhundao.net/api/Core/BindDevice?accessKey=oX9XjjizWbtuCeHkJRKDwJDvPFEQ&deviceKey={deviceKey}&checkInId={checkInId}
- (void)BindDeviceWithID :(NSString *)checkInId deviceKey:(NSString *)deviceKey  bindBlock:(bindBlock)bindBlock;

- (void)addNewWithDeviceKey:(NSString *)deviceKey addNewBlock:(addNewBlock)addNewBlock;

//获取进度
- (void)getProgressWithDeviceKey:(NSString *)deviceKey  progressBlock:(progressBlock)progressBlock ;
@end
