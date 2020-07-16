//
//  MultipleChoiceViewController.h
//  zhundao
//
//  Created by zhundao on 2017/1/17.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^backBlock) (NSDictionary *dic);

@interface MultipleChoiceViewController : ZDBaseVC
@property(nonatomic,copy)backBlock block;
@end
