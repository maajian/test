//
//  PGMePromoteNoticeViewModel.h
//  zhundao
//
//  Created by maj on 2020/1/7.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PGMePromoteNoticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGMePromoteNoticeViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<PGMePromoteNoticeModel *> *dataArray;

- (void)getNoticeSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;

@end

NS_ASSUME_NONNULL_END
