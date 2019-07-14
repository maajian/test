//
//  ChooseCustomViewController.h
//  zhundao
//
//  Created by zhundao on 2017/7/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^backBlock) (NSArray *array);
@interface ChooseCustomViewController : BaseViewController

@property(nonatomic,copy)backBlock block;

@property(nonatomic,copy)NSArray *nowDataArray ;

@end
