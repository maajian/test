//
//  XYViewController.h
//  zhundao
//
//  Created by zhundao on 2017/7/5.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"
@protocol XYdelegate <NSObject>

- (void)backWithX :(NSString * )offsetx y :(NSString *)offsety;
@end

@interface XYViewController : ZDBaseVC
@property(nonatomic,weak) id<XYdelegate> delegate ;
@end
