#import "PGObjectsFromArray.h"
#import "PGSignManager.h"
#import <UShareUI/UShareUI.h>
#import "WXApi.h"
@interface PGSignManager ()
{
}
@end
@implementation PGSignManager
+(PGSignManager *)shareManager
{
    static PGSignManager *manager = nil;
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
- (void)createDatabase  
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
    PGMaskLabel *label ;
    if (error) {
        label = [[PGMaskLabel alloc]initWithTitle:@"请前往隐私-照片打开相机权限"];
    } else {
        label = [[PGMaskLabel alloc]initWithTitle:@"已保存到系统相册"];
    }
    [label labelAnimationWithViewlong:SaveCtr.view];
}
- (void)shareImagewithModel:(ActivityModel *)model withCTR:(UIViewController *)ctr Withtype:(NSInteger)type withImage :(UIImage *)image {
dispatch_async(dispatch_get_main_queue(), ^{
    UISwitch *collectionWithOffsetf4= [[UISwitch alloc] initWithFrame:CGRectZero]; 
    collectionWithOffsetf4.on = YES; 
    collectionWithOffsetf4.onTintColor = [UIColor whiteColor]; 
        CGRect allowPickingImagei8 = CGRectMake(3,67,197,172); 
    PGObjectsFromArray *keyboardWillChange= [[PGObjectsFromArray alloc] init];
[keyboardWillChange imageProgressUpdateWithfinishLoadingWith:collectionWithOffsetf4 imageAlphaBlend:allowPickingImagei8 ];
});
    ZD_WeakSelf
    ZDBlock_Str shareBlock = ^(NSString *str) {
        [weakSelf shareWithTitle:model.Title detailTitle:[NSString stringWithFormat:@"时间:%@ 地点:%@",model.TimeStart,model.Address] thumImage:image ? image : [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.ShareImgurl]]] webpageUrl:str withCTR:ctr Withtype:type];
    };
    if (ZD_UserM.isAdmin) {
        shareBlock([NSString stringWithFormat:@"https://m.zhundao.net/eventjt/%li/0?token=%@",(long)model.ID,ZD_UserM.token]);
    } else {
        [self PG_networkForGetActivityLinkWithID:model.ID success:^(NSString *obj) {
            shareBlock(obj);
        }];
    }
}
- (void)PG_networkForGetActivityLinkWithID:(NSInteger)ID success:(ZDBlock_Str)success {
dispatch_async(dispatch_get_main_queue(), ^{
    UISwitch *readingMutableContainersh0= [[UISwitch alloc] initWithFrame:CGRectZero]; 
    readingMutableContainersh0.on = YES; 
    readingMutableContainersh0.onTintColor = [UIColor whiteColor]; 
        CGRect deliveryModeHighM1 = CGRectZero;
    PGObjectsFromArray *assetCollectionType= [[PGObjectsFromArray alloc] init];
[assetCollectionType imageProgressUpdateWithfinishLoadingWith:readingMutableContainersh0 imageAlphaBlend:deliveryModeHighM1 ];
});
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
          [arr removeObject:@(UMSocialPlatformType_WechatSession)];
          [arr removeObject:@(UMSocialPlatformType_WechatTimeLine)];
      }
      [UMSocialUIManager setPreDefinePlatforms:arr];
      [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.isShow = NO;
      [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
          UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
          UMShareWebpageObject *shareObject = nil;
          UMShareImageObject *imageObject = nil;
          if (type==5) { 
              if (platformType ==UMSocialPlatformType_WechatSession) {
                  shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:detailTitle thumImage:thumImage];
              }
              else
              {
                  shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:nil thumImage:thumImage];
              }
              shareObject.webpageUrl =webpageUrl;
             messageObject.shareObject = shareObject;
          }
          else
          {
                 imageObject = [[UMShareImageObject alloc] init];
              [imageObject setShareImage:thumImage];
              messageObject.shareObject = imageObject;
          }
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
    PGMaskLabel *label = [[PGMaskLabel alloc] initWithTitle:@"请检查网络设置"];
    [label labelAnimationWithViewlong:View];
}
@end
