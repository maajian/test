//
//  ChangeInputViewController.h
//  zhundao
//
//  Created by zhundao on 2017/1/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomModel.h"
typedef void(^backpopBlock) (NSDictionary *dic);
@interface ChangeInputViewController : BaseViewController
@property(nonatomic,assign)CustomModel *model;
@property(nonatomic,copy)backpopBlock block;
@end
