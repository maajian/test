//
//  ZDDataPersonViewModel.h
//  jingjing
//
//  Created by maj on 2020/8/10.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZDDataPersonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDDataPersonViewModel : NSObject
@property (nonatomic, strong) NSMutableArray <ZDDataPersonModel *> *dataSource;
// 所有的
@property (nonatomic, strong) NSMutableArray <NSString *> *allNameSource;
@property (nonatomic, strong) NSMutableArray <ZDDataPersonModel *> *selectNameSource;

- (void)networkForGetDataPersonListActivityId:(NSInteger)activityId success:(ZDBlock_Void)success failure:(ZDBlock_Error)failure;

@end

NS_ASSUME_NONNULL_END
