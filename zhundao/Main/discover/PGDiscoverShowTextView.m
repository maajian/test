//
//  PGDiscoverShowTextView.m
//  zhundao
//
//  Created by zhundao on 2017/9/25.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGDiscoverShowTextView.h"

@interface PGDiscoverShowTextView()<UIGestureRecognizerDelegate>{
    NSInteger tag;
}

@end

@implementation PGDiscoverShowTextView

-(instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake((kScreenWidth -100)/2, kScreenHeight/2-100, 100, 30);
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:17];
        self.scrollEnabled = NO;
        self.editable = NO;
        [self setSelectable:NO];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        longPress.delegate =self;
         [self addGestureRecognizer:longPress];
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*) otherGestureRecognizer{
    NSLog(@"%@", NSStringFromClass([otherGestureRecognizer class]));
    if([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] && [NSStringFromClass([otherGestureRecognizer class])isEqualToString:@"UITapGestureRecognizer"]){
        return NO;
    }
    return YES;
}

- (void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    tag = gestureRecognizer.view.tag;
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [gestureRecognizer.view becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *item1 = [[UIMenuItem alloc]initWithTitle:@"居左" action:@selector(left:)];
        UIMenuItem *item2 = [[UIMenuItem alloc]initWithTitle:@"居中" action:@selector(center:)];
        UIMenuItem *item3 = [[UIMenuItem alloc]initWithTitle:@"居右" action:@selector(right:)];
         UIMenuItem *item4 = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(myDelete:)];
        menu.menuItems =@[item1,item2,item3,item4];
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
    if (action == @selector(myDelete:)
        || action == @selector(center:)
        ||action == @selector(left:)
        ||action == @selector(right:)) {
        return YES;
    }
    return NO;
}
- (void)myDelete:(UIMenuController *)menu{
    PGDiscoverShowTextView *textView = [self viewWithTag:tag];
    [textView removeFromSuperview];
}
- (void)center:(UIMenuController *)menu{
    PGDiscoverShowTextView *textView = [self viewWithTag:tag];
    textView.center = CGPointMake(kScreenWidth/2 , textView.center.y);
}
- (void)left:(UIMenuController *)menu{
    PGDiscoverShowTextView *textView = [self viewWithTag:tag];
    textView.frame = CGRectMake(0, CGRectGetMinY(textView.frame), CGRectGetWidth(textView.frame), CGRectGetHeight(textView.frame));
}
- (void)right:(UIMenuController *)menu{
    PGDiscoverShowTextView *textView = [self viewWithTag:tag];
    textView.frame = CGRectMake(kScreenWidth-CGRectGetWidth(textView.frame), CGRectGetMinY(textView.frame), CGRectGetWidth(textView.frame), CGRectGetHeight(textView.frame));
}
@end
