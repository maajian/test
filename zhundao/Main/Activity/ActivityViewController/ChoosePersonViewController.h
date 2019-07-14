//
//  ChoosePersonViewController.h
//  zhundao
//
//  Created by zhundao on 2017/11/2.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"

@interface ChoosePersonViewController : BaseViewController

@property(nonatomic,strong)NSMutableArray *modelArray;
/*! 活动名称 */
@property(nonatomic,copy)NSString *activityName;

@property(nonatomic, assign) NSInteger activityID;

@end
