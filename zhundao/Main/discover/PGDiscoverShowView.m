#import "PGFirendsViewModel.h"
#import "PGDiscoverShowView.h"
#import "UIImage+LXDCreateBarcode.h"
#import "BigSizeButton.h"
#import "PGDiscoverColorView.h"
#import "PGDiscoverInviteTextView.h"
#import "PGDiscoverShowTextView.h"
#import "PGDiscoverPopupMenu.h"
#import "PGDiscoverVcodeImageView.h"
#import "PGDiscoverShowViewModel.h"
#import "UIImage+ImageEffects.h"
#import "UIAlertController+creat.h"
static const CGFloat buttonWidth = 40;
static const CGFloat bottomViewHeight= 44;
#define ICONS @[@"二维码",@"二维码",@"邀请地址", @"邀请时间",@"邀请活动",@"邀请姓名",@"邀请自定义文本"]
#define TITLES  @[@"签到二维码",@"报名二维码",@"活动地址",@"活动时间",@"活动名称",@"嘉宾姓名",@"自定义文本"]
@interface PGDiscoverShowView()<inviteTextDelegate,YBPopupMenuDelegate>{
    UIAlertController *alert;
}
@property(nonatomic,strong)PGDiscoverShowViewModel *viewModel;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImage *bottomImage;
@property(nonatomic,strong)UIImageView *maskImageView;
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,assign)NSInteger count ;
@property(nonatomic,strong)NSMutableDictionary *scaleDic;
@property(nonatomic,strong)NSMutableDictionary *rotationDic;
@property(nonatomic,strong)UIColor  *currentColor;
@property(nonatomic,strong)PGDiscoverInviteTextView *editView;
@property(nonatomic,assign)NSInteger currentTag;
@property(nonatomic,assign)float currentFont;
@property(nonatomic,strong)NSMutableArray *fixArray;
@property(nonatomic,strong)NSMutableArray *customArray;
@property(nonatomic,copy)NSString  *name;
@end
@implementation PGDiscoverShowView
- (instancetype)initWithImage:(UIImage *)image1 name:(NSString *)name{
    if (self = [super init]) {
        _count =0;
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self addSubview:self.imageView];
        _bottomImage = image1;
        _imageView.image = image1;
        [self PG_setupbottomUI];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PG_tapView)];
        [self addGestureRecognizer:tap];
        _currentColor = kColorA(249, 249, 249, 1);
        _currentFont = 17.0;
        if(name) {
            [self PG_createUIWithName:name];
            _name = name;
        }
        [[UIApplication sharedApplication]setStatusBarHidden:YES];
    }
    return self;
}
#pragma mark--- 编辑状态创建UI
- (void)PG_createUIWithName:(NSString *)name{
        NSArray *fixArray =  [self.viewModel writeFixArray:name];
        for (NSDictionary *dic in fixArray) {
            if (dic.count==2) {
                PGDiscoverVcodeImageView *imgView =[[PGDiscoverVcodeImageView alloc]init];
                [self addSubview:imgView];
                imgView.frame = CGRectFromString(dic[@"rect"]);
                imgView.tag = [dic[@"tag"] integerValue];
                UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
                [imgView addGestureRecognizer:pan];
            }else{
                [self PG_createTextWithDic:dic];
            }
        }
        NSArray *customArray = [self.viewModel writeCustomArray:name];
        for (int i= 0; i<customArray.count; i++) {
            NSDictionary *dic = [customArray objectAtIndex:i];
            [self PG_createTextWithDic:dic];
            if (i==customArray.count-1) {
                _count = [dic[@"tag"] integerValue];
            }
        }
}
- (void)PG_createTextWithDic :(NSDictionary *)dic{
    PGDiscoverShowTextView *textView = [[PGDiscoverShowTextView alloc]init];
    textView.tag = [dic[@"tag"] integerValue];
    [self PG_confing:textView];
    textView.textColor = kColorA([dic[@"R"]floatValue]*256, [dic[@"G"]floatValue]*256, [dic[@"B"]floatValue]*256, 1);
    textView.font = [UIFont systemFontOfSize:[dic[@"fontsize"] floatValue]];
    textView.text = dic[@"text"];
    textView.frame = CGRectFromString(dic[@"rect"]);
}
#pragma mark --- 懒加载
- (UIImageView *)imageView{
    if (!_imageView ) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height)];
    }
    return _imageView;
}
- (UIImageView *)maskImageView{
    if (!_maskImageView ) {
        _maskImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height)];
        _maskImageView.image = [_bottomImage applyTintEffectWithColor:kColorA(60, 60, 60, 0.3)];
    }
    return _maskImageView;
}
- (NSMutableDictionary *)scaleDic{
    if (!_scaleDic) {
        _scaleDic = [NSMutableDictionary dictionary];
    }
    return _scaleDic;
}
- (NSMutableDictionary *)rotationDic{
    if (!_rotationDic) {
        _rotationDic    = [NSMutableDictionary dictionary];
    }
    return _rotationDic;
}
- (PGDiscoverInviteTextView *)editView{
    if (!_editView) {
        _editView   = [[PGDiscoverInviteTextView alloc]initWithColor:_currentColor fontsize:_currentFont];
        _editView.inviteTextDelegate = self;
    }
    return _editView;
}
- (PGDiscoverShowViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[PGDiscoverShowViewModel alloc]init];
    }
    return  _viewModel;
}
- (NSMutableArray *)fixArray{
    if (!_fixArray) {
        _fixArray = [NSMutableArray array];
    }
    return _fixArray;
}
-(NSMutableArray *)customArray{
    if (!_customArray) {
        _customArray = [NSMutableArray array];
    }
    return _customArray;
}
#pragma  mark --- UI创建
- (void)PG_setupbottomUI{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, bottomViewHeight)];
    _topView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.topView];
    BigSizeButton *button = [BigSizeButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((kScreenWidth-buttonWidth)/2,0, buttonWidth, buttonWidth);
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:0.95 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(PG_addfix:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:button];
   BigSizeButton *leftButton = [BigSizeButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10, 0, 40, 40);
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithWhite:0.95 alpha:1] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(cancelEdit) forControlEvents:UIControlEventTouchUpInside];
    leftButton.titleLabel.font = KHeitiSCMedium(17);
    [_topView addSubview:leftButton];
   BigSizeButton *rightButton = [BigSizeButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(kScreenWidth-50, 0, 40, 40);
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [rightButton setTitleColor:ZDMainColor forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(PG_sureEdit) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font = KHeitiSCMedium(17);
    [_topView addSubview:rightButton];
}
#pragma mark ----返回界面 
- (void)cancelEdit{
    [self fadeOut];
    _addInviteBlock(@"");
}
- (void)PG_sureEdit{
    dispatch_queue_t asynchronousQueue = dispatch_queue_create("1", NULL);
    dispatch_async(asynchronousQueue, ^{
        if (_count!=0) {
            @autoreleasepool {
                for (int i = 1; i<=_count; i++) {
                    id view = [self viewWithTag:i+100];
                    if ([view isKindOfClass:[UITextView class]]) {
                        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                        [self.viewModel saveData:dic textView:view];
                        [self.customArray addObject:dic];
                    }
                }
            }
            }
        @autoreleasepool {
            for (int i = 0; i<ICONS.count; i++) {
                id view = [self viewWithTag:i+1000];
                if ([view isKindOfClass:[UITextView class]]) {
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [self.viewModel saveData:dic textView:view];
                    [self.fixArray addObject:dic];
                }if ([view isKindOfClass:[UIImageView class]]) {
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [self.viewModel saveImageData:dic imageView:view];
                    [self.fixArray addObject:dic];
                }
            }
        }
        NSData *Data = UIImageJPEGRepresentation(_bottomImage, 1);
        NSString *strimage64 = [Data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self fadeOut];
            if (_name) {
                 [self.viewModel savaToPlist:_fixArray customArray:_customArray str:strimage64 name:_name];
                _addInviteBlock(@"");
            }else{
                alert = [UIAlertController alertControllerWithTitle:nil message:@"请给邀请函取名" preferredStyle:UIAlertControllerStyleAlert];
                __weak typeof(alert) weakAlert = alert;
                __weak typeof(self) weakSelf = self;
                [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.placeholder = @"请输入名称";
                    [textField addTarget:weakSelf action:@selector(PG_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                }];
                [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.viewModel savaToPlist:_fixArray customArray:_customArray str:strimage64 name:weakAlert.textFields.firstObject.text];
                    _addInviteBlock(weakAlert.textFields.firstObject.text);
                }]];
                alert.actions.firstObject.enabled = NO;
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            }
    });
    });
}
- (void)PG_textFieldDidChange:(UITextField *)textField{
    if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        alert.actions.firstObject.enabled = NO;
    }else{
        alert.actions.firstObject.enabled = YES;
    }
}
#pragma mark 弹出添加二维码 地点 时间等 
- (void)PG_addfix:(UIButton *)button{
    [PGDiscoverPopupMenu showRelyOnView:button titles:TITLES icons:ICONS menuWidth:140 delegate:self];
}
#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index PGDiscoverPopupMenu:(PGDiscoverPopupMenu *)PGDiscoverPopupMenu cell:(UITableViewCell *)cell
{
    NSLog(@"点击了 %@ 选项",TITLES[index]);
    if (![self PG_createSecondView:index]) {
        return;
    }
    switch (index) {
        case 0:
        case 1:
        {
            PGDiscoverVcodeImageView *imgView =[[PGDiscoverVcodeImageView alloc]init];
            [self addSubview:imgView];
            imgView.tag = index+1000;
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
            [imgView addGestureRecognizer:pan];
        }
            break;
        case 6:
        {
            [self addTextF];
        }
            break;
        default:{
            PGDiscoverShowTextView *textView = [[PGDiscoverShowTextView alloc]init];
            textView.tag = 1000+index;
            _currentTag = textView.tag;
            [self PG_confing:textView];
            if (index==2) {
                textView.text = @"活动地址: 杭州市临安区科技大楼603(变量)";
            }else if (index==3){
                textView.text = @"活动时间: 2017-09-22(变量)";
            }else if (index==4){
                textView.text = @"阿里巴巴诸神之战全球创客大赛(变量)";
            }else{
                textView.text = @"周先生(变量)";
            }
            [self addSubview:self.maskImageView];
            [self addSubview:self.editView];
            _editView.isFix = YES;
            _editView.text = textView.text;
            [_editView becomeFirstResponder];
            [self PG_editViewIn];
        }
            break;
    }
}
- (BOOL)PG_createSecondView :(NSInteger)index{
    if (index==6) {
        return YES;
    }
    else{
        if ([self viewWithTag:index+1000] !=nil) {
            PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:[NSString stringWithFormat:@"只能存在一个%@",TITLES[index]]];
            [label labelAnimationWithViewlong:self];
            return NO;
        }else{
            return YES;
        }
    }
}
#pragma mark 添加文本框
- (void)addTextF{
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle backIndicatorTransitionz6 = UITableViewStylePlain; 
        CGPoint withRankMedalE6 = CGPointZero;
    PGFirendsViewModel *downloadChapterModel= [[PGFirendsViewModel alloc] init];
[downloadChapterModel vertexAttribPointerWithrouteChangeListener:backIndicatorTransitionz6 showFullButton:withRankMedalE6 ];
});
    _count+=1;
    PGDiscoverShowTextView *textView = [[PGDiscoverShowTextView alloc]init];
    textView.tag = _count+100;
    _currentTag = textView.tag;
    [self PG_confing:textView];
    [self PG_setUpEdit];
}
- (void)PG_confing:(PGDiscoverShowTextView *)textView{
    [self.scaleDic setObject:@(1) forKey:@(textView.tag)];
    [self addSubview:textView];
    [self addGes:textView];
}
- (void)PG_setUpEdit{
    [self addSubview:self.maskImageView];
    [self addSubview:self.editView];
    [_editView becomeFirstResponder];
    [self PG_editViewIn];
}
-(void)PG_editViewIn{
    [self PG_hiddenView];
    _editView.frame= CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    [UIView animateWithDuration:0.25 animations:^{
        _editView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
}
#pragma mark --- inviteTextDelegate
- (void)cancelAction{
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle userModelFromt7 = UITableViewStylePlain; 
        CGPoint showingPhotoViewY5 = CGPointZero;
    PGFirendsViewModel *integralRecordTable= [[PGFirendsViewModel alloc] init];
[integralRecordTable vertexAttribPointerWithrouteChangeListener:userModelFromt7 showFullButton:showingPhotoViewY5 ];
});
    [self PG_PGDiscoverShowView];
    [self PG_removeEditView];
    UITextView *textView = [self viewWithTag:_currentTag];
    if (textView.tag>=1000) {
        [textView removeFromSuperview];
        textView = nil;
    }else{
        if ([self PG_removeTextView:textView]) {
            return;
        }
    }
}
- (void)sureBtnClick :(NSString *)content color:(UIColor *)selectColor fontsize:(float)fontsize{
    [self PG_PGDiscoverShowView];
    [self PG_removeEditView];
    PGDiscoverShowTextView *textView = [self viewWithTag:_currentTag];
    textView.text = content;
    if ([self PG_removeTextView:textView]) {
        return;
    }
    textView.textColor = selectColor;
    textView.font = [UIFont systemFontOfSize:fontsize];
    _currentColor = selectColor;
    _currentFont = fontsize;
    [self.viewModel setTextViewFrame:textView];
}
- (void)PG_removeEditView{
    [_editView resignFirstResponder];
    [_editView removeFromSuperview];
    [_maskImageView removeFromSuperview];
    _editView = nil;
}
- (BOOL)PG_removeTextView :(UITextView *)textView{
    if ([textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        [textView removeFromSuperview];
        textView = nil;
        return YES;
    }
    return NO;
}
- (void)PG_hiddenView{
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle groupPurchaseModeld0 = UITableViewStylePlain; 
        CGPoint timesFromSliderZ6 = CGPointZero;
    PGFirendsViewModel *withRankMedal= [[PGFirendsViewModel alloc] init];
[withRankMedal vertexAttribPointerWithrouteChangeListener:groupPurchaseModeld0 showFullButton:timesFromSliderZ6 ];
});
    _topView.alpha=0;
}
- (void)PG_PGDiscoverShowView{
    _topView.alpha = 1 ;
}
- (void)PG_addEditBackgroundView{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.frame];
    imgView.image = [[UIImage imageNamed:@"img_public_own_invite"]applyTintEffectWithColor: kColorA(0, 0, 0, 0.3)] ;
    [self addSubview:imgView];
}
#pragma mark ---添加手势
- (void)addGes :(UITextView *)textView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PG_tap:)];
    [textView addGestureRecognizer:tap];
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
     UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(PG_pinch:)];
    [textView addGestureRecognizer:panGes];
    [textView addGestureRecognizer:pinch];
}
#pragma mark 手势响应
- (void)PG_tap:(UITapGestureRecognizer *)gestureRecognizer{
    UITextView *textView = (UITextView *)gestureRecognizer.view;
    self.currentTag = textView.tag;
    _currentFont = textView.font.pointSize;
    [self addSubview:self.maskImageView];
    [self addSubview:self.editView];
    _editView.content = textView.text;
    _editView.currentColor = textView.textColor;
    if (textView.tag>1000) {
        _editView.isFix = YES;
    }
    [_editView becomeFirstResponder];
    [self PG_editViewIn];
}
- (void)pan:(UIPanGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.25 animations:^{
            [self PG_hiddenView];
        }];
        if ([gestureRecognizer.view isKindOfClass:[UITextView class]]) {
            gestureRecognizer.view.layer.borderColor = [UIColor whiteColor].CGColor;
            gestureRecognizer.view.layer.borderWidth = 1;
        }
    }if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self PG_PGDiscoverShowView];
        if ([gestureRecognizer.view isKindOfClass:[UITextView class]]) {
            gestureRecognizer.view.layer.borderWidth = 0;
        }
    }
    CGPoint point = [gestureRecognizer translationInView:self];
    gestureRecognizer.view.center = CGPointMake(gestureRecognizer.view.center.x+point.x, gestureRecognizer.view.center.y+point.y);
    [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self];
}
- (void)PG_pinch:(UIPinchGestureRecognizer *)gestureRecognizer{
    UITextView *textView = (UITextView *)gestureRecognizer.view;
    [self.scaleDic setObject:@(gestureRecognizer.scale*[[self.scaleDic objectForKey:@(textView.tag)] floatValue]) forKey:@(textView.tag)];
    CGFloat scale = [[self.scaleDic objectForKey:@(textView.tag)] floatValue];
    textView.center = CGPointMake(textView.center.x, textView.center.y);
    if (gestureRecognizer.state ==UIGestureRecognizerStateBegan) {
        gestureRecognizer.view.layer.borderColor = [UIColor whiteColor].CGColor;
        gestureRecognizer.view.layer.borderWidth = 1;
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        textView.font = [UIFont systemFontOfSize:17+(scale-1)*20];
        CGSize size ;
        size = [textView.text boundingRectWithSize:CGSizeMake(kScreenWidth-40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : textView.font } context:nil].size;
        textView.bounds = CGRectMake(0, 0,size.width+20, size.height+20);
    }
    if (gestureRecognizer.state==UIGestureRecognizerStateEnded) {
        gestureRecognizer.view.layer.borderWidth = 0;
    }
    gestureRecognizer.scale = 1;
}
- (void)PG_tapView {
    [self becomeFirstResponder];
}
#pragma mark ---other进出动画
- (void)fadeOut{
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)fadeIn{
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformScale(self.transform, 100, 100);
    }];    
}
@end
