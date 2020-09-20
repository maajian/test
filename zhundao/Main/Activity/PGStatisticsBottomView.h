//
//  ZDStatisticsHeaderView.h
//  jingjing
//
//  Created by maj on 2020/9/16.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PGStatisticsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGStatisticsBottomView : UIView
@property (nonatomic, strong) NSMutableArray<PGStatisticsModel *> *dataSource;

@end

NS_ASSUME_NONNULL_END
