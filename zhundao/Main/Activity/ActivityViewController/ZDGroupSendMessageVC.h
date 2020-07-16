//
//  ZDGroupSendMessageVC.h
//  zhundao
//
//  Created by zhundao on 2017/11/2.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"

@interface ZDGroupSendMessageVC : ZDBaseVC
/*! 全部数据 */
@property(nonatomic,strong)NSArray *modelArray;
/*! 选中的位置 */
@property(nonatomic,strong)NSArray *selectArray;
/*! 活动名称 */
@property(nonatomic,copy)NSString *activityName;
// 活动ID
@property (nonatomic, assign) NSInteger activityID;



@end
