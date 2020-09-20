//
//  PGActivitySignleListVC.h
//  zhundao
//
//  Created by zhundao on 2016/12/15.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGBaseVC.h"
#import "PGActivityListModel.h"
@interface PGActivitySignleListVC : PGBaseVC
@property(nonatomic,strong)NSDictionary *datadic;
@property(nonatomic,assign)NSInteger activityID;
@property(nonatomic,assign)NSInteger personID;
@property(nonatomic,copy)NSString *vcode;
@property(nonatomic,copy)NSString *userInfo ;
@property(nonatomic,assign)BOOL isChange ;
@property (nonatomic, strong) PGActivityListModel *personListModel;
@end
