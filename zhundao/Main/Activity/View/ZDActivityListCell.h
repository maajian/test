//
//  ZDActivityListCell.h
//  zhundao
//
//  Created by zhundao on 2016/12/15.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDActivityListModel.h"
@interface ZDActivityListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *listCount;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;
@property(nonatomic,strong)ZDActivityListModel *model;
@end
