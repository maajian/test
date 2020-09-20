//
//  ZDMeChooseGroupViewController.h
//  zhundao
//
//  Created by zhundao on 2017/6/6.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"
typedef void(^groupblock) (NSString *groupName,NSInteger groupID);
@interface ZDMeChooseGroupViewController : ZDBaseVC
@property(nonatomic,copy)NSString *nameStr ;
@property(nonatomic,assign)NSInteger personid ;
@property(nonatomic,copy)groupblock block;
@end
