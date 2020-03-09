//
//  ZDMePromoteNoticeViewModel.h
//  zhundao
//
//  Created by maj on 2020/1/7.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZDMePromoteNoticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDMePromoteNoticeViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<ZDMePromoteNoticeModel *> *dataArray;

- (void)getNoticeSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;

@end

NS_ASSUME_NONNULL_END
