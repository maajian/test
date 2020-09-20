//
//  PGActivityListCell.h
//  zhundao
//
//  Created by zhundao on 2016/12/15.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGActivityListModel.h"
@interface PGActivityListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *listCount;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;
@property(nonatomic,strong)PGActivityListModel *model;
@end
