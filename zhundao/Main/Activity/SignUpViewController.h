//
//  SignUpViewController.h
//  zhundao
//
//  Created by xhkj on 2018/4/24.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, DateType) {
    DateTypeWeek,
    DateTypeFifteenDay,
    DateTypeMonth,
};

typedef NS_ENUM(NSInteger, ChartType) {
    ChartTypeActivityPerson, /*! 报名人数 */
    ChartTypeRead, /*! 浏览人数 */
    ChartTypePay, /*! 收入，付款 */
};

@interface SignUpViewController : BaseViewController
/*! 活动id */
@property (nonatomic, assign) NSInteger activityId;
/*! 图表类型 */
@property (nonatomic, assign) ChartType chartType;

@end
