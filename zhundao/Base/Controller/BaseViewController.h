//
//  BaseViewController.h
//  zhundao
//
//  Created by zhundao on 2016/12/1.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property(nonatomic,strong)UILabel *nulllabel;
@property(nonatomic,strong)UIImageView *nullimageview;
- (UIImageView *)showNullImage;
- (UILabel *)showNullLabelWithText :(NSString *)text WithTextColor :(UIColor *)color;
- (void)shownull :(NSArray *)nullArray WithText :(NSString *)text WithTextColor :(UIColor *)Color;
@end
