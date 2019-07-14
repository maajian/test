//
//  AJAlertSheet.m
//  AJAlertSheet
//
//  Created by zhundao on 2017/6/28.
//  Copyright © 2017年 zhundao. All rights reserved.
//


//208 203 192

//156
#import "AJAlertSheet.h"
#define  kWidth ([UIScreen mainScreen].bounds.size.width)
#define  kHeight ([UIScreen mainScreen].bounds.size.height)
@interface AJAlertSheet()
{
    BOOL delete ;
    NSInteger  titleHeight;
}
@property(nonatomic,strong)          NSMutableArray *dataArray ; //数组
@property(nonatomic,copy)           NSString   *title ;   //标题
@property(nonatomic,strong)          UILabel *titleLabel ; //标题label
@property(nonatomic,assign)          NSInteger buttonCount ; //数组个数
@property(nonatomic,strong)         UIButton  *cancelButton ; //取消按钮
@property(nonatomic,strong)        UIView    *backView ; //全屏幕的视图 进入后视图透明度变化
@property(nonatomic,strong)        UIView    *sheetView  ;  //弹出视图的底部背景视图
@end
@implementation AJAlertSheet

#pragma mark 初始化
const static NSInteger crackHeight = 5 ;
const static NSInteger cellHeight  = 44 ;
- (instancetype)initWithFrame:(CGRect)frame
                       array :(NSArray *)dataArray
                       title :(NSString *)title
                    isDelete :(BOOL)isDelete
                 selectBlock :(backBlock)selectBlock
{
    if (self = [super initWithFrame:frame]) {
        self.dataArray = [dataArray mutableCopy];
        _title = [title copy];
        if (_title) titleHeight = 55;
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
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth, titleHeight)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.text = self.title;
        _titleLabel.textColor = [UIColor colorWithRed:200.f/255.f green:200.f/255.f blue:200.f/255.f alpha:1];
    }
    return _titleLabel;
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
        _backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelAction)];
        [_backView addGestureRecognizer:tap];
        [_backView addSubview:self.sheetView];
    
    }
    return _backView;
}

- (UIView *)sheetView
{
    if (!_sheetView) {
        _sheetView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight- cellHeight *(_buttonCount +1) - crackHeight -    titleHeight, kWidth, cellHeight *(_buttonCount +1) + crackHeight +    titleHeight)];
        _sheetView.backgroundColor = [UIColor colorWithRed:208.f/256.f green:203.f/256.f blue:192.f/256.f alpha:1];
        [_sheetView addSubview:self.titleLabel];
        [_sheetView addSubview:self.cancelButton];
    }
    return  _sheetView;
}

#pragma mark button 创建 

- (void)createButton
{
    for (int i = 0;  i < _buttonCount; i ++) {
        @autoreleasepool {
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
}

#pragma 点击动画 

- (void)fadeIn
{
    self.alpha = 0.0    ;
    _sheetView.frame =CGRectMake(0,kHeight, kWidth, cellHeight *(_buttonCount +1) + crackHeight +    titleHeight);
     [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
         _sheetView.frame =CGRectMake(0,kHeight- cellHeight *(_buttonCount +1) - crackHeight -    titleHeight, kWidth, cellHeight *(_buttonCount +1) + crackHeight +    titleHeight);
         self.alpha = 1.0;
     } completion:nil];
}
- (void)fadeOut
{
    
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
}

- (void)cancelAction
{
    [self fadeOut];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
