//
//  ZDActivitySignVM.h
//  zhundao
//
//  Created by maj on 2021/5/12.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZDSignInModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDActivitySignVM : NSObject

@property (nonatomic, strong) NSMutableArray<ZDSignInModel *> *dataSource;

- (void)getSignListWithPage:(NSInteger)page activityID:(NSInteger)activityID success:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;

@end

NS_ASSUME_NONNULL_END
