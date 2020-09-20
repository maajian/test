//
//  PGDiscoverDefaultVC.h
//  zhundao
//
//  Created by zhundao on 2017/10/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGBaseVC.h"

@interface PGDiscoverDefaultVC : PGBaseVC
/*! 活动标题 */
@property(nonatomic,copy)NSString *activityTitle;
/*! 二维码字符串 */
@property(nonatomic,copy)NSString *codeStr;
/*! 姓名 */
@property(nonatomic,copy)NSString *name;
/*! 时间 */
@property(nonatomic,copy)NSString *timeStr;
/*! 地址 */
@property(nonatomic,copy)NSString *address;
/*! 是否为签到二维码 */
@property(nonatomic,assign)BOOL isSign;

@end
