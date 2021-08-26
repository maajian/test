//
//  ZDDiscoverPromoteQRCodeVC.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMePromoteQRCodeVC.h"

#import "ZDMePromoteQRCodeView.h"

@interface ZDMePromoteQRCodeVC ()<ZDMePromoteQRCodeViewDelegate, ZDShareViewDelegate>

@property (nonatomic, strong) ZDMePromoteQRCodeView *mePromoteQRCodeView;
@property (nonatomic, copy) NSString *urlString;

@end

@implementation ZDMePromoteQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
}

#pragma mark --- Lazyload
- (ZDMePromoteQRCodeView *)mePromoteQRCodeView {
    if (!_mePromoteQRCodeView) {
        _mePromoteQRCodeView = [[ZDMePromoteQRCodeView alloc] initWithUrl:self.urlString];
        _mePromoteQRCodeView.mePromoteQRCodeViewDelegate = self;
    }
    return _mePromoteQRCodeView;
}

#pragma mark --- Init
- (void)initSet {
    self.title = @"准到会员二维码注册";
    self.urlString = [NSString stringWithFormat:@"http://m.zhundao.net/regPartnerUser/%li", (long)ZD_UserM.userID];
    [self.view addSubview:self.mePromoteQRCodeView];
}
- (void)initLayout {
    [self.mePromoteQRCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark --- ZDMePromoteQRCodeViewDelegate
- (void)promoteQRCodeView:(ZDMePromoteQRCodeView *)promoteQRCodeView didTapShareButton:(UIButton *)button {
    [self shareWechat:promoteQRCodeView.qrcodeImageView.image];
}
- (void)promoteQRCodeView:(ZDMePromoteQRCodeView *)promoteQRCodeView didTapSaveLocalButton:(UIButton *)button {
    [self saveImageWithFrame:promoteQRCodeView.qrcodeImageView.image];
}


#pragma mark --- ZDShareViewDelegate
- (void)shareView:(ZDShareView *)shareView didSelectType:(ZDShareType)shareType {
    if (shareType == ZDShareTypeWechat) {
        [[SignManager shareManager] shareWithTitle:@"准到会员注册" detailTitle:@"新用户可享优惠" thumImage:[UIImage imageNamed:@"120"] webpageUrl:self.urlString withCTR:self Withtype:5 scene:0];
    } else {
        [[SignManager shareManager] shareWithTitle:@"准到会员注册" detailTitle:@"新用户可享优惠" thumImage:[UIImage imageNamed:@"120"] webpageUrl:self.urlString withCTR:self Withtype:5 scene:1];
    }
}

#pragma mark --- Action
- (void)shareWechat:(UIImage *)image {
    [ZDShareView showWithDelegate:self];
}
- (void)saveImageWithFrame:(UIImage *)image   //保存到相册
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    maskLabel *label ;
    if (error) {
        label = [[maskLabel alloc]initWithTitle:@"请前往隐私-照片打开相机权限"];
    } else {
        label = [[maskLabel alloc]initWithTitle:@"已保存到系统相册"];
    }
    [label labelAnimationWithViewlong:self.view];
}

@end
