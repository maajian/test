//
//  PGDiscoverXYVC.h
//  zhundao
//
//  Created by zhundao on 2017/7/5.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGBaseVC.h"
@protocol XYdelegate <NSObject>

- (void)backWithX :(NSString * )offsetx y :(NSString *)offsety;
@end

@interface PGDiscoverXYVC : PGBaseVC
@property(nonatomic,weak) id<XYdelegate> delegate ;
@end
