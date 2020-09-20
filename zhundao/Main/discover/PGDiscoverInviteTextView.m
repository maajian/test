//
//  PGDiscoverInviteTextView.m
//  zhundao
//
//  Created by zhundao on 2017/9/22.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGDiscoverInviteTextView.h"
#import "PGDiscoverColorView.h"
#import "PGDiscoverFontChooseView.h"
@interface PGDiscoverInviteTextView()<UITextViewDelegate,colorDelegate,fontsizeDelegate>{
    float keyBoardHeight;
}
/*! 工具栏 */
@property(nonatomic,strong)UIView *toolView;
/*! 颜色选择 */
@property(nonatomic,strong)PGDiscoverColorView *colorView;
/*! 字体选择视图 */
@property(nonatomic,strong)PGDiscoverFontChooseView *fontChooseView;
/*! 判断是否是完成编辑 */
@property(nonatomic,assign)BOOL isSure;
/*! 固定项的字符串 */
@property(nonatomic,copy)NSString *fixStr;

@end

@implementation PGDiscoverInviteTextView

- (instancetype)initWithColor:(UIColor *)color fontsize:(float)fontsize{
    if (self = [super init]) {
        _currentColor = color;
        _currentFontsize = fontsize;
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        self.delegate =self;
        self.scrollEnabled =NO;
        self.returnKeyType = UIReturnKeyDone;
        self.font = [UIFont systemFontOfSize:fontsize];
        self.textContainerInset = UIEdgeInsetsMake(30, 10, 0, 10);
        [self addNotificationCenter];
        [self setUpUI];
    }
    return self;
}
/*! 添加键盘监听 */
- (void)addNotificationCenter{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark ---- 输入框事件
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (_content) {
        self.text = _content;
    }if (_isFix) {
        _fixStr = textView.text;
    }
    textView.textColor = _currentColor;
}
///*! 文字往左10 宽度加20 */
//- (void)textViewDidChange:(UITextView *)textView{
//    CGSize size = [textView.text boundingRectWithSize:CGSizeMake(kScreenWidth-60, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : textView.font} context:nil].size;
//    textView.frame = CGRectMake((kScreenWidth -size.width)/2-10, kScreenHeight/2-100, size.width+20, size.height+20);
//}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>60) {
        textView.text = [textView.text substringToIndex:60];
    }
    if (_isFix) {
        textView.text = _fixStr;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [self sureBtnClick];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

- (void)setUpUI{
    //初始化工具栏
    _toolView  = [[UIView alloc]init];
    [self addSubview:_toolView];
    _toolView.backgroundColor = [UIColor clearColor];
    float originX = kScreenWidth/3*2/6;
    UIButton *colorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colorBtn.frame = CGRectMake(originX-12, 7, 25, 25);
    [colorBtn setImage:[UIImage imageNamed:@"专属邀请函颜色"] forState:UIControlStateNormal];
    [colorBtn addTarget:self action:@selector(colorBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:colorBtn];
//    UIButton *fontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    fontBtn.frame = CGRectMake(originX*5-12, 7, 25, 25);
//    [fontBtn setImage:[UIImage imageNamed:@"专属邀请函字体"] forState:UIControlStateNormal];
//    [fontBtn addTarget:self action:@selector(fontstyleBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_toolView addSubview:fontBtn];
    
    UIButton *sizeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sizeBtn.frame = CGRectMake(originX*3-12, 7, 25, 25);
    [sizeBtn setImage:[UIImage imageNamed:@"专属邀请函字体"] forState:UIControlStateNormal];
    [sizeBtn addTarget:self action:@selector(fontsizeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:sizeBtn];
    
    UIButton *canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [canclebtn setTitle:@"取消" forState:UIControlStateNormal];
    canclebtn.frame = CGRectMake(kScreenWidth/3*2 , 0, kScreenWidth/6, 40);
    [canclebtn setTitleColor:kColorA(249, 249, 249, 1) forState:UIControlStateNormal];
    [canclebtn addTarget:self action:@selector(canclebtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    canclebtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_toolView addSubview:canclebtn];
    
    UIButton *surebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [surebtn setTitle:@"完成" forState:UIControlStateNormal];
    surebtn.frame = CGRectMake(kScreenWidth/3*2 +kScreenWidth/6, 0,  kScreenWidth/6, 40);
    [surebtn setTitleColor:kColorA(249, 249, 249, 1) forState:UIControlStateNormal];
    [surebtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    surebtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_toolView addSubview:surebtn];
    [self addSubview:_toolView];
    [self addSubview:self.PGDiscoverColorView];
}


- (PGDiscoverColorView *)PGDiscoverColorView{
    if (!_colorView) {
        _colorView = [[PGDiscoverColorView alloc]initWithColor:_currentColor];
        _colorView.colorDelegate = self;
        _colorView.hidden = YES;
    }
    return _colorView;
}

#pragma mark 当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    
    //键盘弹出时显示工具栏
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyBoardHeight = keyboardRect.size.height;
    [[NSUserDefaults standardUserDefaults]setFloat:keyBoardHeight forKey:@"keyBoardHeight"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [UIView animateWithDuration:0.25 animations:^{
        _colorView.frame = CGRectMake(0, kScreenHeight-keyBoardHeight-106, kScreenWidth, 46);
        _toolView.frame = CGRectMake(0, kScreenHeight-keyBoardHeight-40, kScreenWidth, 40);
    }];
    
}

#pragma mark 当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    //键盘消失时 隐藏工具栏
    [UIView animateWithDuration:0.25 animations:^{
        _toolView.hidden = YES;
        _colorView.hidden = YES;
    }];
}

#pragma mark--- 改变颜色

- (void)colorViewCurrrentColor:(UIColor *)currentColor{
    _currentColor = currentColor;
    self.textColor = _currentColor;
}

- (void)postFontsize:(float)fontsize{
    _currentFontsize = fontsize;
    self.font = [UIFont systemFontOfSize:fontsize];
}

#pragma mark ---工具栏按钮点击
/*! 取消回调 */
- (void)canclebtnBtnClick{
    
    [_inviteTextDelegate cancelAction];
    
}
/*! 颜色选择回调 */
- (void)colorBtnClick{
    _colorView.hidden = !_colorView.hidden;
    if (_fontChooseView) _fontChooseView.hidden= YES;
}

/*! 字体选择回调 */
- (void)fontsizeBtnClick{
    _colorView.hidden = YES;
    if (!_fontChooseView) {
        _fontChooseView = [[PGDiscoverFontChooseView alloc]initWithFrame:CGRectMake(5, CGRectGetMinY(_toolView.frame)-40, kScreenWidth-10, 50) Fontsize:_currentFontsize];
        _fontChooseView.fontsizeDelegate = self;
        [self addSubview:_fontChooseView];
    }else{
        _fontChooseView.hidden = !_fontChooseView.hidden;
    }
    
}
- (void)fontstyleBtnClick{
    
}
/*! 确定编辑完成回调 */
- (void)sureBtnClick{
    if ([self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        [self canclebtnBtnClick];
        return;
    }
    [_inviteTextDelegate sureBtnClick:self.text color:_currentColor fontsize:_currentFontsize];
    [self resignFirstResponder];
    [self removeFromSuperview];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
