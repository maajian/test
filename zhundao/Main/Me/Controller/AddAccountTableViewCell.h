//
//  AddAccountTableViewCell.h
//  zhundao
//
//  Created by zhundao on 2017/9/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAccountTableViewCell : UITableViewCell
/*! 下面右边输入框 */
@property(nonatomic,strong)UITextField *textf;
/*! 下面左边的label */
@property(nonatomic,strong)UILabel *bottomLeftLabel;
/*! 第一行银行的label */
@property(nonatomic,strong)UILabel *rightLabel;
/*! 提现方式label */
@property(nonatomic,strong)UILabel *topLeftLabel;
/*! 说明现在是第几行 */
@property(nonatomic,assign)NSInteger row;

/*! 支付方式 默认支付宝 */
@property(nonatomic,copy)NSString *currentType;

@property(nonatomic,copy)NSString *name;

@end
