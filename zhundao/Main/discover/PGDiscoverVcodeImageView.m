#import "PGDiscoverVcodeImageView.h"
#import "UIImage+LXDCreateBarcode.h"
@implementation PGDiscoverVcodeImageView
- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake((kScreenWidth -100)/2, kScreenHeight/2-100, 100, 100);
        self.image = [UIImage imageOfQRFromURL:@"www.baidu.com"];
        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(PG_longPress:)];
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(PG_pinch:)];
        [self addGestureRecognizer:longPress];
        [self addGestureRecognizer:pinch];
    }
    return self;
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, -30, -30);
    return CGRectContainsPoint(bounds, point);
}
- (void)PG_pinch:(UIPinchGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.center = CGPointMake(self.center.x, self.center.y);
        self.bounds = CGRectMake(0, 0,CGRectGetWidth(self.frame)*gestureRecognizer.scale,CGRectGetHeight(self.frame)*gestureRecognizer.scale);
    }
    gestureRecognizer.scale = 1;
}
- (void)PG_longPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [gestureRecognizer.view becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *item2 = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(PG_myDelete:)];
        UIMenuItem *item1 = [[UIMenuItem alloc]initWithTitle:@"居中" action:@selector(PG_center:)];
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
    if (action == @selector(PG_myDelete:)||
        action == @selector(PG_center:)) {
        return YES;
    }
    return NO;
}
- (void)PG_myDelete:(UIMenuController *)menu{
    [self removeFromSuperview];
}
- (void)PG_center:(UIMenuController *)menu{
    self.center = CGPointMake(kScreenWidth/2, self.center.y);
}
@end
