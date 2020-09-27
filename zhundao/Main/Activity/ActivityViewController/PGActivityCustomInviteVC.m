#import "PGDeviceOrientationFace.h"
#import "PGActivityCustomInviteVC.h"
#import "PGActivityCustomInviteVM.h"
#import "BigSizeButton.h"
#import <UShareUI/UShareUI.h>
#import "WXApi.h"
#import "UIImage+LXDCreateBarcode.h"
@interface PGActivityCustomInviteVC ()
@property(nonatomic,strong)PGActivityCustomInviteVM *customViewModel;
@property(nonatomic,copy)NSArray *dataArray;
@property(nonatomic,strong)BigSizeButton *shareButton;
@property(nonatomic,strong)UIImage *image;
@end
@implementation PGActivityCustomInviteVC
- (void)viewDidLoad {
    [super viewDidLoad];
    _customViewModel = [[PGActivityCustomInviteVM alloc]init];
    [self PG_setUI];
    [self addGes];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}
#pragma mark --- 获取数据
- (void)PG_setUI{
        NSInteger index  = [[[NSUserDefaults standardUserDefaults]objectForKey:@"selectInvite"] integerValue];
        _dataArray = [_customViewModel getInviteFixWithIndex:index];
    _image = [_customViewModel getImageWithIndex:index];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    backImageView.image = _image;
    [self.view addSubview:backImageView];
        for (NSDictionary *dic in _dataArray) {
        if (dic.count==2) {
            CGRect tempRect =  CGRectFromString(dic[@"rect"]);
            UIImageView *bgImgView = [[UIImageView alloc] init];
            bgImgView.image = [self imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(tempRect.size.width + 10, tempRect.size.height + 10)];
            bgImgView.frame = CGRectMake(tempRect.origin.x - 5, tempRect.origin.y - 5, tempRect.size.width + 10, tempRect.size.height + 10);
            [self.view addSubview:bgImgView];
            UIImageView *imgView =[[UIImageView alloc]init];
            [self.view addSubview:imgView];
            imgView.frame = CGRectFromString(dic[@"rect"]);
            imgView.tag = [dic[@"tag"] integerValue];
            if (imgView.tag==1000) {
                imgView.image = [UIImage imageOfQRFromURL:_signCodeStr];
            }else{
                imgView.image = [UIImage imageOfQRFromURL:_activityCodeStr];
            }
        }else{
            [self PG_createLabelWithDic:dic];
        }
    }
    NSArray *customArray = [_customViewModel getInviteCustomWithIndex:index];
    for (int i= 0; i<customArray.count; i++) {
        NSDictionary *dic = [customArray objectAtIndex:i];
        [self PG_createLabelWithDic:dic];
    }
    _image = [self imageWithUIView:self.view];
    _shareButton = [[BigSizeButton alloc]initWithFrame:CGRectMake(kScreenWidth-60, 30, 30, 30)];
    [_shareButton addTarget:self action:@selector(shareImage) forControlEvents:UIControlEventTouchUpInside];
    [_shareButton setImage:[UIImage imageNamed:@"detailShare"] forState:UIControlStateNormal];
    [self.view addSubview:_shareButton];
}
- (void)PG_createLabelWithDic :(NSDictionary *)dic{
    UILabel *label = [[UILabel alloc]init];
    label.textColor = kColorA([dic[@"R"]floatValue]*256, [dic[@"G"]floatValue]*256, [dic[@"B"]floatValue]*256, 1);
    label.font = [UIFont systemFontOfSize:[dic[@"fontsize"] floatValue]];
    label.text = dic[@"text"];
    label.frame = CGRectFromString(dic[@"rect"]);
    label.numberOfLines = 0;
    label.tag = [dic[@"tag"] integerValue];
    [self.view addSubview:label];
    CGRect rect = CGRectFromString(dic[@"rect"]);
    if ((int)rect.origin.x == (int)(kScreenWidth - rect.origin.x -rect.size.width)) {
        label.textAlignment = NSTextAlignmentCenter;
    }if ((int)rect.origin.x==0) {
        label.frame =CGRectMake(25, rect.origin.y, kScreenWidth-25, 40);
    }
    switch (label.tag-1000) {
        case 2:
            label.text = _activityAddress;
            break;
        case 3:
            label.text = _activityTime;
            break;
        case 4:
            label.text = _activityTitle;
            label.textAlignment = NSTextAlignmentCenter;
            break;
        case 5:
            label.text = _name;
            break;
        default:
            break;
    }
}
- (void)addGes{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark--- 分享
- (void)shareImage{
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ), nil];
    if ( ![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
        [arr removeObject:@(UMSocialPlatformType_QQ)];
    }
    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
        [arr removeObject:@(UMSocialPlatformType_WechatSession)];
    }
    [UMSocialUIManager setPreDefinePlatforms:arr];
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.isShow = NO;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        [shareObject setShareImage:_image];
        messageObject.shareObject = shareObject;
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
    if([[UIScreen mainScreen] scale] == 2.0){      
        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 2.0);
    }else if([[UIScreen mainScreen] scale] == 3.0){ 
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
- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image1;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
