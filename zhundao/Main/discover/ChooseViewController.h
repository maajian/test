//
//  ChooseViewController.h
//  zhundao
//
//  Created by zhundao on 2017/1/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomModel.h"
typedef void(^backBlock) (NSDictionary *dic);
@interface ChooseViewController : BaseViewController
@property(nonatomic,strong)CustomModel *model;
@property(nonatomic,copy)backBlock block;
@end
