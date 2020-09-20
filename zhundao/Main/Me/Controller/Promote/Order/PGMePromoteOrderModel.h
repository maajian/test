//
//  PGMePromoteOrderModel.h
//  zhundao
//
//  Created by maj on 2020/1/19.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGMePromoteOrderModel : NSObject
@property (nonatomic, copy) NSString *NickName;
@property (nonatomic, copy) NSString *OutTradeNo;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, assign) CGFloat Total;
@property (nonatomic, copy) NSString *AddTime;

@end

NS_ASSUME_NONNULL_END
