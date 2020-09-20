//
//  ZDDiscoverShowView.m
//  zhundao
//
//  Created by zhundao on 2017/9/14.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDDiscoverShowView.h"
#import "UIImage+LXDCreateBarcode.h"
#import "BigSizeButton.h"
#import "ZDDiscoverColorView.h"
#import "ZDDiscoverInviteTextView.h"
#import "ZDDiscoverShowTextView.h"
#import "ZDDiscoverPopupMenu.h"
#import "ZDDiscoverVcodeImageView.h"
#import "ZDDiscoverShowViewModel.h"
#import "UIImage+ImageEffects.h"
#import "UIAlertController+creat.h"
/*! 按钮的宽度 */
static const CGFloat buttonWidth = 40;
/*! 按钮的高度 */
static const CGFloat bottomViewHeight= 44;
/*! 弹出标题 */
#define ICONS @[@"二维码",@"二维码",@"邀请地址", @"邀请时间",@"邀请活动",@"邀请姓名",@"邀请自定义文本"]
/*! 图片 */
#define TITLES  @[@"签到二维码",@"报名二维码",@"活动地址",@"活动时间",@"活动名称",@"嘉宾姓名",@"自定义文本"]

@interface ZDDiscoverShowView()<inviteTextDelegate,YBPopupMenuDelegate>{
    UIAlertController *alert;
}
/*! ViewModel */
@property(nonatomic,strong)ZDDiscoverShowViewModel *viewModel;
/*! 底部背景图 */
@property(nonatomic,strong)UIImageView *imageView;
/*! 背景图片 */
@property(nonatomic,strong)UIImage *bottomImage;
/*! 开启编辑后的模糊图 */
@property(nonatomic,strong)UIImageView *maskImageView;
/*! 下面的view */
@property(nonatomic,strong)UIView *topView;
/*! 记录有几个textf */
@property(nonatomic,assign)NSInteger count ;
/*! 记录每个textview的缩放 */
@property(nonatomic,strong)NSMutableDictionary *scaleDic;
/*! 记录每个textview的旋转角度 */
@property(nonatomic,strong)NSMutableDictionary *rotationDic;
/*! 当前选择的颜色 */
@property(nonatomic,strong)UIColor  *currentColor;
/*! 编辑界面 */
@property(nonatomic,strong)ZDDiscoverInviteTextView *editView;
/*! 当前编辑的textview的tag */
@property(nonatomic,assign)NSInteger currentTag;
/*! 当前字体大小 */
@property(nonatomic,assign)float currentFont;
/*! 固定项的配置 */
@property(nonatomic,strong)NSMutableArray *fixArray;
/*! 自定义的文本项的配置 */
@property(nonatomic,strong)NSMutableArray *customArray;
/*! 邀请函的名称 用来查看是否重新编辑邀请函状态 */
@property(nonatomic,copy)NSString  *name;

@end

@implementation ZDDiscoverShowView

- (instancetype)initWithImage:(UIImage *)image1 name:(NSString *)name{
    if (self = [super init]) {
        _count =0;
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self addSubview:self.imageView];
        _bottomImage = image1;
        _imageView.image = image1;
        [self setupbottomUI];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
        [self addGestureRecognizer:tap];
        _currentColor = kColorA(249, 249, 249, 1);
        _currentFont = 17.0;
        if(name) {
            [self createUIWithName:name];
            _name = name;
        }
        [[UIApplication sharedApplication]setStatusBarHidden:YES];
    }
    return self;
}

#pragma mark--- 编辑状态创建UI

- (void)createUIWithName:(NSString *)name{
        NSArray *fixArray =  [self.viewModel writeFixArray:name];
        for (NSDictionary *dic in fixArray) {
            if (dic.count==2) {
                ZDDiscoverVcodeImageView *imgView =[[ZDDiscoverVcodeImageView alloc]init];
                [self addSubview:imgView];
                imgView.frame = CGRectFromString(dic[@"rect"]);
                imgView.tag = [dic[@"tag"] integerValue];
                UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
                [imgView addGestureRecognizer:pan];
            }else{
                [self createTextWithDic:dic];
            }
        }
        NSArray *customArray = [self.viewModel writeCustomArray:name];
        for (int i= 0; i<customArray.count; i++) {
            NSDictionary *dic = [customArray objectAtIndex:i];
            [self createTextWithDic:dic];
            if (i==customArray.count-1) {
                _count = [dic[@"tag"] integerValue];
            }
        }
}

- (void)createTextWithDic :(NSDictionary *)dic{
    ZDDiscoverShowTextView *textView = [[ZDDiscoverShowTextView alloc]init];
    textView.tag = [dic[@"tag"] integerValue];
    [self confing:textView];
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


- (ZDDiscoverInviteTextView *)editView{
    if (!_editView) {
        _editView   = [[ZDDiscoverInviteTextView alloc]initWithColor:_currentColor fontsize:_currentFont];
        _editView.inviteTextDelegate = self;
    }
    return _editView;
}

- (ZDDiscoverShowViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[ZDDiscoverShowViewModel alloc]init];
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
/*! 创建底部UI */
- (void)setupbottomUI{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, bottomViewHeight)];
    _topView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.topView];
    BigSizeButton *button = [BigSizeButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((kScreenWidth-buttonWidth)/2,0, buttonWidth, buttonWidth);
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:0.95 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addfix:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:button];
    
    /*! 取消  确定按钮 */
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
    [rightButton addTarget:self action:@selector(sureEdit) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font = KHeitiSCMedium(17);
    [_topView addSubview:rightButton];
    
}

#pragma mark ----返回界面 
/*! 取消编辑 */
- (void)cancelEdit{
    
    [self fadeOut];
    _addInviteBlock(@"");
}

- (void)sureEdit{
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
                    [textField addTarget:weakSelf action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
- (void)textFieldDidChange:(UITextField *)textField{
    if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        alert.actions.firstObject.enabled = NO;
    }else{
        alert.actions.firstObject.enabled = YES;
    }
}
#pragma mark 弹出添加二维码 地点 时间等 
- (void)addfix:(UIButton *)button{
    [ZDDiscoverPopupMenu showRelyOnView:button titles:TITLES icons:ICONS menuWidth:140 delegate:self];
}
#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ZDDiscoverPopupMenu:(ZDDiscoverPopupMenu *)ZDDiscoverPopupMenu cell:(UITableViewCell *)cell
{
    NSLog(@"点击了 %@ 选项",TITLES[index]);
    if (![self createSecondView:index]) {
        return;
    }
    switch (index) {
        case 0:
        case 1:
        {
            ZDDiscoverVcodeImageView *imgView =[[ZDDiscoverVcodeImageView alloc]init];
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
            ZDDiscoverShowTextView *textView = [[ZDDiscoverShowTextView alloc]init];
            textView.tag = 1000+index;
            _currentTag = textView.tag;
            [self confing:textView];
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
            [self editViewIn];
        }
            break;
    }
}

- (BOOL)createSecondView :(NSInteger)index{
    /*! 自定义文本可以创建多个 */
    if (index==6) {
        return YES;
    }
    /*! 其他的只能创建一个 */
    else{
        if ([self viewWithTag:index+1000] !=nil) {
            ZDMaskLabel *label = [[ZDMaskLabel alloc]initWithTitle:[NSString stringWithFormat:@"只能存在一个%@",TITLES[index]]];
            [label labelAnimationWithViewlong:self];
            return NO;
        }else{
            return YES;
        }
    }
}

#pragma mark 添加文本框
/*! 添加输入框 */
- (void)addTextF{
    _count+=1;
    ZDDiscoverShowTextView *textView = [[ZDDiscoverShowTextView alloc]init];
    textView.tag = _count+100;
    _currentTag = textView.tag;
    [self confing:textView];
    [self setUpEdit];
}

- (void)confing:(ZDDiscoverShowTextView *)textView{
    [self.scaleDic setObject:@(1) forKey:@(textView.tag)];
    [self addSubview:textView];
    [self addGes:textView];

}

/*! 添加编辑框 */
- (void)setUpEdit{
    [self addSubview:self.maskImageView];
    [self addSubview:self.editView];
    [_editView becomeFirstResponder];
    [self editViewIn];
}
/*! 编辑框弹出动画 */
-(void)editViewIn{
    [self hiddenView];
    _editView.frame= CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    [UIView animateWithDuration:0.25 animations:^{
        _editView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
}

#pragma mark --- inviteTextDelegate

- (void)cancelAction{
    [self ZDDiscoverShowView];
    [self removeEditView];
    UITextView *textView = [self viewWithTag:_currentTag];
    if (textView.tag>=1000) {
        [textView removeFromSuperview];
        textView = nil;
    }else{
        if ([self removeTextView:textView]) {
            return;
        }
    }
}

- (void)sureBtnClick :(NSString *)content color:(UIColor *)selectColor fontsize:(float)fontsize{
    [self ZDDiscoverShowView];
    [self removeEditView];
    ZDDiscoverShowTextView *textView = [self viewWithTag:_currentTag];
    textView.text = content;
    if ([self removeTextView:textView]) {
        return;
    }
    textView.textColor = selectColor;
    textView.font = [UIFont systemFontOfSize:fontsize];
    _currentColor = selectColor;
    _currentFont = fontsize;
    [self.viewModel setTextViewFrame:textView];
}

- (void)removeEditView{
    [_editView resignFirstResponder];
    [_editView removeFromSuperview];
    [_maskImageView removeFromSuperview];
    _editView = nil;
}

- (BOOL)removeTextView :(UITextView *)textView{
    if ([textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        [textView removeFromSuperview];
        textView = nil;
        return YES;
    }
    return NO;
}
/*! 隐藏界面控件 */
- (void)hiddenView{
    _topView.alpha=0;
}
/*! 显示界面控件 */
- (void)ZDDiscoverShowView{
    _topView.alpha = 1 ;
}
- (void)addEditBackgroundView{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.frame];
    imgView.image = [[UIImage imageNamed:@"专属邀请函1.jpg"]applyTintEffectWithColor: kColorA(0, 0, 0, 0.3)] ;
    [self addSubview:imgView];
}
#pragma mark ---添加手势

- (void)addGes :(UITextView *)textView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [textView addGestureRecognizer:tap];
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
//    UIRotationGestureRecognizer *rota = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
     UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [textView addGestureRecognizer:panGes];
//    [textView addGestureRecognizer:rota];
    [textView addGestureRecognizer:pinch];
}

#pragma mark 手势响应


- (void)tap:(UITapGestureRecognizer *)gestureRecognizer{
    
    UITextView *textView = (UITextView *)gestureRecognizer.view;
    self.currentTag = textView.tag;
    _currentFont = textView.font.pointSize;
    [self addSubview:self.maskImageView];
    [self addSubview:self.editView];
    /*! 如果textView则传给编辑框 */
    _editView.content = textView.text;
    /*! 传当前textView的编辑颜色 */
    _editView.currentColor = textView.textColor;
    /*! 判断是否是固定项 */
    if (textView.tag>1000) {
        _editView.isFix = YES;
    }
    /*! 弹出编辑框 */
    [_editView becomeFirstResponder];
    /*! 动画 */
    [self editViewIn];
}

/*! 拖拽平移 */
- (void)pan:(UIPanGestureRecognizer *)gestureRecognizer{
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.25 animations:^{
            [self hiddenView];
        }];
        if ([gestureRecognizer.view isKindOfClass:[UITextView class]]) {
            gestureRecognizer.view.layer.borderColor = [UIColor whiteColor].CGColor;
            gestureRecognizer.view.layer.borderWidth = 1;
        }
    }if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self ZDDiscoverShowView];
        if ([gestureRecognizer.view isKindOfClass:[UITextView class]]) {
            gestureRecognizer.view.layer.borderWidth = 0;
        }
    }
    /*! 获取拖拽的偏移值 */
    CGPoint point = [gestureRecognizer translationInView:self];
    /*! 改变textview中心点  只允许上下滑动*/
    gestureRecognizer.view.center = CGPointMake(gestureRecognizer.view.center.x+point.x, gestureRecognizer.view.center.y+point.y);
//    textView.center = CGPointMake(textView.center.x, textView.center.y+point.y);
    /*! 手势增量置为零*/
    [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self];
}

/*! 旋转 */
//- (void)rotation:(UIRotationGestureRecognizer *)gestureRecognizer{
//     UITextView *textView = (UITextView *)gestureRecognizer.view;
//    [self.rotationDic setObject:@(gestureRecognizer.rotation+[[self.rotationDic objectForKey:@(textView.tag)] floatValue]) forKey:@(textView.tag)];
//    //通过transform 进行旋转变换
//    NSLog(@"gestureRecognizer = %f",gestureRecognizer.rotation);
//    NSLog(@"rotation = %@",[self.rotationDic objectForKey:@(textView.tag)]);
//    textView.transform = CGAffineTransformRotate(textView.transform, gestureRecognizer.rotation);
//    //将旋转角度 置为 0
//    gestureRecognizer.rotation = 0;
//}

/*! 缩放 捏合手势*/
- (void)pinch:(UIPinchGestureRecognizer *)gestureRecognizer{
    UITextView *textView = (UITextView *)gestureRecognizer.view;
    [self.scaleDic setObject:@(gestureRecognizer.scale*[[self.scaleDic objectForKey:@(textView.tag)] floatValue]) forKey:@(textView.tag)];
    /*! 开始缩放 */
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
    
    //设置比例 为 1 。下次在这个scale基础上改变
    gestureRecognizer.scale = 1;
    
}
/*! 点击手势 */
- (void)tapView {
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
