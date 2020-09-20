//
//  PGActivityOneConsultVC.h
//  zhundao
//
//  Created by zhundao on 2017/8/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGBaseVC.h"

#import "PGActivityConsultModel.h"

@interface PGActivityOneConsultVC : PGBaseVC

@property(nonatomic,strong)PGActivityConsultModel *model;
/*! 时间字符串 */
@property(nonatomic,strong)NSString *timeStr;
@end
