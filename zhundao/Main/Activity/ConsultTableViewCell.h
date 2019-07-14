//
//  ConsultTableViewCell.h
//  zhundao
//
//  Created by zhundao on 2017/8/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultModel.h"
@interface ConsultTableViewCell : UITableViewCell
/*! 内容 */
@property(nonatomic,strong)ConsultModel *model;
/*! 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
/*! 姓名 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/*! 提问标签 */
@property (weak, nonatomic) IBOutlet UILabel *consultLabel;
/*! 时间标签 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/*! 是否已经回复 */
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
/*! 是否为推荐 */
@property (weak, nonatomic) IBOutlet UILabel *recommendLabel;
/*! 时间字符串 */
@property(nonatomic,copy)NSString  *timeStr;
@end
