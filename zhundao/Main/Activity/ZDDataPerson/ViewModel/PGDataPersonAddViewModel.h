//
//  PGDataPersonAddViewModel.h
//  jingjing
//
//  Created by maj on 2020/8/10.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PGDataPersonAddModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGDataPersonAddViewModel : NSObject

@property (nonatomic, strong) NSMutableArray <PGDataPersonAddModel *> *dataSource;
// 添加数据员
- (void)addDataPersonWithActivityId:(NSInteger)activityId userName:(NSString *)userName phone:(NSString *)phone success:(ZDBlock_Void)success failure:(ZDBlock_Error)failure;

@end

NS_ASSUME_NONNULL_END
