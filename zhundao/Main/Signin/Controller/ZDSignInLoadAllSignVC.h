//
//  ZDSignInLoadAllSignVC.h
//  zhundao
//
//  Created by zhundao on 2016/12/20.
//  Copyright © 2016年 zhundao. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ZDBaseVC.h"
typedef void(^block)(NSInteger signNum);

typedef void(^signBlock)(BOOL isRed);
@interface ZDSignInLoadAllSignVC : ZDBaseVC
@property(nonatomic,copy)block block;
/*! 签到ID */
@property(nonatomic,assign)NSInteger signID;
@property(nonatomic,copy)signBlock signBlock;
/*! 签到名称 */
@property(nonatomic,copy)NSString *signName;
/*! 实际所有签到人数 */
@property(nonatomic,assign)NSInteger signNumber;
/*! 活动ID */
@property(nonatomic,assign)NSInteger activityID;
- (void)loadData;
@end
