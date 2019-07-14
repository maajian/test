//
//  InputFieldViewController.h
//  zhundao
//
//  Created by zhundao on 2017/1/17.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^backBlock) (NSDictionary *dic);
@interface InputFieldViewController : BaseViewController
@property(nonatomic,copy)backBlock block;
@property(nonatomic,assign)NSInteger type;
@end
