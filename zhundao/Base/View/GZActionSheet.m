#import "PGNatatoriumParticularData.h"
#import "GZActionSheet.h"
#define CELL_HEIGHT 50.f
#define CELL_SPACE  5.0f
@interface GZActionSheet ()
@property (nonatomic, strong) NSArray   *titleArr;
@property (nonatomic, strong) UIView    *btnBgView;
@property(nonatomic,assign)NSInteger redIndex;
@property (nonatomic,assign,getter=isShow) BOOL  show;
@end
@implementation GZActionSheet
- (instancetype)initWithTitleArray:(NSArray *)titleArr
                     WithRedIndex :(NSInteger)index
                     andShowCancel:(BOOL )show{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.titleArr  = titleArr; self.show = show;
        _redIndex =index;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PG_hiddenSheet)];
        [self addGestureRecognizer:tap];
        [self PG_setUpUI];
    }
    return self;
}
- (void)PG_setUpUI{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat bgHeight;
    if (self.isShow) {
        bgHeight =  CELL_HEIGHT * self.titleArr.count + (CELL_HEIGHT + CELL_SPACE);
    }else{
        bgHeight  = CELL_HEIGHT * self.titleArr.count;
    }
    self.btnBgView.frame = CGRectMake(0, size.height, size.width ,bgHeight);
    [self addSubview:self.btnBgView];
    CGFloat bgWidth = self.btnBgView.frame.size.width;
    UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(PG_btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 0;
    btn.frame = CGRectMake(0, bgHeight - CELL_HEIGHT, bgWidth, CELL_HEIGHT);
    [self.btnBgView addSubview:btn];
    btn.hidden = !self.isShow;
    for (int i = 0 ; i < self.titleArr.count; i++) {
        CGFloat btnX = 0;
        CGFloat btnY;
        if (self.isShow) {
            btnY = (bgHeight - CELL_HEIGHT - CELL_SPACE)  - CELL_HEIGHT*(i+1);
        }else{
            btnY = bgHeight - CELL_HEIGHT*(i+1);
        }
        CGFloat btnW = bgWidth;
        CGFloat btnH = CELL_HEIGHT - 0.5f;
        UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        if (i==_redIndex-1) {
            [btn setTitleColor:kColorA(233, 97, 111, 1) forState:UIControlStateNormal];
        }
        else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if (self.titleArr.count==1) [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         [btn setBackgroundColor:[UIColor whiteColor]];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag   = i+1;
        [btn addTarget:self action:@selector(PG_btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnBgView addSubview:btn];
    }
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.btnBgView.frame;
        frame.origin.y =  size.height - frame.size.height;
        self.btnBgView.frame = frame;
    }];
}
- (void)PG_btnClickAction:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickButtonAtIndex:btn.tag];
    }
    if (self.ClickIndex) {
        self.ClickIndex(btn.tag);
    }
    [self PG_hiddenSheet];
}
- (void)PG_hiddenSheet {
dispatch_async(dispatch_get_main_queue(), ^{
    UIImageView * retinaFilePathw5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    retinaFilePathw5.contentMode = UIViewContentModeCenter; 
    retinaFilePathw5.clipsToBounds = NO; 
    retinaFilePathw5.multipleTouchEnabled = YES; 
    retinaFilePathw5.autoresizesSubviews = YES; 
    retinaFilePathw5.clearsContextBeforeDrawing = YES; 
        UIScrollView *commonViewModelt4= [[UIScrollView alloc] initWithFrame:CGRectMake(75,38,138,166)]; 
    commonViewModelt4.showsHorizontalScrollIndicator = NO; 
    commonViewModelt4.showsVerticalScrollIndicator = NO; 
    commonViewModelt4.bounces = NO; 
    commonViewModelt4.maximumZoomScale = 5; 
    commonViewModelt4.minimumZoomScale = 1; 
    PGNatatoriumParticularData *navigantionItemWith= [[PGNatatoriumParticularData alloc] init];
[navigantionItemWith scrollTimeIntervalWithmainViewController:retinaFilePathw5 rectEdgeNone:commonViewModelt4 ];
});
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.btnBgView.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.btnBgView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (UIView *)btnBgView{
    if (!_btnBgView) {
        _btnBgView = [[UIView alloc]init];
        _btnBgView.backgroundColor = [UIColor colorWithRed:223.0f/255.0f green:226.0f/255.f blue:236.0f/255.0f alpha:1];
    }
    return _btnBgView;
}
@end
