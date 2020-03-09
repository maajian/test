//
//  ZDMePromoteIncomeModel.h
//  zhundao
//
//  Created by maj on 2020/1/8.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDMePromoteIncomeModel : NSObject
@property (nonatomic, assign) NSInteger Amount; // 金额
@property (nonatomic, assign) NSInteger Type; // 类型
@property (nonatomic, copy) NSString *typeStr;
@property (nonatomic, copy) NSString *Remark; // 备注
@property (nonatomic, copy) NSString *AddTime; // 时间

@end

NS_ASSUME_NONNULL_END
