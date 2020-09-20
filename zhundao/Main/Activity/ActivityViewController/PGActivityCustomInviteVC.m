//
//  PGActivityCustomInviteVC.m
//  zhundao
//
//  Created by zhundao on 2017/10/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGActivityCustomInviteVC.h"
#import "PGActivityCustomInviteVM.h"
#import "BigSizeButton.h"
#import <UShareUI/UShareUI.h>
#import "WXApi.h"
#import "UIImage+LXDCreateBarcode.h"
@interface PGActivityCustomInviteVC ()



@property(nonatomic,strong)PGActivityCustomInviteVM *customViewModel;
/*! 显示的数据 */
@property(nonatomic,copy)NSArray *dataArray;
/*! 分享按钮 */
@property(nonatomic,strong)BigSizeButton *shareButton;
/*! 截屏的图片 */
@property(nonatomic,strong)UIImage *image;
@end

@implementation PGActivityCustomInviteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _customViewModel = [[PGActivityCustomInviteVM alloc]init];
    
    [self setUI];
    [self addGes];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    // Do any additional setup after loading the view.
}

#pragma mark --- 获取数据

- (void)setUI{
    /*! 获取数据 */
        NSInteger index  = [[[NSUserDefaults standardUserDefaults]objectForKey:@"selectInvite"] integerValue];
        _dataArray = [_customViewModel getInviteFixWithIndex:index];
    
    /*! 背景图片 */
    _image = [_customViewModel getImageWithIndex:index];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    backImageView.image = _image;
    [self.view addSubview:backImageView];
    
    /*! 创建UI */
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
            [self createLabelWithDic:dic];
        }
    }
    
    /*! 获取数据 */
    NSArray *customArray = [_customViewModel getInviteCustomWithIndex:index];

    /*! 创建UI */
    for (int i= 0; i<customArray.count; i++) {
        NSDictionary *dic = [customArray objectAtIndex:i];
        [self createLabelWithDic:dic];
    }
    
    _image = [self imageWithUIView:self.view];
    _shareButton = [[BigSizeButton alloc]initWithFrame:CGRectMake(kScreenWidth-60, 30, 30, 30)];
    [_shareButton addTarget:self action:@selector(shareImage) forControlEvents:UIControlEventTouchUpInside];
    [_shareButton setImage:[UIImage imageNamed:@"detailShare"] forState:UIControlStateNormal];
    [self.view addSubview:_shareButton];
}

/*! 创建label */
- (void)createLabelWithDic :(NSDictionary *)dic{
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

/*! 点击退出 */
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
        //没有安装QQ
        [arr removeObject:@(UMSocialPlatformType_QQ)];
    }
    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
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

/**
 *  返回指定颜色生成的图片
 *
 *  @param color 颜色
 *  @param size  尺寸
 *
 *  @return UIImage
 */
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
