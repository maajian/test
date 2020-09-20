//
//  ZDMeAutoTopTableViewCell.h
//  zhundao
//
//  Created by zhundao on 2017/9/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDMeAutoTopTableViewCell : UITableViewCell
/*! 右边输入框 */
@property(nonatomic,strong)UITextField *rightTf;
/*! 左边lebel */
@property(nonatomic,strong)UILabel *leftlabel;

@property(nonatomic,copy)NSString *leftStr;
@end
