//
//  ZDMePromoteUserNumberViewModel.h
//  zhundao
//
//  Created by maj on 2020/1/19.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZDMePromoteUserNumberModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDMePromoteUserNumberViewModel : NSObject
// 数组
@property (nonatomic, strong) NSMutableArray <ZDMePromoteUserNumberModel *> *dataArray;

- (void)getUserNumberSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;

@end

NS_ASSUME_NONNULL_END
