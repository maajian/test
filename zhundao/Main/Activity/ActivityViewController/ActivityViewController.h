//
//  ActivityViewController.h
//  zhundao
//
//  Created by zhundao on 2016/12/2.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"
@interface ActivityViewController : ZDBaseVC
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)UIButton *button;
- (void)loadData;
@end
