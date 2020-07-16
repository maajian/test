//
//  ChangeInputViewController.h
//  zhundao
//
//  Created by zhundao on 2017/1/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomModel.h"
typedef void(^backBlock) (NSDictionary *dic);
@interface ChangeInputViewController : ZDBaseVC
@property(nonatomic,assign)CustomModel *model;
//@property(nonatomic,assign)NSInteger inputID;
//@property(nonatomic,assign)NSInteger inputtype;
@property(nonatomic,copy)backBlock block;
@end
