//
//  LoadAllSignViewController.h
//  zhundao
//
//  Created by zhundao on 2016/12/20.
//  Copyright © 2016年 zhundao. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ZDSignInModel.h"
typedef void(^block)(NSInteger signNum);

typedef void(^signBlock)(BOOL isRed);
@interface LoadAllSignViewController : BaseViewController
@property(nonatomic,copy)block block;
@property (nonatomic, strong) ZDSignInModel *signInModel;
@property(nonatomic,copy)signBlock signBlock;

- (void)loadData;
@end
