//
//  customInviteViewController.h
//  zhundao
//
//  Created by zhundao on 2017/10/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"

@interface customInviteViewController : BaseViewController

/*! 签到二维码字符串 */
@property(nonatomic,copy)NSString *signCodeStr;
/*! 报名二维码字符串 */
@property(nonatomic,copy)NSString *activityCodeStr;
/*! 活动地址 */
@property(nonatomic,copy)NSString *activityAddress;
/*! 活动时间 */
@property(nonatomic,copy)NSString *activityTime;
/*! 活动标题 */
@property(nonatomic,copy)NSString *activityTitle;
/*! 姓名 */
@property(nonatomic,copy)NSString *name;

@end
