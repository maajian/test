//
//  ZDSignInLoadAllSignCell.h
//  zhundao
//
//  Created by zhundao on 2016/12/20.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDSignInLoadallsignModel.h"
@interface ZDSignInLoadAllSignCell : UITableViewCell
@property(nonatomic,strong)ZDSignInLoadallsignModel *model;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(nonatomic,assign)NSInteger signid;
@end
