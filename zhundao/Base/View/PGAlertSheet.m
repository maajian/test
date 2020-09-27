#import "PGNameBottomLine.h"
#import "PGAlertSheet.h"
#define  kWidth ([UIScreen mainScreen].bounds.size.width)
#define  kHeight ([UIScreen mainScreen].bounds.size.height)
@interface PGAlertSheet()
{
    BOOL delete ;
    NSInteger  titleHeight;
}
@property(nonatomic,strong)          NSMutableArray *dataArray ; 
@property(nonatomic,copy)           NSString   *title ;   
@property(nonatomic,strong)          UILabel *titleLabel ; 
@property(nonatomic,assign)          NSInteger buttonCount ; 
@property(nonatomic,strong)         UIButton  *cancelButton ; 
@property(nonatomic,strong)        UIView    *backView ; 
@property(nonatomic,strong)        UIView     *titleView ;
@property(nonatomic,strong)        UIView    *sheetView  ;  
@end
@implementation PGAlertSheet
#pragma mark 初始化
const static NSInteger crackHeight = 5 ;
const static NSInteger cellHeight  = 44 ;
+ (void)showWithArray :(NSArray *)dataArray
      title :(NSString *)title
   isDelete :(BOOL)isDelete
         selectBlock :(backBlock)selectBlock {
    PGAlertSheet *sheet = [[PGAlertSheet alloc] initWithFrame:[UIScreen mainScreen].bounds array:dataArray title:title isDelete:isDelete selectBlock:selectBlock];
    [ZD_KeyWindow addSubview:sheet];
    [sheet fadeIn];
}
- (instancetype)initWithFrame:(CGRect)frame
                       array :(NSArray *)dataArray
                       title :(NSString *)title
                    isDelete :(BOOL)isDelete
                 selectBlock :(backBlock)selectBlock
{
    if (self = [super initWithFrame:frame]) {
        self.dataArray = [dataArray mutableCopy];
        _title = [title copy];
        if (_title.length){
            CGSize size = [_title boundingRectWithSize:CGSizeMake(kScreenWidth-40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil].size;
            titleHeight = size.height + 40;
        }
        else titleHeight = 0 ;
        _buttonCount = self.dataArray.count;
        delete = isDelete;
        _backBlock = [selectBlock copy];
        [self addSubview:self.backView];
        [self createButton];
    }
    return self;
}
#pragma mark 懒加载
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kWidth-40, titleHeight)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.text = self.title;
        _titleLabel.numberOfLines = 0 ;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = ZDHeaderTitleColor;
    }
    return _titleLabel;
}
- (UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, titleHeight)];
        _titleView.backgroundColor = [UIColor whiteColor];
    }
    return _titleView;
}
- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame =CGRectMake(0, cellHeight *_buttonCount + crackHeight+titleHeight , kWidth, cellHeight);
        [_cancelButton setBackgroundColor:[UIColor whiteColor]];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (UIView *)backView
{
    if (!_backView ) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelAction)];
        [_backView addGestureRecognizer:tap];
        [_backView addSubview:self.sheetView];
    }
    return _backView;
}
- (UIView *)sheetView
{
    if (!_sheetView) {
        _sheetView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight- cellHeight *(_buttonCount +1) - crackHeight -    titleHeight  , kWidth, cellHeight *(_buttonCount +1) + crackHeight +    titleHeight)];
        _sheetView.backgroundColor = kColorA(225, 225, 231, 1);
        [_sheetView addSubview:self.titleView];
        [_sheetView addSubview:self.titleLabel];
        [_sheetView addSubview:self.cancelButton];
    }
    return  _sheetView;
}
#pragma mark button 创建 
- (void)createButton
{
    for (int i = 0;  i < _buttonCount; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, titleHeight + 0.5 *( i +1) + (cellHeight- 0.5) * i , kWidth, cellHeight - 0.5);
        [button setTitle:self.dataArray[i] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [self.sheetView addSubview: button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = 100 + i ;
        [button addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        if (delete&&i == _buttonCount-1){
            [button setTitleColor:[UIColor colorWithRed:233.f/256.f green:97.f/256.f blue:111.f/256.f alpha:1] forState:UIControlStateNormal];
        }
    }
}
#pragma 点击动画
- (void)fadeIn {
    self.alpha = 0.0    ;
    _sheetView.frame =CGRectMake(0, kHeight-ZD_TopBar_H, kWidth, cellHeight *(_buttonCount +1) + crackHeight +    titleHeight);
     [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
         _sheetView.frame =CGRectMake(0,kHeight- cellHeight *(_buttonCount +1) - crackHeight -    titleHeight , kWidth, cellHeight *(_buttonCount +1) + crackHeight +    titleHeight - ZD_SAFE_BOTTOM_LAYOUT);
         self.alpha = 1.0;
     } completion:nil];
}
- (void)fadeOut {
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark 点击事件 
- (void) sureAction :(UIButton *)sender
{
    NSInteger select = sender.tag - 100 ;
    _backBlock (select);
    [self fadeOut];
}
- (void)cancelAction
{
    [self fadeOut];
}
@end
