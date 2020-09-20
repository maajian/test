//
//  PGServiceAlertView+PGAdd.h
//  zhundao
//
//  Created by maj on 2020/1/14.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGServiceAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGServiceAlertView (ZDAdd)

+ (instancetype)privacyAlertWithDelegate:(id)delegate;

+ (instancetype)privacyNeedCheckAlertWithDelegate:(id)delegate;

@end

NS_ASSUME_NONNULL_END
