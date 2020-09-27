#import "PGArticleCommentView.h"
#import "PGDiscoverInviteTextView.h"
#import "PGDiscoverColorView.h"
#import "PGDiscoverFontChooseView.h"
@interface PGDiscoverInviteTextView()<UITextViewDelegate,colorDelegate,fontsizeDelegate>{
    float keyBoardHeight;
}
@property(nonatomic,strong)UIView *toolView;
@property(nonatomic,strong)PGDiscoverColorView *colorView;
@property(nonatomic,strong)PGDiscoverFontChooseView *fontChooseView;
@property(nonatomic,assign)BOOL isSure;
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
        [self PG_addNotificationCenter];
        [self PG_setUpUI];
    }
    return self;
}
- (void)PG_addNotificationCenter{
dispatch_async(dispatch_get_main_queue(), ^{
    UITextFieldViewMode articleOriginalTablej6 = UITextFieldViewModeAlways; 
        UITableViewStyle cancelLoadingRequestr8 = UITableViewStylePlain; 
    PGArticleCommentView *moviePlayView= [[PGArticleCommentView alloc] init];
[moviePlayView deviceLinkViewWithassetsUsingBlock:articleOriginalTablej6 choicenessVideoView:cancelLoadingRequestr8 ];
});
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
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
- (void)textViewDidChange:(UITextView *)textView{
dispatch_async(dispatch_get_main_queue(), ^{
    UITextFieldViewMode largeTextFontD1 = UITextFieldViewModeAlways; 
        UITableViewStyle beginFromCurrentR8 = UITableViewStylePlain; 
    PGArticleCommentView *wallTableView= [[PGArticleCommentView alloc] init];
[wallTableView deviceLinkViewWithassetsUsingBlock:largeTextFontD1 choicenessVideoView:beginFromCurrentR8 ];
});
    if (textView.text.length>60) {
        textView.text = [textView.text substringToIndex:60];
    }
    if (_isFix) {
        textView.text = _fixStr;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ 
        [self sureBtnClick];
        return NO; 
    }
    return YES;
}
- (void)PG_setUpUI{
    _toolView  = [[UIView alloc]init];
    [self addSubview:_toolView];
    _toolView.backgroundColor = [UIColor clearColor];
    float originX = kScreenWidth/3*2/6;
    UIButton *colorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colorBtn.frame = CGRectMake(originX-12, 7, 25, 25);
    [colorBtn setImage:[UIImage imageNamed:@"img_discover_invite_color"] forState:UIControlStateNormal];
    [colorBtn addTarget:self action:@selector(PG_colorBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:colorBtn];
    UIButton *sizeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sizeBtn.frame = CGRectMake(originX*3-12, 7, 25, 25);
    [sizeBtn setImage:[UIImage imageNamed:@"img_discover_invite_font"] forState:UIControlStateNormal];
    [sizeBtn addTarget:self action:@selector(PG_fontsizeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:sizeBtn];
    UIButton *canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [canclebtn setTitle:@"取消" forState:UIControlStateNormal];
    canclebtn.frame = CGRectMake(kScreenWidth/3*2 , 0, kScreenWidth/6, 40);
    [canclebtn setTitleColor:kColorA(249, 249, 249, 1) forState:UIControlStateNormal];
    [canclebtn addTarget:self action:@selector(PG_canclebtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
    [self addSubview:self.PG_PGDiscoverColorView];
}
- (PGDiscoverColorView *)PG_PGDiscoverColorView{
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
    [UIView animateWithDuration:0.25 animations:^{
        _toolView.hidden = YES;
        _colorView.hidden = YES;
    }];
}
#pragma mark--- 改变颜色
- (void)PG_colorViewCurrrentColor:(UIColor *)currentColor{
    _currentColor = currentColor;
    self.textColor = _currentColor;
}
- (void)PG_postFontsize:(float)fontsize{
    _currentFontsize = fontsize;
    self.font = [UIFont systemFontOfSize:fontsize];
}
#pragma mark ---工具栏按钮点击
- (void)PG_canclebtnBtnClick{
dispatch_async(dispatch_get_main_queue(), ^{
    UITextFieldViewMode collectionTrainModelu2 = UITextFieldViewModeAlways; 
        UITableViewStyle imagePickerConfigB4 = UITableViewStylePlain; 
    PGArticleCommentView *backFromFront= [[PGArticleCommentView alloc] init];
[backFromFront deviceLinkViewWithassetsUsingBlock:collectionTrainModelu2 choicenessVideoView:imagePickerConfigB4 ];
});
    [_inviteTextDelegate cancelAction];
}
- (void)PG_colorBtnClick{
    _colorView.hidden = !_colorView.hidden;
    if (_fontChooseView) _fontChooseView.hidden= YES;
}
- (void)PG_fontsizeBtnClick{
    _colorView.hidden = YES;
    if (!_fontChooseView) {
        _fontChooseView = [[PGDiscoverFontChooseView alloc]initWithFrame:CGRectMake(5, CGRectGetMinY(_toolView.frame)-40, kScreenWidth-10, 50) Fontsize:_currentFontsize];
        _fontChooseView.fontsizeDelegate = self;
        [self addSubview:_fontChooseView];
    }else{
        _fontChooseView.hidden = !_fontChooseView.hidden;
    }
}
- (void)PG_fontstyleBtnClick{
}
- (void)sureBtnClick{
    if ([self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        [self PG_canclebtnBtnClick];
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
