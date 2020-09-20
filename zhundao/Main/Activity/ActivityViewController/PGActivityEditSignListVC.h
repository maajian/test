//
//  PGActivityEditSignListVC.h
//  zhundao
//
//  Created by zhundao on 2017/6/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGBaseVC.h"

@interface PGActivityEditSignListVC : PGBaseVC
@property(nonatomic,assign)NSInteger activityID;   //活动ID
@property(nonatomic,assign)NSInteger personID;
@property(nonatomic,copy)NSString *dataStr;  //人员名单信息
@property(nonatomic,strong)NSArray *baseArray;  //基础必填项
@property(nonatomic,strong)NSArray *baseNameArray; //左边的基础信息 姓名 手机等名称
@end
