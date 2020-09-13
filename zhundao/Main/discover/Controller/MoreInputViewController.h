//
//  MoreInputViewController.h
//  zhundao
//
//  Created by zhundao on 2017/1/17.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^backpopBlock) (NSDictionary *dic);
@interface MoreInputViewController : BaseViewController
@property(nonatomic,copy)backpopBlock block;
@end
