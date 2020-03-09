//
//  UIView+Extension.h
//  zhundao
//
//  Created by maj on 2018/12/1.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat minX;
@property (nonatomic, assign) CGFloat minY;

@end

@interface UIView (GestureRecognize)
- (void)addTapGestureTarget:(id)target action:(SEL)action;
- (void)addDoubleTapGestureTarget:(id)target action:(SEL)action;
- (void)addPanGestureTarget:(id)target action:(SEL)action;
- (void)addSwipeGesture:(UISwipeGestureRecognizerDirection)direction target:(id)target action:(SEL)action;
- (void)addPinchGestureTarget:(id)target action:(SEL)action;

@end

@interface UIView (SubView)
// 是否包含某个class
- (BOOL)containView:(Class)viewClass;
//  移除所有子视图
- (void)removeAllSubviews;

@end

NS_ASSUME_NONNULL_END
