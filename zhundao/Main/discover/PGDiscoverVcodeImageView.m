//
//  PGDiscoverVcodeImageView.m
//  zhundao
//
//  Created by zhundao on 2017/9/25.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGDiscoverVcodeImageView.h"
#import "UIImage+LXDCreateBarcode.h"
@implementation PGDiscoverVcodeImageView

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake((kScreenWidth -100)/2, kScreenHeight/2-100, 100, 100);
        self.image = [UIImage imageOfQRFromURL:@"www.baidu.com"];
        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [self addGestureRecognizer:longPress];
        [self addGestureRecognizer:pinch];
        
    }
    return self;
}
  /*! 改变点击范围 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, -30, -30);
    return CGRectContainsPoint(bounds, point);
}

/*! 缩放 捏合手势*/
- (void)pinch:(UIPinchGestureRecognizer *)gestureRecognizer{
    /*! 开始缩放 */
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.center = CGPointMake(self.center.x, self.center.y);
        self.bounds = CGRectMake(0, 0,CGRectGetWidth(self.frame)*gestureRecognizer.scale,CGRectGetHeight(self.frame)*gestureRecognizer.scale);
    }
    //设置比例 为 1 。下次在这个scale基础上改变
    gestureRecognizer.scale = 1;
    
}
- (void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [gestureRecognizer.view becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *item2 = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(myDelete:)];
        UIMenuItem *item1 = [[UIMenuItem alloc]initWithTitle:@"居中" action:@selector(center:)];
        menu.menuItems =@[item1,item2];
        [menu setTargetRect:gestureRecognizer.view.bounds inView:gestureRecognizer.view];
        [menu setMenuVisible:YES animated:YES];
    }
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(myDelete:)||
        action == @selector(center:)) {
        return YES;
    }
    return NO;
}
- (void)myDelete:(UIMenuController *)menu{
    [self removeFromSuperview];
}
- (void)center:(UIMenuController *)menu{
    self.center = CGPointMake(kScreenWidth/2, self.center.y);
}
@end
