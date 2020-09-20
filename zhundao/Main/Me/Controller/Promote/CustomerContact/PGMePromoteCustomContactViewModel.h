//
//  PGMePromoteCustomContactViewModel.h
//  zhundao
//
//  Created by maj on 2020/1/17.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PGMePromoteCustomContactModel.h"
#import "PGMePromoteNoticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGMePromoteCustomContactViewModel : NSObject

@property (nonatomic, assign) NSInteger zhundaoBi;
@property (nonatomic, strong) NSMutableArray<PGMePromoteNoticeModel *> *noticeArray;
@property (nonatomic, strong) NSMutableArray<PGMePromoteCustomContactModel *> *dataArray;

- (void)getPromoteCustomContactSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;

- (void)getZDBiSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;

- (void)getNoticeSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;

@end

NS_ASSUME_NONNULL_END
