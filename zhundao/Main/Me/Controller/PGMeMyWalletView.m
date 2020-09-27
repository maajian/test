#import "PGCircleCropRadius.h"
#import "PGMeMyWalletView.h"
@interface PGMeMyWalletView()
@property(nonatomic,strong)UIImageView *topImageView ;
@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UIView *passWordView;
@property(nonatomic,strong)UIButton *queButton;
@end
@implementation PGMeMyWalletView
- (instancetype)initInView :(UIView *)view
{
    self = [super init];
    if (self) {
        self.backgroundColor = ZDBackgroundColor;
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
        [view addSubview:self];
        [self addSubview:self.topImageView];
        [self addSubview:self.label1];
        [self addSubview:self.moneyLabel];
        [self addSubview:self.withdrawButton];
        [self addSubview:self.backButton];
        [self addSubview:self.passWordView];
        [self addSubview:self.queButton];
        if (![[NSUserDefaults standardUserDefaults]boolForKey:@"Authentication"]) {
            UIButton *authButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [authButton setTitleColor:kColorA(90, 109, 150, 1) forState:UIControlStateNormal];
            [authButton setTitle:@"实名认证" forState:UIControlStateNormal];
            authButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [authButton addTarget:self action:@selector(auth) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:authButton];
            [authButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_passWordView.mas_bottom).offset(0);
                make.centerX.equalTo(_passWordView.mas_centerX);
            }];
        }
    }
    return self;
}
#pragma mark -------- 懒加载
- (UILabel *)label1{
    if (!_label1) {
        _label1 = [MyLabel initWithLabelFrame:CGRectZero Text:@"我的钱包" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:0];
    }
    return _label1;
}
- (UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel =[MyLabel initWithLabelFrame:CGRectZero Text:@"¥0.00" textColor:[UIColor blackColor] font:KHeitiSCMedium(36) textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:0];
    }
    return _moneyLabel;
}
- (UIButton *)withdrawButton{
    if (!_withdrawButton) {
        _withdrawButton = [MyButton initWithButtonFrame:CGRectZero title:@"提现" textcolor:[UIColor whiteColor] Target:self action:@selector(PG_pushToWithDraw) BackgroundColor:ZDMainColor cornerRadius:5 masksToBounds:1];
    }
    return _withdrawButton;
}
- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [MyButton initWithButtonFrame:CGRectZero title:@"返回" textcolor:[UIColor blackColor] Target:self action:@selector(back) BackgroundColor:[UIColor whiteColor] cornerRadius:5 masksToBounds:1];
    }
    return _backButton;
}
- (UIButton *)queButton{
    if (!_queButton) {
        _queButton = [MyButton initWithButtonFrame:CGRectMake(50, kScreenHeight-64-50, kScreenWidth-100, 30) title:@"常见问题" textcolor:kColorA(90, 109, 150, 1) Target:self action:@selector(PG_allQuestion) BackgroundColor:nil cornerRadius:0 masksToBounds:0];
        _queButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _queButton;
}
- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [MyImage initWithImageFrame:CGRectZero imageName:@"com_public_coin" cornerRadius:50 masksToBounds:1];
    }
    return _topImageView;
}
- (UIView *)passWordView{
    if (!_passWordView) {
        float topPad = (kScreenHeight -64 - 280)/2-80;
        _passWordView = [[UIView alloc]initWithFrame:CGRectMake(50, topPad+350, kScreenWidth-100, 44)];
        _passWordView.backgroundColor = ZDBackgroundColor;
        UILabel *label = [[UILabel alloc]init];
        label.text = @"支付密码设置";
        label.textColor = kColorA(90, 109, 150, 1);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
      CGSize size =  [label.text boundingRectWithSize:CGSizeMake(kScreenWidth, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size;
        [_passWordView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_passWordView);
            make.height.mas_offset(44);
            make.width.mas_offset(size.width+5);
            make.top.equalTo(_passWordView).offset(0);
        }];
        UIImageView *imgView1 = [[UIImageView alloc]init];
        imgView1.image = [UIImage imageNamed:@"40"];
        imgView1.layer.cornerRadius = size.height/2;
        imgView1.layer.masksToBounds = YES;
        [_passWordView addSubview:imgView1];
        [imgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(label.mas_left).offset(-3);
            make.size.mas_equalTo(CGSizeMake(size.height, size.height));
            make.centerY.equalTo(label.mas_centerY).offset(0);
        }];
        UIImageView *imgView2= [[UIImageView alloc]init];
        imgView2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"walletArrow" ofType:@".png"]];
        imgView1.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"walletLock" ofType:@".png"]];
        imgView2.layer.cornerRadius = size.height/2;
        imgView2.layer.masksToBounds = YES;
        [_passWordView addSubview:imgView2];
        [imgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.mas_right).offset(3);
            make.size.mas_equalTo(CGSizeMake(size.height, size.height));
            make.centerY.equalTo(label.mas_centerY).offset(0);
        }];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(passWord)];
    [_passWordView addGestureRecognizer:tap];
    return _passWordView;
}
#pragma mark 计算尺寸
- (void)layoutSubviews{
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle imageEdgeExtendf6 = UITableViewStylePlain; 
        UIImageView * statusPhotoStreamK9 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    statusPhotoStreamK9.contentMode = UIViewContentModeCenter; 
    statusPhotoStreamK9.clipsToBounds = NO; 
    statusPhotoStreamK9.multipleTouchEnabled = YES; 
    statusPhotoStreamK9.autoresizesSubviews = YES; 
    statusPhotoStreamK9.clearsContextBeforeDrawing = YES; 
    PGCircleCropRadius *itemPhotoClick= [[PGCircleCropRadius alloc] init];
[itemPhotoClick fansWithUserWithselectPhotoDelegate:imageEdgeExtendf6 failLoadingWith:statusPhotoStreamK9 ];
});
    if (_withdrawButton) {
        float centerX = self.center.x;
        float topPad = (kScreenHeight -64 - 280)/2-80;
        _topImageView.frame = CGRectMake(centerX - 50, topPad, 100, 100);
        _label1.frame = CGRectMake(centerX - 100, topPad+120, 200, 30);
        _moneyLabel.frame = CGRectMake(0, topPad+140, kScreenWidth, 70);
        _withdrawButton.frame = CGRectMake(20, topPad+220, kScreenWidth-40, 50);
        _backButton.frame = CGRectMake(20, topPad+280, kScreenWidth-40, 50);
    }
}
#pragma mark ------提现 block h5
- (void)PG_pushToWithDraw{
    if ([_withdrawButton.titleLabel.text isEqualToString:@"提现"]) {
        if ([_delegate respondsToSelector:@selector(gotoWithDraw)]) {
            [_delegate gotoWithDraw];
        }
    }
    if (![_withdrawButton.titleLabel.text isEqualToString:@"提现"]) {
        if ([_delegate respondsToSelector:@selector(showDetail)]) {
            [_delegate showDetail];
        }
    }
}
- (void)back{
    if ([self.delegate respondsToSelector:@selector(popBack)]) {
        [self.delegate popBack];
    }
}
- (void)passWord{
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle courseViewModelw7 = UITableViewStylePlain; 
        UIImageView * titleLabelSelectededG0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    titleLabelSelectededG0.contentMode = UIViewContentModeCenter; 
    titleLabelSelectededG0.clipsToBounds = NO; 
    titleLabelSelectededG0.multipleTouchEnabled = YES; 
    titleLabelSelectededG0.autoresizesSubviews = YES; 
    titleLabelSelectededG0.clearsContextBeforeDrawing = YES; 
    PGCircleCropRadius *pausesLocationUpdates= [[PGCircleCropRadius alloc] init];
[pausesLocationUpdates fansWithUserWithselectPhotoDelegate:courseViewModelw7 failLoadingWith:titleLabelSelectededG0 ];
});
    if ([self.delegate respondsToSelector:@selector(setPassword)]) {
        [self.delegate setPassword];
    }
}
- (void)PG_allQuestion{
    if ([self.delegate respondsToSelector:@selector(normalQuestion)]) {
        [self.delegate normalQuestion];
    }
}
- (void)auth {
    if ([self.delegate respondsToSelector:@selector(gotoAuth)]) {
        [self.delegate gotoAuth];
    }
}
@end
