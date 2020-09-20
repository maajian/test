//
//  ZDActivityEditWebVC.h
//  zhundao
//
//  Created by zhundao on 2017/5/12.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^postBlock1) (NSAttributedString *text,NSString *htmlstr,NSString *titletext);
@interface ZDActivityEditWebVC : ZDBaseVC
@property(nonatomic,copy)postBlock1 block;
@property(nonatomic,copy)NSAttributedString *pushText;
@property(nonatomic,copy)NSArray *imageArray;
@end
