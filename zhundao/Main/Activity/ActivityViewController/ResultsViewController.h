//
//  ResultsViewController.h
//  zhundao
//
//  Created by zhundao on 2017/3/8.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ResultsViewController : BaseViewController<UISearchResultsUpdating>
@property (nonatomic, strong) NSArray *alldata;
@property(nonatomic,assign)NSInteger signID;
@property(nonatomic,assign)NSInteger activityID;
@end
