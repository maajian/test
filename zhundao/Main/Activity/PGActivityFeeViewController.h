//
//  PGActivityFeeViewController.h
//  zhundao
//
//  Created by zhundao on 2017/4/13.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGBaseVC.h"
typedef void(^backBlock1) (NSArray *array);
@interface PGActivityFeeViewController : PGBaseVC
@property(nonatomic,copy)backBlock1 block;
@property(nonatomic,copy)NSArray *feeArray ;
@end
