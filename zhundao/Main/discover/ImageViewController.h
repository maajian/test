//
//  ImageViewController.h
//  zhundao
//
//  Created by zhundao on 2017/1/17.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"
typedef void(^blackBlock) (NSDictionary *dic);
@interface ImageViewController : ZDBaseVC
@property(nonatomic,copy)blackBlock block;
@end
