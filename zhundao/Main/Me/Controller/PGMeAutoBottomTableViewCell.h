//
//  PGMeAutoBottomTableViewCell.h
//  zhundao
//
//  Created by zhundao on 2017/9/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGMeAuthModel.h"
@interface PGMeAutoBottomTableViewCell : UITableViewCell

/*! 文字label */
@property(nonatomic,strong)UILabel *topLabel;
/*! 身份证图片 */
@property(nonatomic,strong)UIImageView *idCardImgView;
/*! 文字 */
@property(nonatomic,copy)NSString *topStr;
/*! 传图 */
@property(nonatomic,strong)PGMeAuthModel *model;

@end
