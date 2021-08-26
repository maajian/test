//
//  ZDActivityMoreChioceVC+MoveItem.h
//  zhundao
//
//  Created by maj on 2021/3/31.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivityMoreChioceVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDActivityMoreChioceVC (MoveItem)
// 拖拽手势
@property (nonatomic, strong) UILongPressGestureRecognizer *moveGestureRecognizer;
// 添加长按手势
- (void)addlongPressToMoveGes;

@end

NS_ASSUME_NONNULL_END
