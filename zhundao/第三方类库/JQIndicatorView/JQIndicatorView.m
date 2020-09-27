#import "PGDeviceLinkView.h"
#import "JQIndicatorView.h"
#import "JQIndicatorAnimationProtocol.h"
#import "JQMusic1Animation.h"
#import "JQMusic2Animation.h"
#import "JQBounceSpot1Animation.h"
#import "JQBounceSpot2Animation.h"
#import "JQCyclingLineAnimation.h"
#import "JQCyclingCycleAnimation.h"
#define JQIndicatorDefaultTintColor [UIColor colorWithRed:0.049 green:0.849 blue:1.000 alpha:1.000]
#define JQIndicatorDefaultSize CGSizeMake(60,60)
@interface JQIndicatorView ()
@property (nonatomic, weak) id<JQIndicatorAnimationProtocol> animation;
@property (nonatomic, assign) JQIndicatorType type;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, strong) UIColor *loadingTintColor;
- (void)PG_setToNormalState;
- (void)PG_setToFadeOutState;
- (void)PG_fadeOutWithAnimation:(BOOL)animated;
@end
@implementation JQIndicatorView
- (instancetype)initWithType:(JQIndicatorType)type{
    return [self initWithType:type tintColor:JQIndicatorDefaultTintColor];
}
- (instancetype)initWithType:(JQIndicatorType)type tintColor:(UIColor *)color{
    return [self initWithType:type tintColor:color size:JQIndicatorDefaultSize];
}
- (instancetype)initWithType:(JQIndicatorType)type tintColor:(UIColor *)color size:(CGSize)size{
    if (self = [super init]) {
        self.type = type;
        self.loadingTintColor = color;
        self.size = size;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PG_appWillEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PG_appWillBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}
#pragma mark - Animation
- (void)startAnimating{
    self.layer.sublayers = nil;
    [self PG_setToNormalState];
    self.animation = [self PG_animationForIndicatorType:self.type];
    if ([self.animation respondsToSelector:@selector(configAnimationAtLayer:withTintColor:size:)]) {
        [self.animation configAnimationAtLayer:self.layer withTintColor:self.loadingTintColor size:self.size];
    }
    self.isAnimating = YES;
}
- (void)stopAnimating{
    if (self.isAnimating == YES) {
        if ([self.animation respondsToSelector:@selector(removeAnimation)]) {
            [self.animation removeAnimation];
            self.isAnimating = NO;
            self.animation = nil;
        }
        [self PG_fadeOutWithAnimation:YES];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}
- (id<JQIndicatorAnimationProtocol>)PG_animationForIndicatorType:(JQIndicatorType)type{
    switch (type) {
        case JQIndicatorTypeMusic1:
            return [[JQMusic1Animation alloc] init];
        case JQIndicatorTypeMusic2:
            return [[JQMusic2Animation alloc] init];
        case JQIndicatorTypeBounceSpot1:
            return [[JQBounceSpot1Animation alloc] init];
        case JQIndicatorTypeBounceSpot2:
            return [[JQBounceSpot2Animation alloc] init];
        case JQIndicatorTypeCyclingLine:
            return [[JQCyclingLineAnimation alloc] init];
        case JQIndicatorTypeCyclingCycle:
            return [[JQCyclingCycleAnimation alloc] init];
        default:
            break;
    }
}
#pragma mark - Indicator animation methods
- (void)PG_setToNormalState{
    self.layer.backgroundColor = [UIColor grayColor].CGColor;
    self.layer.speed = 1.0f;
    self.layer.opacity = 1.0;
}
- (void)PG_setToFadeOutState{
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    self.layer.sublayers = nil;
    self.layer.opacity = 0.f;
}
- (void)PG_fadeOutWithAnimation:(BOOL)animated{
    if (animated) {
        CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeAnimation.delegate = self;
        fadeAnimation.beginTime = CACurrentMediaTime();
        fadeAnimation.duration = 0.35;
        fadeAnimation.toValue = @(0);
        [self.layer addAnimation:fadeAnimation forKey:@"fadeOut"];
    }
}
#pragma mark - CAAnimation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self PG_setToFadeOutState];
}
#pragma mark - Did enter background
- (void)PG_appWillEnterBackground{
    if (self.isAnimating == YES) {
        [self.animation removeAnimation];
    }
}
- (void)PG_appWillBecomeActive{
dispatch_async(dispatch_get_main_queue(), ^{
    UIFont *pickerGroupTablei0= [UIFont systemFontOfSize:80];
        UITableViewStyle bottomPhotoViewK6 = UITableViewStylePlain; 
    PGDeviceLinkView *infoViewModel= [[PGDeviceLinkView alloc] init];
[infoViewModel baseLoginViewWithplayerItemStatus:pickerGroupTablei0 dailyCourseTable:bottomPhotoViewK6 ];
});
    if (self.isAnimating == YES) {
        [self startAnimating];
    }
}
@end
