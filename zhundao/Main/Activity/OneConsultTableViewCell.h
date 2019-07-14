//
//  OneConsultTableViewCell.h
//  zhundao
//
//  Created by zhundao on 2017/8/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultModel.h"
@interface OneConsultTableViewCell : UITableViewCell
/*! 内容 */
@property(nonatomic,strong)ConsultModel *model;
/*! 头像 */
@property(nonatomic,strong) UIImageView *imgView ;
/*! 姓名 */
@property(nonatomic,strong)UILabel *nameLabel ;
/*! 手机 */
@property(nonatomic,strong)UILabel * phoneLabel;
/*! 提问 */
@property(nonatomic,strong)UILabel * questionLabel ;
/*! 回答 */
@property(nonatomic,strong)UILabel * anwserLabel;
/*! 时间标签 */
@property(nonatomic,strong) UILabel  *timeLabel;
/*! 输入框 */
@property(nonatomic,strong)UITextView *textView;
/*! 开关 */
@property(nonatomic,strong)UISwitch *mySwitch;
/*! label */
@property(nonatomic,strong) UILabel  *remLabel;
/*! 提问标签的高度 */
@property(nonatomic,assign)float height;
/*! 时间 */
@property(nonatomic,strong)NSString *timeStr ;
@end
