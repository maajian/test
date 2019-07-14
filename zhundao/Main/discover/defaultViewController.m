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
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import <TencentOpenAPI/QQApiInterface.h>
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
    [self addGes];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    // Do any additional setup after loading the view.
}

- (void)setUI{
    
    /*! 背景图片 */
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    backImageView.image = [UIImage imageNamed:@"专属邀请函1.jpg"];
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
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, kScreenHeight/2-kScreenHeight*0.09, kScreenWidth-80, kScreenHeight*0.1)];
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
        
        _QRimageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth -100)/2, kScreenHeight/2+kScreenHeight*0.2, 100, 100)];
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
            _nameLabel = [MyLabel initWithLabelFrame:CGRectMake(50, kScreenHeight/2+kScreenHeight*0.0945, kScreenWidth-100, kScreenHeight*0.1) Text:_name textColor:[UIColor whiteColor] font:KweixinFont(17) textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:0];
        }else{
            _nameLabel = [MyLabel initWithLabelFrame:CGRectMake(50, kScreenHeight/2+kScreenHeight*0.0945, kScreenWidth-100, kScreenHeight*0.1) Text:@"周先生(变量)" textColor:[UIColor whiteColor] font:KweixinFont(17) textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:0];
        }
    }
    return _nameLabel;
}


- (UILabel *)bottomLabel{
    if (!_bottomLabel) {
        if (_isSign) {
            _bottomLabel = [MyLabel initWithLabelFrame:CGRectMake(50, kScreenHeight*0.87, kScreenWidth-100, 30) Text:@"专属二维码入场凭证" textColor:[UIColor colorWithWhite:0.70 alpha:1] font:KweixinFont(11) textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:0];
        }else{
            _bottomLabel = [MyLabel initWithLabelFrame:CGRectMake(50, kScreenHeight*0.87, kScreenWidth-100, 30) Text:@"长按或扫一扫报名" textColor:[UIColor colorWithWhite:0.70 alpha:1] font:KweixinFont(11) textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:0];
        }
    }
    return _bottomLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        if (_timeStr) {
            _timeLabel = [MyLabel initWithLabelFrame:CGRectMake(40, kScreenHeight*0.88, kScreenWidth-80, kScreenHeight*0.1) Text:_timeStr textColor:[UIColor colorWithWhite:0.70 alpha:1] font:KweixinFont(12) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
        }else{
            _timeLabel = [MyLabel initWithLabelFrame:CGRectMake(40, kScreenHeight*0.88, kScreenWidth-80, kScreenHeight*0.1) Text:@"时间: 2017-11-10 09:00(变量)" textColor:[UIColor colorWithWhite:0.70 alpha:1] font:KweixinFont(12) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
        }
    }
    return _timeLabel;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        if (_address) {
            _addressLabel = [MyLabel initWithLabelFrame:CGRectMake(40, kScreenHeight*0.88+35, kScreenWidth-80, 30) Text:_address textColor:[UIColor colorWithWhite:0.70 alpha:1] font:KweixinFont(12) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
        }else{
            _addressLabel = [MyLabel initWithLabelFrame:CGRectMake(40, kScreenHeight*0.88+35, kScreenWidth-80, 30) Text:@"地址: 杭州滨江区白马湖会展中心(变量)" textColor:[UIColor colorWithWhite:0.70 alpha:1] font:KweixinFont(12) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
        }
    }
    return _addressLabel;
}

#pragma mark--- 分享

- (void)shareImage{
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ), nil];
    if ( ![QQApiInterface isQQInstalled]) {
        //没有安装QQ
        [arr removeObject:@(UMSocialPlatformType_QQ)];
    }
    if (![WXApi isWXAppInstalled]) {
        //没有安装微信
        [arr removeObject:@(UMSocialPlatformType_WechatSession)];
       
    }
    
    [UMSocialUIManager setPreDefinePlatforms:arr];
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.isShow = NO;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        [shareObject setShareImage:_image];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                NSLog(@"response data is %@",data);
            }
        }];
    }];

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
