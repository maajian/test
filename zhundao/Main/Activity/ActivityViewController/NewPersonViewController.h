//
//  NewPersonViewController.h
//  zhundao
//
//  Created by zhundao on 2017/7/10.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^fleshBlock) (BOOL isSuccess);
@interface NewPersonViewController : BaseViewController
@property(nonatomic,copy)fleshBlock fleshBlock;
@property(nonatomic,assign)NSInteger activityID;   //活动ID

@property(nonatomic,copy)NSArray *feeArray;

@property(nonatomic,copy)NSString *userInfo;
@end
