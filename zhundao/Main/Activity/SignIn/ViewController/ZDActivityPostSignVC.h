//
//  ZDActivityPostSignVC.h
//  zhundao
//
//  Created by maj on 2021/5/12.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "BaseViewController.h"

#import "ZDSignInModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDActivityPostSignVC : BaseViewController
@property (nonatomic, strong) ZDSignInModel *signModel;
@property (nonatomic, strong) ActivityModel *activityModel;

@end

NS_ASSUME_NONNULL_END
