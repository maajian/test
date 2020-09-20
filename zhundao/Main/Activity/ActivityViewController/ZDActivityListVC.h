//
//  ZDActivityListVC.h
//  zhundao
//
//  Created by zhundao on 2016/12/15.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDBaseVC.h"
@interface ZDActivityListVC : ZDBaseVC
/*! 活动名称 */
@property(nonatomic,copy)NSString *listName;
/*! 活动ID */
@property(nonatomic,assign)NSInteger listID;
/*! 费用数组 */
@property(nonatomic,copy)NSArray *feeArray;
/*! 基础项 */
@property(nonatomic,copy)NSString *userInfo;
/*! 参与人数 */
@property(nonatomic,assign)NSInteger HasJoinNum;
/*! 活动开始时间 */
@property(nonatomic,copy)NSString *timeStart;
/*! 地址 */
@property(nonatomic,copy)NSString *address;
- (void)loadData ;
@end
