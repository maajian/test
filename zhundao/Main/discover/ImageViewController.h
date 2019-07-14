//
//  ImageViewController.h
//  zhundao
//
//  Created by zhundao on 2017/1/17.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^blackBlock) (NSDictionary *dic);
@interface ImageViewController : BaseViewController
@property(nonatomic,copy)blackBlock block;
@end
