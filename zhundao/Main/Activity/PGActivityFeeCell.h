//
//  PGActivityFeeCell.h
//  zhundao
//
//  Created by zhundao on 2017/5/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PGActivityFeeCell;
@protocol PGActivityFeeCellDelegate <NSObject>

- (void)PGActivityFeeCell:(PGActivityFeeCell *)PGActivityFeeCell showSwitchDidChange:(UISwitch *)showSwitch;

@end

@interface PGActivityFeeCell : UITableViewCell
@property (strong, nonatomic)  UILabel *leftLabel1;
@property (strong, nonatomic)  UILabel *leftLabel2;
@property (strong, nonatomic)  UILabel *leftLabel3;
@property (strong, nonatomic)  UILabel *leftLabel4;
@property (strong, nonatomic)  UILabel *leftLable5;
@property (strong, nonatomic)  UITextField *textFIeld1;
@property (strong, nonatomic)  UITextField *textFIeld2;
@property (strong, nonatomic)  UITextField *textFIeld3;
@property (strong, nonatomic)  UITextField *textField4;
@property (strong, nonatomic)  UIImageView *deleteImageView;
@property (strong, nonatomic)  UISwitch *showSwitch;

@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UIView *lineView2;
@property (nonatomic, strong) UIView *lineView3;
@property (nonatomic, strong) UIView *lineView4;

@property (nonatomic, weak) id<PGActivityFeeCellDelegate> PGActivityFeeCellDelegate;

@end
