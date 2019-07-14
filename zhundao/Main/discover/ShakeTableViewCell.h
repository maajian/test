//
//  ShakeTableViewCell.h
//  zhundao
//
//  Created by zhundao on 2017/2/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShakeModel.h"
#import "FaceModel.h"
@interface ShakeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconUrlImageView;

@property (weak, nonatomic) IBOutlet UILabel *titlelabel;

@property (weak, nonatomic) IBOutlet UILabel *beconnameDevidedID;

@property(nonatomic,strong)ShakeModel *model;

@property(nonatomic,strong)FaceModel *faceModel;
@end
