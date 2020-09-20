//
//  PGMeMessageViewModel.h
//  jingjing
//
//  Created by maj on 2020/8/10.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PGMeMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGMeMessageViewModel : NSObject
@property (nonatomic, strong) NSMutableArray<PGMeMessageModel *> *dataSource;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *idArray;

// 获取消息列表
- (void)getMeMessageListWithPage:(NSInteger)page Success:(ZDBlock_Void)success failure:(ZDBlock_Error_Str)failure;
// 更新消息为已读（app端）
- (void)setReadMessageWithID:(NSInteger)Id success:(ZDBlock_Void)success failure:(ZDBlock_Error_Str)failure;

@end

NS_ASSUME_NONNULL_END
