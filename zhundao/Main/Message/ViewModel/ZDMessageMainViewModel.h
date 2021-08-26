//
//  ZDMeMessageViewModel.h
//  zhundao
//
//  Created by maj on 2020/12/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZDMessageMainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDMessageMainViewModel : NSObject
@property (nonatomic, strong) NSMutableArray<ZDMessageMainModel *> *dataSource;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *idArray;

@property (nonatomic, assign) bool isEmpty;
@property (nonatomic, assign) bool isError;

- (void)getMeMessageListWithPage:(NSInteger)page Success:(ZDBlock_Void)success failure:(ZDBlock_Error_Str)failure;
- (void)setReadMessageWithID:(NSInteger)Id success:(ZDBlock_Void)success failure:(ZDBlock_Error_Str)failure;
// 清除所有未读
- (void)clearAllReadMessageSuccess:(ZDBlock_Void)success failure:(ZDBlock_Error_Str)failure;
// 删除消息
- (void)deleteMessageMessageWithID:(NSInteger)Id success:(ZDBlock_Void)success failure:(ZDBlock_Error_Str)failure;

@end

NS_ASSUME_NONNULL_END
