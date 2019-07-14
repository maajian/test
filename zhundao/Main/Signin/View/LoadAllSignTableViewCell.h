//
//  LoadAllSignTableViewCell.h
//  zhundao
//
//  Created by zhundao on 2016/12/20.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadallsignModel.h"
@interface LoadAllSignTableViewCell : UITableViewCell
@property(nonatomic,strong)LoadallsignModel *model;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(nonatomic,assign)NSInteger signid;
@end
