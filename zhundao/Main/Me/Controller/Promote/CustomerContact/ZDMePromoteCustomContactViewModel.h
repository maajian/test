//
//  ZDMePromoteCustomContactViewModel.h
//  zhundao
//
//  Created by maj on 2020/1/17.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZDMePromoteCustomContactModel.h"
#import "ZDMePromoteNoticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDMePromoteCustomContactViewModel : NSObject

@property (nonatomic, assign) NSInteger zhundaoBi;
@property (nonatomic, strong) NSMutableArray<ZDMePromoteNoticeModel *> *noticeArray;
@property (nonatomic, strong) NSMutableArray<ZDMePromoteCustomContactModel *> *dataArray;

- (void)getPromoteCustomContactSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;

- (void)getZDBiSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;

- (void)getNoticeSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;

@end

NS_ASSUME_NONNULL_END
