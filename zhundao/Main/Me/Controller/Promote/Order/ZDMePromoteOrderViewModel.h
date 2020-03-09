//
//  ZDMePromoteOrderViewModel.h
//  zhundao
//
//  Created by maj on 2020/1/19.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZDMePromoteOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDMePromoteOrderViewModel : NSObject

@property (nonatomic, strong) NSMutableArray <ZDMePromoteOrderModel *> *dataArray;

- (void)getOrderSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;

@end

NS_ASSUME_NONNULL_END
