//
//  ZDDiscoveEditApplyCell.h
//  zhundao
//
//  Created by maj on 2018/12/4.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZDDiscoveEditApplyCell;

@protocol ZDDiscoveEditApplyCellDelegate <NSObject>
// 删除 按钮点击
- (void)tableViewCell:(ZDDiscoveEditApplyCell *)tableViewCell didSelectButton:(UIButton *)button;
// 输入框结束编辑
- (void)tableViewCell:(ZDDiscoveEditApplyCell *)tableViewCell didEndEdit:(UITextField *)textField;

@end

@interface ZDDiscoveEditApplyCell : UITableViewCell
// 代理
@property (nonatomic, weak) id<ZDDiscoveEditApplyCellDelegate> discoveEditApplyCellDelegate;
// 内容
@property (nonatomic, strong) NSString *text;
// 按钮
@property (nonatomic, strong) UIButton *leftButton;
// 选项输入框
@property (nonatomic, strong) UITextField *choiceTF;

@end

NS_ASSUME_NONNULL_END
