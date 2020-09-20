//
//  PGMePromoteOrderViewModel.h
//  zhundao
//
//  Created by maj on 2020/1/19.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PGMePromoteOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGMePromoteOrderViewModel : NSObject

@property (nonatomic, strong) NSMutableArray <PGMePromoteOrderModel *> *dataArray;

- (void)getOrderSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;

@end

NS_ASSUME_NONNULL_END
