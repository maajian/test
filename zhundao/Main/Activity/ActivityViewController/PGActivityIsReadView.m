#import "PGTextAttributedString.h"
#import "PGActivityIsReadView.h"
@interface PGActivityIsReadView()
@property (nonatomic, strong) UIView *topline;
@end
@implementation PGActivityIsReadView
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.cancelButton];
        [self addSubview:self.nextStepButton];
        [self addSubview:self.topline];
    }
    return self;
}
#pragma mark ---懒加载
- (UIButton *)nextStepButton{
    if (!_nextStepButton) {
        _nextStepButton = [MyButton initWithButtonFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 44) title:@"下一步(已选0人)" textcolor:kColorA(11, 120, 205, 1) Target:self action:@selector(PG_chooseSome) BackgroundColor:nil cornerRadius:0 masksToBounds:0];
        _nextStepButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nextStepButton;
}
- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [MyButton initWithButtonFrame:CGRectMake(0, 0, kScreenWidth/2, 44) title:@"取消" textcolor:[UIColor blackColor] Target:self action:  @selector(PG_chooseAll) BackgroundColor:nil cornerRadius:0 masksToBounds:0];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _cancelButton;
}
- (UIView *)topline {
    if (!_topline) {
        _topline = [[ UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        _topline.backgroundColor = kColorA(220, 220, 220, 0.5);
    }
    return _topline;
}
#pragma mark---按钮点击事件
- (void)PG_chooseSome {
    if ([self.readDelegate respondsToSelector:@selector(nextStep)])  {
        [self.readDelegate nextStep];
    }
}
- (void)PG_chooseAll{
    if ([self.readDelegate respondsToSelector:@selector(cancelSend)]) {
        [self.readDelegate cancelSend];
    }
}
#pragma mark---动画
- (void)dealloc{
    NSLog(@"read没有内存泄露");
}
@end
