#import "PGImageCompressionWith.h"
#import "SGTopTitleView.h"
#import "UIView+SGExtension.h"
#define labelFontOfSize [UIFont systemFontOfSize:17]
#define SG_screenWidth [UIScreen mainScreen].bounds.size.width
#define selectedTitleAndIndicatorViewColor [UIColor redColor]
#define kAppMiddleTextFont [UIFont systemFontOfSize:15]
#define kAppButtonColor [UIColor colorWithRed:0.13 green:0.59 blue:0.95 alpha:1.00]
#define kCellDefaultMargin 10
#define kAppLargeTextFont [UIFont systemFontOfSize:16]
#define kAppGrayColor [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.0]
@interface SGTopTitleView ()
@property (nonatomic, strong) UILabel *staticTitleLabel;
@property (nonatomic, strong) UILabel *scrollTitleLabel;
@property (nonatomic, strong) UILabel *selectedTitleLabel;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UILabel *bottomLineLabel;
@end
@implementation SGTopTitleView
static CGFloat const labelMargin = 15;
static CGFloat const indicatorHeight = 3;
- (NSMutableArray *)allTitleLabel {
    if (_allTitleLabel == nil) {
        _allTitleLabel = [NSMutableArray array];
    }
    return _allTitleLabel;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
    }
    return self;
}
+ (instancetype)topTitleViewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}
- (CGSize)PG_sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
#pragma mark - - - 重写静止标题数组的setter方法
- (void)setStaticTitleArr:(NSArray *)staticTitleArr {
    _staticTitleArr = staticTitleArr;
    CGFloat scrollViewWidth = self.frame.size.width;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelW = scrollViewWidth / self.staticTitleArr.count;
    CGFloat labelH = self.frame.size.height;
    while (self.subviews.lastObject) {
        [self.subviews.lastObject removeFromSuperview];
    }
    for (NSInteger j = 0; j < self.staticTitleArr.count; j++) {
        self.staticTitleLabel = [[UILabel alloc] init];
        _staticTitleLabel.userInteractionEnabled = YES;
        _staticTitleLabel.text = self.staticTitleArr[j];
        _staticTitleLabel.font = kAppMiddleTextFont;
        _staticTitleLabel.textAlignment = NSTextAlignmentCenter;
        _staticTitleLabel.tag = j;
        _staticTitleLabel.highlightedTextColor = ZDMainColor;
        _staticTitleLabel.textColor = kColorA(102, 102, 102, 1.0);
        labelX = j * labelW;
        _staticTitleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
        [self.allTitleLabel addObject:_staticTitleLabel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PG_staticTitleClick:)];
        [_staticTitleLabel addGestureRecognizer:tap];
        if (j == 0) {
            [self PG_staticTitleClick:tap];
        }
        [self addSubview:_staticTitleLabel];
    }
    UILabel *firstLabel = self.subviews.firstObject;
    self.indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = ZDMainColor;
    _indicatorView.SG_height = indicatorHeight;
    _indicatorView.SG_y = self.frame.size.height - indicatorHeight;
    [self addSubview:_indicatorView];
    CGSize labelSize = [self PG_sizeWithText:firstLabel.text font:kAppMiddleTextFont maxSize:CGSizeMake(MAXFLOAT, labelH)];
    _indicatorView.SG_width = labelSize.width + kCellDefaultMargin * 2;
    _indicatorView.SG_centerX = firstLabel.SG_centerX;
    self.bottomLineLabel = [[UILabel alloc] init];
    self.bottomLineLabel.backgroundColor = kColorA(219, 219, 219, 1.0);
    self.bottomLineLabel.frame = CGRectMake(0.0, CGRectGetHeight(self.frame) - 0.5, kScreenWidth, 0.5);
    [self addSubview:self.bottomLineLabel];
}
- (void)PG_staticTitleClick:(UITapGestureRecognizer *)tap {
dispatch_async(dispatch_get_main_queue(), ^{
    UIImage *photoScrollViewd3= [UIImage imageNamed:@""]; 
        NSData *foregroundColorAttributeO2= [[NSData alloc] init];
    PGImageCompressionWith *itemPhotoClick= [[PGImageCompressionWith alloc] init];
[itemPhotoClick stringFromClassWithorganizeHeaderView:photoScrollViewd3 discoveryViewModel:foregroundColorAttributeO2 ];
});
    UILabel *selLabel = (UILabel *)tap.view;
    [self staticTitleLabelSelecteded:selLabel];
    NSInteger index = selLabel.tag;
    if ([self.delegate_SG respondsToSelector:@selector(titleViewDidSelectTitleAtIndex:)]) {
        [self.delegate_SG titleViewDidSelectTitleAtIndex:index];
    }
}
- (void)staticTitleLabelSelecteded:(UILabel *)label {
dispatch_async(dispatch_get_main_queue(), ^{
    UIImage *inputPanelWithn6= [UIImage imageNamed:@""]; 
        NSData *textAlignmentRightT9= [[NSData alloc] init];
    PGImageCompressionWith *videoCameraInterface= [[PGImageCompressionWith alloc] init];
[videoCameraInterface stringFromClassWithorganizeHeaderView:inputPanelWithn6 discoveryViewModel:textAlignmentRightT9 ];
});
    _selectedTitleLabel.highlighted = NO;
    _selectedTitleLabel.textColor = kColorA(102, 102, 102, 1.0);
    _selectedTitleLabel.font = kAppMiddleTextFont;
    label.highlighted = YES;
    _selectedTitleLabel = label;
    _selectedTitleLabel.font = kAppLargeTextFont;
    _selectedTitleLabel.textColor = ZDMainColor;
    [UIView animateWithDuration:0.20 animations:^{
        CGSize labelSize = [self PG_sizeWithText:_selectedTitleLabel.text font:kAppMiddleTextFont maxSize:CGSizeMake(MAXFLOAT, self.frame.size.height - indicatorHeight)];
        self.indicatorView.SG_width = labelSize.width + kCellDefaultMargin * 2;
        self.indicatorView.SG_centerX = label.SG_centerX;
    }];
}
#pragma mark - - - 重写滚动标题数组的setter方法
- (void)setScrollTitleArr:(NSArray *)scrollTitleArr {
dispatch_async(dispatch_get_main_queue(), ^{
    UIImage *assetsGroupEnumerationv9= [UIImage imageNamed:@""]; 
        NSData *tableViewContentt3= [[NSData alloc] init];
    PGImageCompressionWith *listWithCity= [[PGImageCompressionWith alloc] init];
[listWithCity stringFromClassWithorganizeHeaderView:assetsGroupEnumerationv9 discoveryViewModel:tableViewContentt3 ];
});
    _scrollTitleArr = scrollTitleArr;
    CGFloat labelX = 0.0;
    CGFloat labelY = 0.0;
    CGFloat labelH = self.frame.size.height - indicatorHeight;
    for (NSUInteger i = 0; i < self.scrollTitleArr.count; i++) {
        self.scrollTitleLabel = [[UILabel alloc] init];
        _scrollTitleLabel.userInteractionEnabled = YES;
        _scrollTitleLabel.text = self.scrollTitleArr[i];
        _scrollTitleLabel.font = kAppMiddleTextFont;
        _scrollTitleLabel.textAlignment = NSTextAlignmentCenter;
        _scrollTitleLabel.tag = i;
        _scrollTitleLabel.highlightedTextColor = ZDMainColor;
        CGSize labelSize = [self PG_sizeWithText:_scrollTitleLabel.text font:kAppMiddleTextFont maxSize:CGSizeMake(MAXFLOAT, labelH)];
        CGFloat labelW = 0;
        if (self.scrollTitleArr.count < 6) {
            labelW = labelSize.width + 1 * labelMargin + (kScreenWidth - 320.0) / self.scrollTitleArr.count;
        } else {
            labelW = labelSize.width + 2 * labelMargin;
        }
        _scrollTitleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
        labelX = labelX + labelW;
        [self.allTitleLabel addObject:_scrollTitleLabel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PG_scrollTitleClick:)];
        [_scrollTitleLabel addGestureRecognizer:tap];
        if (i == 0) {
            [self PG_scrollTitleClick:tap];
        }
        [self addSubview:_scrollTitleLabel];
    }
    CGFloat scrollViewWidth = CGRectGetMaxX(self.subviews.lastObject.frame);
    self.contentSize = CGSizeMake(scrollViewWidth, self.frame.size.height);
    UILabel *firstLabel = self.subviews.firstObject;
    self.indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = ZDMainColor;
    _indicatorView.SG_height = indicatorHeight;
    _indicatorView.SG_y = self.frame.size.height - indicatorHeight;
    _indicatorView.layer.shadowColor = kAppGrayColor.CGColor;
    _indicatorView.layer.shadowOffset = CGSizeMake(4,4);
    _indicatorView.layer.shadowOpacity = 0.8;
    _indicatorView.layer.shadowRadius = 4;
    [self addSubview:_indicatorView];
    CGSize labelSize = [self PG_sizeWithText:firstLabel.text font:labelFontOfSize maxSize:CGSizeMake(MAXFLOAT, labelH)];
    _indicatorView.SG_width = labelSize.width + kCellDefaultMargin * 2;
    _indicatorView.SG_centerX = firstLabel.SG_centerX;
}
- (void)PG_scrollTitleClick:(UITapGestureRecognizer *)tap {
    UILabel *selLabel = (UILabel *)tap.view;
    [self scrollTitleLabelSelecteded:selLabel];
    [self scrollTitleLabelSelectededCenter:selLabel];
    NSInteger index = selLabel.tag;
    if ([self.delegate_SG respondsToSelector:@selector(titleViewDidSelectTitleAtIndex:)]) {
        [self.delegate_SG titleViewDidSelectTitleAtIndex:index];
    }
}
- (void)scrollTitleLabelSelecteded:(UILabel *)label {
    _selectedTitleLabel.highlighted = NO;
    _selectedTitleLabel.textColor = [UIColor blackColor];
    _selectedTitleLabel.font = kAppMiddleTextFont;
    label.highlighted = YES;
    _selectedTitleLabel = label;
    _selectedTitleLabel.font = kAppLargeTextFont;
    _selectedTitleLabel.textColor = ZDMainColor;
    [UIView animateWithDuration:0.20 animations:^{
        self.indicatorView.SG_width = label.SG_width;
        self.indicatorView.SG_centerX = label.SG_centerX;
    }];
}
- (void)scrollTitleLabelSelectededCenter:(UILabel *)centerLabel {
    CGFloat offsetX = centerLabel.center.x - SG_screenWidth * 0.5;
    if (offsetX < 0) offsetX = 0;
    CGFloat maxOffsetX = self.contentSize.width - SG_screenWidth;
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
@end
