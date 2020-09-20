//
//  ZDDiscoverMuliSignVC.h
//  zhundao
//
//  Created by zhundao on 2017/3/22.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDSaoYiSaoViewController.h"
typedef void(^signStatusBlock) (NSInteger signStatus,FMResultSet * rs);
typedef void(^haveNetBlock) (NSInteger signStatus,NSDictionary  *dic);
@interface ZDDiscoverMuliSignVC : ZDSaoYiSaoViewController
@property(nonatomic,copy)signStatusBlock signStatusBlock;
@property(nonatomic,copy)haveNetBlock haveNetBlock;

// 用户密钥
@property (nonatomic, copy) NSString *acckey;

@end
