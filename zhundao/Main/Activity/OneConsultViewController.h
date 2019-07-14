//
//  OneConsultViewController.h
//  zhundao
//
//  Created by zhundao on 2017/8/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"

#import "ConsultModel.h"

@interface OneConsultViewController : BaseViewController

@property(nonatomic,strong)ConsultModel *model;
/*! 时间字符串 */
@property(nonatomic,strong)NSString *timeStr;
@end
