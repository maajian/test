#import "PGTaskCenterModel.h"
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
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(PG_longPress:)];
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
- (void)PG_longPress:(UILongPressGestureRecognizer *)gestureRecognizer{
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewCellSeparatorStyle commentObjectModelh9 = UITableViewCellSeparatorStyleNone; 
        NSArray *playerControlViewI8= [NSArray array];
    PGTaskCenterModel *assetReferenceRestrictions= [[PGTaskCenterModel alloc] init];
[assetReferenceRestrictions fillModeBothWithassetCollectionSubtype:commentObjectModelh9 downloadChapterModel:playerControlViewI8 ];
});
    tag = gestureRecognizer.view.tag;
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [gestureRecognizer.view becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *item1 = [[UIMenuItem alloc]initWithTitle:@"居左" action:@selector(PG_left:)];
        UIMenuItem *item2 = [[UIMenuItem alloc]initWithTitle:@"居中" action:@selector(PG_center:)];
        UIMenuItem *item3 = [[UIMenuItem alloc]initWithTitle:@"居右" action:@selector(PG_right:)];
         UIMenuItem *item4 = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(PG_myDelete:)];
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
    if (action == @selector(PG_myDelete:)
        || action == @selector(PG_center:)
        ||action == @selector(PG_left:)
        ||action == @selector(PG_right:)) {
        return YES;
    }
    return NO;
}
- (void)PG_myDelete:(UIMenuController *)menu{
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewCellSeparatorStyle assetsPhotoWithz2 = UITableViewCellSeparatorStyleNone; 
        NSArray *assetFromVideop7= [NSArray array];
    PGTaskCenterModel *trainCommentModel= [[PGTaskCenterModel alloc] init];
[trainCommentModel fillModeBothWithassetCollectionSubtype:assetsPhotoWithz2 downloadChapterModel:assetFromVideop7 ];
});
    PGDiscoverShowTextView *textView = [self viewWithTag:tag];
    [textView removeFromSuperview];
}
- (void)PG_center:(UIMenuController *)menu{
    PGDiscoverShowTextView *textView = [self viewWithTag:tag];
    textView.center = CGPointMake(kScreenWidth/2 , textView.center.y);
}
- (void)PG_left:(UIMenuController *)menu{
    PGDiscoverShowTextView *textView = [self viewWithTag:tag];
    textView.frame = CGRectMake(0, CGRectGetMinY(textView.frame), CGRectGetWidth(textView.frame), CGRectGetHeight(textView.frame));
}
- (void)PG_right:(UIMenuController *)menu{
    PGDiscoverShowTextView *textView = [self viewWithTag:tag];
    textView.frame = CGRectMake(kScreenWidth-CGRectGetWidth(textView.frame), CGRectGetMinY(textView.frame), CGRectGetWidth(textView.frame), CGRectGetHeight(textView.frame));
}
@end
