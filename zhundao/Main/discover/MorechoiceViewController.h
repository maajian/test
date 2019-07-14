//
//  MorechoiceViewController.h
//  zhundao
//
//  Created by zhundao on 2017/1/17.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^backBlock) (NSDictionary *dic);
@interface MorechoiceViewController : BaseViewController
@property(nonatomic,copy)backBlock block;
@end
