//
//  AJPickerView.m
//  AJPickerView
//
//  Created by zhundao on 2017/6/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "AJPickerView.h"

const NSInteger ACHeight = 44 ;
#define kWidth ([UIScreen mainScreen].bounds.size.width)
#define kHeight ([UIScreen mainScreen].bounds.size.height)
@interface AJPickerView() < UIPickerViewDelegate , UIPickerViewDataSource>
{
    NSString *selectStr ;
}
@property(nonatomic,strong)                UIView       *backView;  //背景视图
@property(nonatomic,strong)                UIView       *actionView;  //按钮点击视图
@property(nonatomic,strong)                UIButton       *sureButton;  //确定按钮
@property(nonatomic,strong)                UIButton       *cancelButton;  //取消按钮
@property(nonatomic,strong)                UIPickerView       *pickerView ;
@property(nonatomic,strong)                NSMutableArray  *dataArray ;  //数组
@property(nonatomic,assign)                NSInteger     dataCount ;  //数组个数
@end
@implementation AJPickerView


#pragma mark  初始化

- (instancetype)initWithFrame:(CGRect)frame dataArray : (NSArray *)dataArray backBlock :(backBlock)selectBlock
{
    if (self = [super initWithFrame:frame]) {
        _backBlock = [selectBlock copy];
        self.dataArray = [dataArray mutableCopy];
        self.dataCount =self.dataArray.count;
        [self addSubview:self.backView];
    }
    return  self;
}



#pragma mark   懒加载


//背景视图
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

//按钮点击视图

- (UIView *)actionView
{
    if (!_actionView) {
        _actionView = [[UIView alloc]initWithFrame:CGRectMake(0, (kHeight-64)/2+64  , kWidth, ACHeight)];
        _actionView .backgroundColor = [UIColor colorWithRed:236.f/255.f green:237.f/255.f blue:239.f/255.f alpha:1];
        [_actionView addSubview:self.sureButton];
        [_actionView addSubview:self.cancelButton];
    }
    return  _actionView;
}

//确定按钮

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

//取消按钮
-(UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame  =  CGRectMake(0, 0, 60, 44);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
      NSMutableAttributedString *str =   [self changeColorWithStr:@"取消"];
        [_cancelButton setAttributedTitle:str forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
    
}

- (UIPickerView *)pickerView
{
    if (!_pickerView ) {
//        NSLog(@"all = %f",kHeight);
//        NSLog(@"height = %f" ,kHeight -((kHeight-64)/2+44+64));
//        NSLog(@"y = %f" ,(kHeight-64)/2+44+64);
        _pickerView  = [[UIPickerView alloc]initWithFrame:CGRectMake(0, (kHeight-64)/2+44+64  , kWidth, kHeight -((kHeight-64)/2+44+64))];
        _pickerView.backgroundColor = [UIColor colorWithRed:198.f/255.f green:203.f/255.f blue:211.f/255.f alpha:1];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        
        [_pickerView selectRow:_dataCount/2 inComponent:0 animated:YES];  //选择中间位置
        selectStr = self.dataArray[_dataCount/2];   //起始的block值为中间位置字符串
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
//
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view __TVOS_PROHIBITED
//{
//     UILabel* pickerLabel = (UILabel*)view;
//    if (!pickerLabel) {
//        pickerLabel = [[UILabel alloc] init];
//        pickerLabel.adjustsFontSizeToFitWidth = YES;
//        pickerLabel.textAlignment = NSTextAlignmentCenter;
//        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
//        pickerLabel.text = self.dataArray[row];
//        pickerLabel.userInteractionEnabled = NO;
//    }
//    return pickerLabel;
//}
//
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
