//
//  PGMeNoticeTableViewCell.h
//  zhundao
//
//  Created by zhundao on 2017/8/15.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGMeNoticeModel.h"
@interface PGMeNoticeTableViewCell : UITableViewCell
/*! model */
@property(nonatomic,strong)PGMeNoticeModel *model ;
/*! 顶部label */
@property(nonatomic,strong)UILabel  *topLabel ;
/*! 底部label */
@property(nonatomic,strong)UILabel *bottomLabel ;
/*! 时间显示数据 */
@property(nonatomic,copy)NSString *timeText;

@end