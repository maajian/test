//
//  InputFieldViewController.h
//  zhundao
//
//  Created by zhundao on 2017/1/17.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"
typedef void(^backBlock) (NSDictionary *dic);
@interface InputFieldViewController : ZDBaseVC
@property(nonatomic,copy)backBlock block;
@property(nonatomic,assign)NSInteger type;
@end
