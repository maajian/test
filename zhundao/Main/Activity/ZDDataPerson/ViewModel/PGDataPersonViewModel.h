//
//  PGDataPersonViewModel.h
//  jingjing
//
//  Created by maj on 2020/8/10.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PGDataPersonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGDataPersonViewModel : NSObject
@property (nonatomic, strong) NSMutableArray <PGDataPersonModel *> *dataSource;
// 所有的
@property (nonatomic, strong) NSMutableArray <NSString *> *allNameSource;
@property (nonatomic, strong) NSMutableArray <PGDataPersonModel *> *selectNameSource;

- (void)networkForGetDataPersonListActivityId:(NSInteger)activityId success:(ZDBlock_Void)success failure:(ZDBlock_Error)failure;

@end

NS_ASSUME_NONNULL_END
