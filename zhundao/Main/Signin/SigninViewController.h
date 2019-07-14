//
//  SigninViewController.h
//  zhundao
//
//  Created by zhundao on 2016/12/2.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface SigninViewController : BaseViewController
{

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)UIButton *button;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;
@property(nonatomic,strong)NSString *signUrlStr;
@end
