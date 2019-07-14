//
//  ContactTableViewCell.h
//  zhundao
//
//  Created by zhundao on 2017/5/23.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactModel.h"
@interface ContactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(nonatomic,strong)ContactModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;


@end
