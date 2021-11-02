//
//  ZDMeViewModel.h
//  zhundao
//
//  Created by maj on 2020/1/31.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZDMeModel.h"

typedef void (^ZDMeADBlock) (ZDMeADModel * _Nullable model);

NS_ASSUME_NONNULL_BEGIN

@interface ZDMeViewModel : NSObject
// 是否允许显示准到推广合伙人
@property (nonatomic, assign) BOOL allowPromote;
// 是否允许显示准到准到供应商
@property (nonatomic, assign) BOOL allowSupplier;

- (void)getPromoteSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;

// 获取弹窗广告
- (void)networkGetNotifySuccess:(ZDMeADBlock)success failure:(ZDBlock_Error)failure;
// 插入弹窗广告阅读结果
- (void)networForAdsPopRespond:(BOOL)respond AdsPopID:(NSInteger)AdsPopID;

@end

NS_ASSUME_NONNULL_END
