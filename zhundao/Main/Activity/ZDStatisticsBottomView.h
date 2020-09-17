//
//  ZDStatisticsHeaderView.h
//  jingjing
//
//  Created by maj on 2020/9/16.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZDStatisticsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDStatisticsBottomView : UIView
@property (nonatomic, strong) NSMutableArray<ZDStatisticsModel *> *dataSource;

@end

NS_ASSUME_NONNULL_END
