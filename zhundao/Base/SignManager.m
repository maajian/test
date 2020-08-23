
//
//  SignManager.m
//  zhundao
//
//  Created by zhundao on 2016/12/20.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "SignManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
@interface SignManager ()
{
    
}
@end
@implementation SignManager
+(SignManager *)shareManager
{
    static SignManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(manager==nil)
        {
            manager = [[super allocWithZone:nil]init];
    }
    });
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self shareManager];
    
}
- (id)copy
{
    return self;
}

- (NSString *)getaccseekey
{
    NSString *acc =[[NSUserDefaults standardUserDefaults]objectForKey:AccessKey];
    NSString *uid = [[NSUserDefaults standardUserDefaults]objectForKey:WX_UNION_ID];
    if (acc) {
        _accesskey = [acc copy];
    }
    if (uid) {
        _accesskey = [uid copy];
    }
    return _accesskey;
}

- (NSString *)getToken {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"token"]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    } else {
        return @"";
    }
}

- (void)createDatabase  //创建数据库
{
    NSString *path =NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)[0];
    path = [path stringByAppendingString:@"list.sqlite"];
    NSLog(@"path = %@",path);
    _dataBase = [FMDatabase databaseWithPath:path];
    BOOL open = [_dataBase open];
    if (open) {
        NSLog(@"数据库打开成功");
    }
    else
    {
        NSLog(@"数据库打开失败");
    }
    }
- (void)showAlertWithTitle :(NSString *)title
                WithMessage:(NSString *)message
                   WithCTR :(UIViewController *)ctr
{
    TYAlertView *alert = [TYAlertView alertViewWithTitle:title message:message];
    [alert addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDefault handler:nil]];
    TYAlertController *tyCTR = [TYAlertController alertControllerWithAlertView:alert preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationScaleFade];
    [ctr presentViewController:tyCTR animated:YES completion:nil];
}

- (void)showAlertWithTitle :(NSString *)title
                WithMessage:(NSString *)message
              WithTitleOne :(NSString *)titleOne
              WithActionOne:(TYAlert )action1
              WithAlertStyle:(TYAlertActionStyle )style
              WithTitleTwo :(NSString *)titleTwo
              WithActionTwo :(TYAlert )action2
                   WithCTR :(UIViewController *)ctr
{
    
    TYAlertView *alert = [TYAlertView alertViewWithTitle:title message:message];
    [alert addAction:[TYAlertAction actionWithTitle:titleOne style:style handler:action1]];
    [alert addAction:[TYAlertAction actionWithTitle:titleTwo style:TYAlertActionStyleDefault handler:action2]];
    TYAlertController *tyCTR = [TYAlertController alertControllerWithAlertView:alert preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationScaleFade];
    [ctr presentViewController:tyCTR animated:YES completion:nil];
}

- (void)showAlertWithTitle :(NSString *)title
                WithMessage:(NSString *)message
              WithTitleOne :(NSString *)titleOne
              WithActionOne:(TYAlert )action1
             WithAlertStyle:(TYAlertActionStyle )style
                   WithCTR :(UIViewController *)ctr
{
    
    TYAlertView *alert = [TYAlertView alertViewWithTitle:title message:message];
    [alert addAction:[TYAlertAction actionWithTitle:titleOne style:style handler:action1]];
    TYAlertController *tyCTR = [TYAlertController alertControllerWithAlertView:alert preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationScaleFade];
    [ctr presentViewController:tyCTR animated:YES completion:nil];
}
- (void)saveImageWithFrame:(CGRect )rect
                   WithCtr:(UIViewController *)Ctr
{
    SaveCtr = Ctr;
    UIGraphicsBeginImageContext(Ctr.view.bounds.size);
    [Ctr.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef bitmapImage =CGImageCreateWithImageInRect(image.CGImage,rect);
    UIImage *resultImg = [UIImage imageWithCGImage:bitmapImage];
    CGImageRelease(bitmapImage);
    [self loadImageFinished:resultImg];
}

- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    maskLabel *label ;
    if (error) {
        label = [[maskLabel alloc]initWithTitle:@"请前往隐私-照片打开相机权限"];
    } else {
        label = [[maskLabel alloc]initWithTitle:@"已保存到系统相册"];
    }
    [label labelAnimationWithViewlong:SaveCtr.view];
}
- (void)shareImagewithModel:(ActivityModel *)model withCTR:(UIViewController *)ctr Withtype:(NSInteger)type withImage :(UIImage *)image {
    ZD_WeakSelf
    ZDBlock_Str shareBlock = ^(NSString *str) {
        [weakSelf shareWithTitle:model.Title detailTitle:[NSString stringWithFormat:@"时间:%@ 地点:%@",model.TimeStart,model.Address] thumImage:image ? image : [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.ShareImgurl]]] webpageUrl:str withCTR:ctr Withtype:type];
    };
    if (ZD_UserM.isAdmin) {
        shareBlock([NSString stringWithFormat:@"https://m.zhundao.net/eventjt/{%li}/0?token=%@",(long)model.ID,ZD_UserM.token]);
    } else {
        [self networkForGetActivityLinkWithID:model.ID success:^(NSString *obj) {
            shareBlock(obj);
        }];
    }
}
- (void)networkForGetActivityLinkWithID:(NSInteger)ID success:(ZDBlock_Str)success {
    ZD_HUD_SHOW_WAITING
    NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, ZD_UserM.token];
    NSDictionary *dic = @{@"BusinessCode": @"GetActivityLink",
                          @"Data" : @{
                                  @"ActivityId": @(ID),
                         }
    };
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        ZD_HUD_DISMISS
        ZDDo_Block_Safe_Main1(success, obj[@"data"])
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR(error)
    }];
}
- (void)shareWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle thumImage:(UIImage *)thumImage webpageUrl:(NSString *)webpageUrl withCTR:(UIViewController *)ctr Withtype:(NSInteger)type {
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine), nil];
      if (![WXApi isWXAppInstalled]) {
          //没有安装微信
          [arr removeObject:@(UMSocialPlatformType_WechatSession)];
          [arr removeObject:@(UMSocialPlatformType_WechatTimeLine)];
      }
    
      [UMSocialUIManager setPreDefinePlatforms:arr];
      [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.isShow = NO;
      [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
          UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
          UMShareWebpageObject *shareObject = nil;
          UMShareImageObject *imageObject = nil;
          if (type==5) { //网页分享
              if (platformType ==UMSocialPlatformType_WechatSession) {
                  shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:detailTitle thumImage:thumImage];
              }
              else
              {
                  shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:nil thumImage:thumImage];
              }
              //如果有缩略图，则设置缩略图
              shareObject.webpageUrl =webpageUrl;
             messageObject.shareObject = shareObject;
          }
          else
          {
                 imageObject = [[UMShareImageObject alloc] init];
              [imageObject setShareImage:thumImage];
              messageObject.shareObject = imageObject;
          }

          
          //调用分享接口
          [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:ctr completion:^(id data, NSError *error) {
              if (error) {
                  NSLog(@"************Share fail with error %@*********",error);
              }else{
                  NSLog(@"response data is %@",data);
              }
          }];
      }];
}


- (void)saveData:(NSArray *)array name :(NSString *)name
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:name];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSArray *)getArray :(NSString *)name
{
    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:name];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return array;
}
- (void)showNotHaveNet:(UIView *)View {
    maskLabel *label = [[maskLabel alloc] initWithTitle:@"请检查网络设置"];
    [label labelAnimationWithViewlong:View];
}

@end
