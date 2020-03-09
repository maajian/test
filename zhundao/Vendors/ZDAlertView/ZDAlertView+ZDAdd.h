//
//  ZDAlertView+ZDAdd.h
//  zhundao
//
//  Created by maj on 2020/1/14.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDAlertView (ZDAdd)

+ (instancetype)privacyAlertWithDelegate:(id)delegate firstComeIn:(BOOL)firstComeIn;

+ (instancetype)privacyNeedCheckAlertWithDelegate:(id)delegate;

@end

NS_ASSUME_NONNULL_END
