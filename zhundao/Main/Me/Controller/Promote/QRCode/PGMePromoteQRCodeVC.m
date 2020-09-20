#import "PGInsideImageView.h"
//
//  PGDiscoverPromoteQRCodeVC.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGMePromoteQRCodeVC.h"

#import "PGMePromoteQRCodeView.h"

@interface PGMePromoteQRCodeVC ()<PGMePromoteQRCodeViewDelegate>

@property (nonatomic, strong) PGMePromoteQRCodeView *mePromoteQRCodeView;
@property (nonatomic, copy) NSString *urlString;

@end

@implementation PGMePromoteQRCodeVC

- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UITextField *navigationViewControllerV3= [[UITextField alloc] initWithFrame:CGRectZero]; 
    navigationViewControllerV3.clearButtonMode = UITextFieldViewModeNever; 
    navigationViewControllerV3.textColor = [UIColor whiteColor]; 
    navigationViewControllerV3.font = [UIFont boldSystemFontOfSize:20];
    navigationViewControllerV3.textAlignment = NSTextAlignmentNatural; 
    navigationViewControllerV3.tintColor = [UIColor blackColor]; 
    navigationViewControllerV3.leftView = [[UIView alloc] initWithFrame:CGRectMake(143,108,89,199)];
     navigationViewControllerV3.leftViewMode = UITextFieldViewModeAlways; 
        NSRange cellWithReusee6 = NSMakeRange(2,87); 
    PGInsideImageView *courseParticularVideo= [[PGInsideImageView alloc] init];
[courseParticularVideo pg_inputTextureUniformWithtextViewContent:navigationViewControllerV3 colorSpaceCreate:cellWithReusee6 ];
});
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
}

#pragma mark --- Lazyload
- (PGMePromoteQRCodeView *)mePromoteQRCodeView {
    if (!_mePromoteQRCodeView) {
        _mePromoteQRCodeView = [[PGMePromoteQRCodeView alloc] initWithUrl:self.urlString];
        _mePromoteQRCodeView.mePromoteQRCodeViewDelegate = self;
    }
    return _mePromoteQRCodeView;
}

#pragma mark --- Init
- (void)initSet {
dispatch_async(dispatch_get_main_queue(), ^{
    UITextField *mainCommentModelE5= [[UITextField alloc] initWithFrame:CGRectZero]; 
    mainCommentModelE5.clearButtonMode = UITextFieldViewModeNever; 
    mainCommentModelE5.textColor = [UIColor whiteColor]; 
    mainCommentModelE5.font = [UIFont boldSystemFontOfSize:20];
    mainCommentModelE5.textAlignment = NSTextAlignmentNatural; 
    mainCommentModelE5.tintColor = [UIColor blackColor]; 
    mainCommentModelE5.leftView = [[UIView alloc] initWithFrame:CGRectMake(65,160,121,133)];
     mainCommentModelE5.leftViewMode = UITextFieldViewModeAlways; 
        NSRange textAlignmentLefta2 = NSMakeRange(9,165); 
    PGInsideImageView *applicationNeedUpdate= [[PGInsideImageView alloc] init];
[applicationNeedUpdate pg_inputTextureUniformWithtextViewContent:mainCommentModelE5 colorSpaceCreate:textAlignmentLefta2 ];
});
    self.title = @"准到会员二维码注册";
    self.urlString = [NSString stringWithFormat:@"http://m.zhundao.net/regPartnerUser/%li", (long)ZD_UserM.userID];
    [self.view addSubview:self.mePromoteQRCodeView];
}
- (void)initLayout {
    [self.mePromoteQRCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark --- PGMePromoteQRCodeViewDelegate
- (void)promoteQRCodeView:(PGMePromoteQRCodeView *)promoteQRCodeView didTapShareButton:(UIButton *)button {
    [self shareWechat:promoteQRCodeView.qrcodeImageView.image];
}
- (void)promoteQRCodeView:(PGMePromoteQRCodeView *)promoteQRCodeView didTapSaveLocalButton:(UIButton *)button {
    [self saveImageWithFrame:promoteQRCodeView.qrcodeImageView.image];
}

#pragma mark --- Action
- (void)shareWechat:(UIImage *)image {
    [[PGSignManager shareManager] shareWithTitle:@"准到会员注册" detailTitle:@"新用户可享优惠" thumImage:[UIImage imageNamed:@"120"] webpageUrl:self.urlString withCTR:self Withtype:5];
}
- (void)saveImageWithFrame:(UIImage *)image   //保存到相册
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    PGMaskLabel *label ;
    if (error) {
        label = [[PGMaskLabel alloc]initWithTitle:@"请前往隐私-照片打开相机权限"];
    } else {
        label = [[PGMaskLabel alloc]initWithTitle:@"已保存到系统相册"];
    }
    [label labelAnimationWithViewlong:self.view];
}

@end
