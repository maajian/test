
//
//  SignManager.m
//  zhundao
//
//  Created by zhundao on 2016/12/20.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "SignManager.h"
//#import <UShareUI/UShareUI.h>
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
    [self shareWithTitle:model.Title detailTitle:[NSString stringWithFormat:@"时间:%@ 地点:%@",model.TimeStart,model.Address] thumImage:image ? image : [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.ShareImgurl]]] webpageUrl:[NSString stringWithFormat:@"%@event/%li",zhundaoH5Api,(long)model.ID] withCTR:ctr Withtype:type];
}
- (void)shareWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle thumImage:(UIImage *)thumImage webpageUrl:(NSString *)webpageUrl withCTR:(UIViewController *)ctr Withtype:(NSInteger)type {
    if (![WXApi isWXAppInstalled]) {
        NSLog(@"请移步App Store去下载微信客户端");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先下载微信" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
        [ctr presentViewController:alert animated:YES completion:nil];
        return;;
    }
    if (type == 5) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = detailTitle;
        [message setThumbImage:thumImage];

        // 多媒体消息中包含的网页数据对象
        WXWebpageObject *webpageObject = [WXWebpageObject object];
        // 网页的url地址
        webpageObject.webpageUrl = webpageUrl;
        message.mediaObject = webpageObject;

        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneSession;

        [WXApi sendReq:req completion:nil];
    } else {
        // 创建分享内容
        WXMediaMessage *message = [WXMediaMessage message];
        // 多媒体消息中包含的图片数据对象
        WXImageObject *imageObject = [WXImageObject object];
        imageObject.imageData = UIImageJPEGRepresentation(thumImage, 1);
        message.mediaObject = imageObject;
        
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = NO;
        sendReq.message = message;
    //    sendReq.scene = WXSceneTimeline;// 分享到朋友圈
        sendReq.scene = WXSceneSession;// 分享到微信
        [WXApi sendReq:sendReq completion:nil];
    }
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
