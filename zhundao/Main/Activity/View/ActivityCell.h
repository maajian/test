//
//  ActivityCell.h
//  zhundao
//
//  Created by zhundao on 2016/12/6.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
@interface ActivityCell : UITableViewCell<NSCoding>
@property(nonatomic,strong)ActivityModel *model;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@property (weak, nonatomic) IBOutlet UIButton *listButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;



//@property(nonatomic,strong,readonly)UIButton *editButton;
//@property(nonatomic,strong,readonly)UIButton *listButton;
//@property(nonatomic,strong,readonly)UIButton *shareButton;
//@property(nonatomic,strong,readonly)UIButton *moreButton;
@end
