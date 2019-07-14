//
//  ActivityViewController.h
//  zhundao
//
//  Created by zhundao on 2016/12/2.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "BaseViewController.h"
@interface ActivityViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)UIButton *button;
- (void)loadData;
@end
