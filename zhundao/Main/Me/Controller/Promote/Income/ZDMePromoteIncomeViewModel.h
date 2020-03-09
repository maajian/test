//
//  ZDMePromoteIncomeViewModel.h
//  zhundao
//
//  Created by maj on 2020/1/19.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZDMePromoteIncomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDMePromoteIncomeViewModel : NSObject

@property (nonatomic, strong) NSMutableArray <ZDMePromoteIncomeModel *> *dataArray;

- (void)getIncomeSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;

@end

NS_ASSUME_NONNULL_END
