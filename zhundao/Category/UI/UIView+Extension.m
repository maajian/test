//
//  UIView+Extension.m
//  zhundao
//
//  Created by maj on 2018/12/1.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x {
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y {
    return self.frame.origin.y;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin {
    return self.frame.origin;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}
- (void)setCenterX:(CGFloat)centerX {
    CGPoint newCenter = self.center;
    newCenter.x = centerX;
    self.center = newCenter;
}
- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterY:(CGFloat)centerY {
    CGPoint newCenter = self.center;
    newCenter.y = centerY;
    self.center = newCenter;
}
- (CGFloat)centerY {
    return self.center.y;
}
- (void)setMaxX:(CGFloat)maxX {
    CGRect frame = self.frame;
    frame.origin.x = maxX - frame.size.width;
    self.frame = frame;
}
- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}
- (void)setMaxY:(CGFloat)maxY {
    CGRect frame = self.frame;
    frame.origin.y = maxY - frame.size.height;
    self.frame = frame;
}
- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}


- (void)setMinX:(CGFloat)minX {
    CGRect frame = self.frame;
    frame.origin.x = minX;
    self.frame = frame;
}
- (CGFloat)minX {
    return CGRectGetMinX(self.frame);
}
- (void)setMinY:(CGFloat)minY {
    CGRect frame = self.frame;
    frame.origin.y = minY;
    self.frame = frame;
}
- (CGFloat)minY {
    return CGRectGetMinY(self.frame);
}


@end

@implementation UIView (GestureRecognize)

- (void)addTapGestureTarget:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tapG];
}
- (void)addDoubleTapGestureTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tapG.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tapG];
}
- (void)addPanGestureTarget:(id)target action:(SEL)action {
    UIPanGestureRecognizer *panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:action];
    [self addGestureRecognizer:panG];
}
- (void)addSwipeGesture:(UISwipeGestureRecognizerDirection)direction target:(id)target action:(SEL)action {
    UISwipeGestureRecognizer *swipeG = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
    swipeG.cancelsTouchesInView = NO;
    swipeG.direction = direction;
    [self addGestureRecognizer:swipeG];
}
- (void)addPinchGestureTarget:(id)target action:(SEL)action {
    UIPinchGestureRecognizer *pinchG = [[UIPinchGestureRecognizer alloc] initWithTarget:target action:action];
    pinchG.cancelsTouchesInView = NO;
    [self addGestureRecognizer:pinchG];
}

@end

