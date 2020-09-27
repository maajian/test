#import "PGAuthImageView.h"
#import "PGPickerView.h"
const NSInteger ACHeight = 44 ;
#define kWidth ([UIScreen mainScreen].bounds.size.width)
#define kHeight ([UIScreen mainScreen].bounds.size.height)
@interface PGPickerView() < UIPickerViewDelegate , UIPickerViewDataSource>
{
    NSString *selectStr ;
}
@property(nonatomic,strong)                UIView       *backView;  
@property(nonatomic,strong)                UIView       *actionView;  
@property(nonatomic,strong)                UIButton       *sureButton;  
@property(nonatomic,strong)                UIButton       *cancelButton;  
@property(nonatomic,strong)                UIPickerView       *pickerView ;
@property(nonatomic,strong)                NSMutableArray  *dataArray ;  
@property(nonatomic,assign)                NSInteger     dataCount ;  
@property(nonatomic,copy)                  NSString     *currentStr;
@end
@implementation PGPickerView
#pragma mark  初始化
- (instancetype)initWithFrame:(CGRect)frame dataArray : (NSArray *)dataArray currentStr :(NSString *)str  backBlock :(backPickerBlock)selectBlock
{
    if (self = [super initWithFrame:frame]) {
        _backBlock = [selectBlock copy];
        self.dataArray = [dataArray mutableCopy];
        self.dataCount =self.dataArray.count;
        self.currentStr = str;
        [self addSubview:self.backView];
    }
    return  self;
}
#pragma mark   懒加载
- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [_backView addSubview:self.actionView];
        [_backView addSubview:self.pickerView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelAction)];
        [_backView addGestureRecognizer:tap];
        [self.pickerView reloadAllComponents];
    }
    return _backView ;
}
- (UIView *)actionView
{
    if (!_actionView) {
        _actionView = [[UIView alloc]initWithFrame:CGRectMake(0, (kHeight-64)/2  , kWidth, ACHeight)];
        _actionView .backgroundColor = ZDBackgroundColor;
        [_actionView addSubview:self.sureButton];
        [_actionView addSubview:self.cancelButton];
    }
    return  _actionView;
}
- (UIButton *)sureButton
{
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.frame = CGRectMake(kWidth-60, 0, 60, 44);
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        NSMutableAttributedString *str =   [self changeColorWithStr:@"确定"];
        [_sureButton setAttributedTitle:str forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}
-(UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame  =  CGRectMake(0, 0, 60, 44);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
      NSMutableAttributedString *str =   [self changeColorWithStr:@"取消"];
        [_cancelButton setAttributedTitle:str forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (UIPickerView *)pickerView
{
    if (!_pickerView ) {
        _pickerView  = [[UIPickerView alloc]initWithFrame:CGRectMake(0, (kHeight-64)/2+44  , kWidth, kHeight -((kHeight-64)/2+44+64))];
        _pickerView.backgroundColor = [UIColor colorWithRed:198.f/255.f green:203.f/255.f blue:211.f/255.f alpha:1];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        if (_currentStr) {
            [_pickerView selectRow:[_dataArray indexOfObject:_currentStr] inComponent:0 animated:YES];
            selectStr = _currentStr;
        }else{
            [_pickerView selectRow:_dataCount/2 inComponent:0 animated:YES];  
            selectStr = self.dataArray[_dataCount/2];   
        }
        _pickerView.showsSelectionIndicator = YES;
    }
    return _pickerView;
}
#pragma mark dataSource 
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
   return  self.dataArray.count;
}
#pragma mark delegate 
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArray[row];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40 ;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED
{
    NSInteger select = [pickerView selectedRowInComponent:0];
    selectStr = self.dataArray[select];
}
#pragma mark 视图显示消失动画
- (void)fadeIn
{
    self.alpha = 0 ;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1 ;
    }];
}
- (void)fadeOut
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark 确定点击事件
- (void) sureAction
{
    [self fadeOut];
    _backBlock(selectStr);
}
- (void)cancelAction
{
    [self fadeOut];
}
#pragma  mark 按钮字体变颜色  可以选择自己的按钮颜色
- (NSMutableAttributedString * )changeColorWithStr :(NSString *) str
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:98.f/255.f green:167.f/255.f blue:245.f/255.f alpha:1] range:NSMakeRange(0, str.length)];
    return attributedString;
}
- (void)dealloc
{
    NSLog(@"没有内存泄漏");
}
@end
