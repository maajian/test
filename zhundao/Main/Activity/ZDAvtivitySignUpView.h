//
//  ZDAvtivitySignUpView.h
//  zhundao
//
//  Created by xhkj on 2018/4/24.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDAvtivitySignUpView : UIView
/*! 添加折线图 */
- (instancetype)initWithFrame:(CGRect)frame xLabels:(NSArray *)xLabels dataArray:(NSArray *)dataArray title:(NSString *)title;
/*! 添加饼图 */
- (instancetype)initWithFrame:(CGRect)frame personArray:(NSArray *)personArray comeInArray:(NSArray *)comeInArray;
@end
