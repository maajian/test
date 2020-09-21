//
//  CodeViewController.h
//  zhundao
//
//  Created by zhundao on 2017/2/17.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"

@interface CodeViewController : BaseViewController
@property(nonatomic,strong)NSString *titlestr;
@property(nonatomic,strong)NSString *imagestr ;

@property(nonatomic,strong)NSString *labelStr ;

@property (nonatomic, assign) BOOL hideLabel;
@property (nonatomic, assign) BOOL ossImage;
@end
