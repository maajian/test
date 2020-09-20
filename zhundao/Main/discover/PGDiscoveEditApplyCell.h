//
//  PGDiscoveEditApplyCell.h
//  zhundao
//
//  Created by maj on 2018/12/4.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PGDiscoveEditApplyCell;

@protocol PGDiscoveEditApplyCellDelegate <NSObject>
// 删除 按钮点击
- (void)tableViewCell:(PGDiscoveEditApplyCell *)tableViewCell didSelectButton:(UIButton *)button;
// 输入框结束编辑
- (void)tableViewCell:(PGDiscoveEditApplyCell *)tableViewCell didEndEdit:(UITextField *)textField;

@end

@interface PGDiscoveEditApplyCell : UITableViewCell
// 代理
@property (nonatomic, weak) id<PGDiscoveEditApplyCellDelegate> discoveEditApplyCellDelegate;
// 内容
@property (nonatomic, strong) NSString *text;
// 按钮
@property (nonatomic, strong) UIButton *leftButton;
// 选项输入框
@property (nonatomic, strong) UITextField *choiceTF;

@end

NS_ASSUME_NONNULL_END
