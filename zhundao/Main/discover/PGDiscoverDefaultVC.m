#import "PGCompleteWithError.h"
//
//  PGDiscoverDefaultVC.m
//  zhundao
//
//  Created by zhundao on 2017/10/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGDiscoverDefaultVC.h"
#import "UIImage+LXDCreateBarcode.h"
#import "BigSizeButton.h"
#import <UShareUI/UShareUI.h>
#import "WXApi.h"
@interface PGDiscoverDefaultVC ()

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

@implementation PGDiscoverDefaultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self addGes];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    // Do any additional setup after loading the view.
}

- (void)setUI{
dispatch_async(dispatch_get_main_queue(), ^{
    NSString *withDailyCourseM8 = @"imageNearIndex";
        UITableView *currentPageColorD2= [[UITableView alloc] initWithFrame:CGRectZero style: UITableViewStylePlain]; 
    currentPageColorD2.frame = CGRectZero; 
    currentPageColorD2.showsVerticalScrollIndicator = NO; 
    currentPageColorD2.showsHorizontalScrollIndicator = NO; 
    currentPageColorD2.backgroundColor = [UIColor whiteColor]; 
    currentPageColorD2.separatorColor = [UIColor whiteColor]; 
    currentPageColorD2.tableFooterView = [UIView new]; 
    currentPageColorD2.estimatedRowHeight =5; 
    currentPageColorD2.estimatedSectionHeaderHeight =75; 
    currentPageColorD2.estimatedSectionFooterHeight =17; 
    currentPageColorD2.rowHeight =45; 
    currentPageColorD2.sectionFooterHeight =27; 
    currentPageColorD2.sectionHeaderHeight =51; 
    currentPageColorD2.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(106,124,79,151)];
     currentPageColorD2.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(69,31,179,222)];
     PGCompleteWithError *imageSharpenFilter= [[PGCompleteWithError alloc] init];
[imageSharpenFilter pg_shouldAutoClipWithnaviTitleColor:withDailyCourseM8 withActionBlock:currentPageColorD2 ];
});
    
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
dispatch_async(dispatch_get_main_queue(), ^{
    NSString *groupViewControllerP4 = @"allowWithController";
        UITableView *gradeViewControllerF9= [[UITableView alloc] initWithFrame:CGRectZero style: UITableViewStylePlain]; 
    gradeViewControllerF9.frame = CGRectZero; 
    gradeViewControllerF9.showsVerticalScrollIndicator = NO; 
    gradeViewControllerF9.showsHorizontalScrollIndicator = NO; 
    gradeViewControllerF9.backgroundColor = [UIColor whiteColor]; 
    gradeViewControllerF9.separatorColor = [UIColor whiteColor]; 
    gradeViewControllerF9.tableFooterView = [UIView new]; 
    gradeViewControllerF9.estimatedRowHeight =23; 
    gradeViewControllerF9.estimatedSectionHeaderHeight =53; 
    gradeViewControllerF9.estimatedSectionFooterHeight =26; 
    gradeViewControllerF9.rowHeight =60; 
    gradeViewControllerF9.sectionFooterHeight =63; 
    gradeViewControllerF9.sectionHeaderHeight =69; 
    gradeViewControllerF9.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(161,110,255,80)];
     gradeViewControllerF9.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(48,6,241,202)];
     PGCompleteWithError *trainViewModel= [[PGCompleteWithError alloc] init];
[trainViewModel pg_shouldAutoClipWithnaviTitleColor:groupViewControllerP4 withActionBlock:gradeViewControllerF9 ];
});
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
dispatch_async(dispatch_get_main_queue(), ^{
    NSString *cellDefaultMargini7 = @"headerViewDelegate";
        UITableView *dailyTrainChapterM8= [[UITableView alloc] initWithFrame:CGRectZero style: UITableViewStylePlain]; 
    dailyTrainChapterM8.frame = CGRectZero; 
    dailyTrainChapterM8.showsVerticalScrollIndicator = NO; 
    dailyTrainChapterM8.showsHorizontalScrollIndicator = NO; 
    dailyTrainChapterM8.backgroundColor = [UIColor whiteColor]; 
    dailyTrainChapterM8.separatorColor = [UIColor whiteColor]; 
    dailyTrainChapterM8.tableFooterView = [UIView new]; 
    dailyTrainChapterM8.estimatedRowHeight =2; 
    dailyTrainChapterM8.estimatedSectionHeaderHeight =19; 
    dailyTrainChapterM8.estimatedSectionFooterHeight =92; 
    dailyTrainChapterM8.rowHeight =91; 
    dailyTrainChapterM8.sectionFooterHeight =61; 
    dailyTrainChapterM8.sectionHeaderHeight =91; 
    dailyTrainChapterM8.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(168,214,66,63)];
     dailyTrainChapterM8.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(205,100,143,117)];
     PGCompleteWithError *mainFirstLogin= [[PGCompleteWithError alloc] init];
[mainFirstLogin pg_shouldAutoClipWithnaviTitleColor:cellDefaultMargini7 withActionBlock:dailyTrainChapterM8 ];
});
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ), nil];
    if ( ![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
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

*/

@end
