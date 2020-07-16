//
//  pulldownViewController.h
//  zhundao
//
//  Created by zhundao on 2017/1/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^backBlock) (NSDictionary *dic);
@interface pulldownViewController : ZDBaseVC
@property(nonatomic,copy)backBlock block;
@end
