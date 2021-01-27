//
//  defaultViewController.m
//  zhundao
//
//  Created by zhundao on 2017/10/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "defaultViewController.h"
#import "UIImage+LXDCreateBarcode.h"
#import "BigSizeButton.h"
#import "WXApi.h"
@interface defaultViewController ()

/*! 活动标题 */
@property(nonatomic,strong)UILabel *titleLabel;
/*! 二维码图片 */
@property(nonatomic,strong)UIImageView *QRimageView;
/*! 姓名 */
@property(nonatomic,strong)UILabel *nameLabel;
/*! 截屏的图片 */
@property(nonatomic,strong)UIImage *image;
/*! 分享按钮 */
@property(nonatomic,strong)BigSizeButton *shareButton;
/*! 底部显示的标题 */
@property(nonatomic,strong)UILabel *bottomLabel;
/*! 地点 */
@property(nonatomic,strong)UILabel *timeLabel;
/*! 时间 */
@property(nonatomic,strong)UILabel *addressLabel;

@end

@implementation defaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self initLayout];
    [self addGes];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    // Do any additional setup after loading the view.
}

- (void)setUI{
    
    /*! 背景图片 */
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    if ([UIScreen mainScreen].bounds.size.height == 480) {
         // 3.5英寸
        backImageView.image = [UIImage imageNamed:@"discover_own_invite_640X960"];
     } else if ([UIScreen mainScreen].bounds.size.height == 568) {
         // 4.0英寸
         backImageView.image = [UIImage imageNamed:@"discover_own_invite_640X1136"];
     } else if ([UIScreen mainScreen]. bounds.size.height == 667) {
         // 5.0英寸
         backImageView.image = [UIImage imageNamed:@"discover_own_invite_750X1334"];
     } else {
         // X英寸
         backImageView.image = [UIImage imageNamed:@"discover_own_invite_1242X2688"];
     }
    [self.view addSubview:backImageView];
    
    /*! 活动标题 */
    [self.view addSubview:self.titleLabel];
    
    UIView *QRbgView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth -100)/2 - 5, kScreenHeight/2+kScreenHeight*0.2 - 5, 110, 110)];
    QRbgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:QRbgView];
    /*! 二维码 */
    [self.view addSubview:self.QRimageView];
    /*! 姓名 */
    [self.view addSubview:self.nameLabel];
    /*! 显示底部的标题 */
    [self.view addSubview:self.bottomLabel];
    /*! 时间 */
    [self.view addSubview:self.timeLabel];
    /*! 地点 */
    [self.view addSubview:self.addressLabel];
    /*! 截屏 分享 */
    if (_activityTitle) {
        _image = [self imageWithUIView:self.view];
        _shareButton = [[BigSizeButton alloc]initWithFrame:CGRectMake(kScreenWidth-60, 30, 30, 30)];
        [_shareButton addTarget:self action:@selector(shareImage) forControlEvents:UIControlEventTouchUpInside];
        [_shareButton setImage:[UIImage imageNamed:@"detailShare"] forState:UIControlStateNormal];
        [self.view addSubview:_shareButton];
    }
}

- (void)initLayout {
    CGFloat contentHeight = kScreenHeight;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(40);
        make.top.mas_equalTo(@(contentHeight / 2 - contentHeight * 0.09));
        make.width.mas_equalTo(kScreenWidth - 80);
        make.height.mas_equalTo(contentHeight * 0.1);
    }];
    [self.QRimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset((kScreenWidth -100)/2);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(contentHeight * 0.19);
        make.height.width.mas_equalTo(100);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(50);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(contentHeight * 0.0845);
        make.width.mas_equalTo(kScreenWidth - 100);
        make.height.mas_equalTo(contentHeight * 0.1);
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(50);
        make.top.equalTo(self.view).offset(contentHeight * 0.885);
        make.width.mas_equalTo(kScreenWidth - 100);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(40);
        make.top.equalTo(self.bottomLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(kScreenWidth - 80);
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(40);
        make.top.equalTo(self.timeLabel.mas_bottom);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark  --- 点击推出
- (void)addGes{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --- 懒加载

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:22];
        _titleLabel.textColor = [UIColor whiteColor];
        if (_activityTitle) {
            _titleLabel.text = _activityTitle;
        }else{
            _titleLabel.text = @"阿里巴巴诸神之战全球创客大赛(变量)";
        }
    }
    return _titleLabel;
}

- (UIImageView *)QRimageView{
    if (!_QRimageView) {
        _QRimageView = [[UIImageView alloc] init];
        if (_codeStr) {
            _QRimageView.image = [UIImage imageOfQRFromURL:_codeStr];
        }else{
            _QRimageView.image = [UIImage imageOfQRFromURL:@"www.baidu.com"];
        }
    }
    return _QRimageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        if (_name) {
            _nameLabel = [MyLabel initWithLabelFrame:CGRectZero Text:_name textColor:[UIColor whiteColor] font:KweixinFont(17) textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:0];
        }else{
            _nameLabel = [MyLabel initWithLabelFrame:CGRectZero Text:@"周先生(变量)" textColor:[UIColor whiteColor] font:KweixinFont(17) textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:0];
        }
    }
    return _nameLabel;
}


- (UILabel *)bottomLabel{
    if (!_bottomLabel) {
        if (_isSign) {
            _bottomLabel = [MyLabel initWithLabelFrame:CGRectZero Text:@"专属二维码入场凭证" textColor:[UIColor colorWithWhite:0.70 alpha:1] font:KweixinFont(11) textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:0];
        }else{
            _bottomLabel = [MyLabel initWithLabelFrame:CGRectZero Text:@"长按或扫一扫报名" textColor:[UIColor colorWithWhite:0.70 alpha:1] font:KweixinFont(11) textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:0];
        }
    }
    return _bottomLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        if (_timeStr) {
            _timeLabel = [MyLabel initWithLabelFrame:CGRectZero Text:_timeStr textColor:[UIColor colorWithWhite:0.70 alpha:1] font:KweixinFont(12) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
        }else{
            _timeLabel = [MyLabel initWithLabelFrame:CGRectZero Text:@"时间: 2017-11-10 09:00(变量)" textColor:[UIColor colorWithWhite:0.70 alpha:1] font:KweixinFont(12) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
        }
    }
    return _timeLabel;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        if (_address) {
            _addressLabel = [MyLabel initWithLabelFrame:CGRectZero Text:_address textColor:[UIColor colorWithWhite:0.70 alpha:1] font:KweixinFont(12) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
        }else{
            _addressLabel = [MyLabel initWithLabelFrame:CGRectZero Text:@"地址: 杭州滨江区白马湖会展中心(变量)" textColor:[UIColor colorWithWhite:0.70 alpha:1] font:KweixinFont(12) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
        }
    }
    return _addressLabel;
}

#pragma mark--- 分享

- (void)shareImage{
    if (![WXApi isWXAppInstalled]) {
        NSLog(@"请移步App Store去下载微信客户端");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先下载微信" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;;
    }
    
    // 创建分享内容
    WXMediaMessage *message = [WXMediaMessage message];
    
    // 多媒体消息中包含的图片数据对象
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = UIImageJPEGRepresentation(_image, 1);

    message.mediaObject = imageObject;
    
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
    sendReq.message = message;
    sendReq.bText = NO;
//    sendReq.scene = WXSceneTimeline;// 分享到朋友圈
    sendReq.scene = WXSceneSession;// 分享到微信
    [WXApi sendReq:sendReq completion:nil];
}

#pragma mark --- 截屏
- (UIImage*) imageWithUIView:(UIView*) view
{
    if([[UIScreen mainScreen] scale] == 2.0){      // @2x
        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 2.0);
    }else if([[UIScreen mainScreen] scale] == 3.0){ // @3x ( iPhone 6plus 、iPhone 6s plus)
        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 3.0);
    }else{
        UIGraphicsBeginImageContext(view.frame.size);
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
