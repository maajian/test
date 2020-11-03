#import "PGFirendsViewModel.h"
#import "PGMeMyMessageView.h"
@interface PGMeMyMessageView()
@end
@implementation PGMeMyMessageView
- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
        self.contentSize = CGSizeMake(kScreenWidth, kScreenHeight-63);
        self.backgroundColor = ZDBackgroundColor;
        [self PG_setupUI];
    }
    return self;
}
- (void)PG_setupUI{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"message"];
    [self addSubview:imageView];
    imageView.layer.cornerRadius = 50;
    imageView.layer.masksToBounds = YES;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(90);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.equalTo(self.mas_centerX).offset(0);
    }];
    UILabel *label1 = [[UILabel alloc]init];
    label1.font = [UIFont systemFontOfSize:18];
    label1.text = @"剩余短信(条)";
    label1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-100, 30));
        make.centerX.equalTo(self.mas_centerX).offset(0);
    }];
    _countLabel  = [[UILabel alloc]init];
    _countLabel.font = [UIFont boldSystemFontOfSize:32];
    _countLabel.text = @"0";
    _countLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-100, 50));
        make.centerX.equalTo(self.mas_centerX).offset(0);
    }];
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.backgroundColor = ZDMainColor;
    payButton.layer.cornerRadius = 4;
    payButton.layer.masksToBounds = YES;
    [payButton setTitle:@"充值" forState:UIControlStateNormal];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(PG_payMoney) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:payButton];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_countLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-40, 50));
        make.centerX.equalTo(self.mas_centerX).offset(0);
    }];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor = [UIColor  whiteColor];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.layer.cornerRadius= 4;
    backButton.layer.masksToBounds = YES;
    [backButton addTarget:self action:@selector(PG_backCtr) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payButton.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-40, 50));
        make.centerX.equalTo(self.mas_centerX).offset(0);
    }];
   UIButton *queButton = [MyButton initWithButtonFrame:CGRectMake(50, kScreenHeight-64-50, kScreenWidth-100, 30) title:@"常见问题" textcolor:kColorA(90, 109, 150, 1) Target:self action:@selector(PG_showQus) BackgroundColor:nil cornerRadius:0 masksToBounds:0];
    queButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:queButton];
}
#pragma mark --- 按钮点击事件
- (void)PG_payMoney{
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle routeSearchDoneK2 = UITableViewStylePlain; 
        CGPoint assetImageGeneratorT4 = CGPointMake(4,108); 
    PGFirendsViewModel *coachDetailModel= [[PGFirendsViewModel alloc] init];
[coachDetailModel vertexAttribPointerWithrouteChangeListener:routeSearchDoneK2 showFullButton:assetImageGeneratorT4 ];
});
    if ([self.PGMeMyMessageViewDelegate respondsToSelector:@selector(payMessage)]) {
         [self.PGMeMyMessageViewDelegate payMessage];
    }
}
- (void)PG_backCtr{
    if ([self.PGMeMyMessageViewDelegate respondsToSelector:@selector(backpop)]) {
        [self.PGMeMyMessageViewDelegate backpop];
    }
}
- (void)PG_showQus{
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle autoresizingMaskInton2 = UITableViewStylePlain; 
        CGPoint fragmentShaderStringj4 = CGPointMake(4,144); 
    PGFirendsViewModel *valueObservingOptions= [[PGFirendsViewModel alloc] init];
[valueObservingOptions vertexAttribPointerWithrouteChangeListener:autoresizingMaskInton2 showFullButton:fragmentShaderStringj4 ];
});
    if ([self.PGMeMyMessageViewDelegate respondsToSelector:@selector(allQues)]) {
        [self.PGMeMyMessageViewDelegate allQues];
    }
}
@end