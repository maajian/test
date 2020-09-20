//
//  ZDAvtivityInviteViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/8/29.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDAvtivityInviteViewModel.h"
#import "Time.h"
@implementation ZDAvtivityInviteViewModel


- (void)drawImage :(UIImageView *)imageview image1 :(UIImage *)image1  image2 :(UIImage *)image2 acName :(NSString *)acName timeStr :(NSString *)timeStr address :(NSString *)address index :(NSInteger)index{
    if([[UIScreen mainScreen] scale] == 2.0){      // @2x
        UIGraphicsBeginImageContextWithOptions(imageview.frame.size, NO, 2.0);
    }else if([[UIScreen mainScreen] scale] == 3.0){ // @3x ( iPhone 6plus 、iPhone 6s plus)
        UIGraphicsBeginImageContextWithOptions(imageview.frame.size, NO, 3.0);
    }else{
        UIGraphicsBeginImageContext(imageview.frame.size);
    }
    [image1 drawInRect:imageview.frame];
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    switch (index) {
        case 0:
        {
            CGSize size = [acName boundingRectWithSize:CGSizeMake(0.8*kScreenWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont boldSystemFontOfSize:17],NSKernAttributeName :@0.1f} context:nil].size;
            [acName drawInRect:CGRectMake((kScreenWidth-size.width)/2, 0.42*kScreenHeight, size.width, size.height) withAttributes:@{NSFontAttributeName :[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName :[UIColor whiteColor],NSKernAttributeName :@0.1f,NSParagraphStyleAttributeName : paragraphStyle}];
            
            UIImage *whiteImage = [self imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(0.42*kScreenWidth, 0.42*kScreenWidth)];
            [whiteImage  drawInRect:CGRectMake(kScreenWidth/2-0.19*kScreenWidth, 0.5125 *kScreenHeight, 0.38*kScreenWidth, 0.38*kScreenWidth)];
            [image2  drawInRect:CGRectMake(kScreenWidth/2- 0.18*kScreenWidth, 0.52 *kScreenHeight, 0.36*kScreenWidth, 0.36*kScreenWidth)];
            
            timeStr = [@"时间 : " stringByAppendingString:timeStr ];
            [timeStr drawInRect:CGRectMake(30, 0.82 *kScreenHeight, kScreenWidth-60, 30) withAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName :[UIFont systemFontOfSize:11]}];
            address = [@"地点 : " stringByAppendingString:address ];
            [address drawInRect:CGRectMake(30, 0.85 *kScreenHeight, kScreenWidth-60, 30) withAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName :[UIFont systemFontOfSize:11]}];
            imageview.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
            break;
        case 1:
        {
            CGSize size = [acName boundingRectWithSize:CGSizeMake(0.8*kScreenWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont boldSystemFontOfSize:19],NSKernAttributeName :@0.1f} context:nil].size;
            [acName drawInRect:CGRectMake((kScreenWidth-size.width)/2, 0.09*kScreenHeight, size.width, size.height) withAttributes:@{NSFontAttributeName :[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName :kColorA(0, 79, 155, 1),NSKernAttributeName :@0.1f,NSParagraphStyleAttributeName : paragraphStyle}];
            CGSize timeSize =[timeStr boundingRectWithSize:CGSizeMake(kScreenWidth, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :KweixinFont(15),NSKernAttributeName :@0.1f} context:nil].size;
            [timeStr drawInRect:CGRectMake((kScreenWidth-timeSize.width)/2, 0.565*kScreenHeight, timeSize.width, 30) withAttributes:@{NSFontAttributeName :KweixinFont(15),NSKernAttributeName :@0.1f,NSForegroundColorAttributeName :kColorA(254, 255, 13, 1),NSParagraphStyleAttributeName : paragraphStyle}];
            CGSize addsizeSize =[address boundingRectWithSize:CGSizeMake(kScreenWidth, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :KweixinFont(15),NSKernAttributeName :@0.1f} context:nil].size;
            [address drawInRect:CGRectMake((kScreenWidth-addsizeSize.width)/2, 0.66*kScreenHeight, addsizeSize.width, 15) withAttributes:@{NSFontAttributeName :KweixinFont(13),NSKernAttributeName :@0.1f,NSForegroundColorAttributeName :kColorA(254, 255, 13, 1),NSParagraphStyleAttributeName : paragraphStyle}];
            UIImage *whiteImage = [self imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(0.32*kScreenWidth, 0.32*kScreenWidth)];
            [whiteImage  drawInRect:CGRectMake(kScreenWidth/2-0.16*kScreenWidth, 0.705 *kScreenHeight, 0.32*kScreenWidth, 0.32*kScreenWidth)];
            [image2  drawInRect:CGRectMake(kScreenWidth/2-0.15*kScreenWidth, 0.71 *kScreenHeight, 0.3*kScreenWidth, 0.3*kScreenWidth)];
            imageview.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
            break;
        case 2:
        {
            CGSize size = [acName boundingRectWithSize:CGSizeMake(0.8*kScreenWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :KweixinFont(22),NSKernAttributeName :@0.1f} context:nil].size;
            [acName drawInRect:CGRectMake((kScreenWidth-size.width)/2, 0.36*kScreenHeight, size.width, size.height) withAttributes:@{NSFontAttributeName :KweixinFont(22),NSForegroundColorAttributeName :kColorA(244, 243, 115, 1),NSKernAttributeName :@0.1f,NSParagraphStyleAttributeName : paragraphStyle}];
            UIImage *whiteImage = [self imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(0.36*kScreenWidth, 0.36*kScreenWidth)];
            [whiteImage  drawInRect:CGRectMake(kScreenWidth/2-0.18*kScreenWidth, 0.495 *kScreenHeight, 0.36*kScreenWidth, 0.36*kScreenWidth)];
            [image2  drawInRect:CGRectMake(kScreenWidth/2-0.17*kScreenWidth, 0.50 *kScreenHeight, 0.34*kScreenWidth, 0.34*kScreenWidth)];
            timeStr = [@"时间 : " stringByAppendingString:timeStr ];
            [timeStr drawInRect:CGRectMake(40, 0.74 *kScreenHeight, kScreenWidth-60, 30) withAttributes:@{NSForegroundColorAttributeName : kColorA(244, 213, 140, 1),NSFontAttributeName :[UIFont boldSystemFontOfSize:14]}];
            address = [@"地点 : " stringByAppendingString:address ];
            [address drawInRect:CGRectMake(40, 0.78 *kScreenHeight, kScreenWidth-60, 30) withAttributes:@{NSForegroundColorAttributeName : kColorA(244, 213, 140, 1),NSFontAttributeName :[UIFont boldSystemFontOfSize:14]}];
            /*! 添加渐变层 */
            [self createCAGradientLayer:CGRectMake(0 ,0, kScreenWidth ,kScreenHeight) imageView:imageview];
            imageview.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
            break;
        default:
            break;
    }
}
/*! 创建渐变层 */
- (void)createCAGradientLayer :(CGRect)rect imageView :(UIImageView *)imageView
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = rect;
    layer.colors = @[(id)[UIColor redColor].CGColor,
                             (id)[UIColor yellowColor].CGColor,
                             (id)[UIColor blueColor].CGColor];
    layer.locations = @[@(0.3f),@(0.7f)];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint  = CGPointMake(1, 1);
    [imageView.layer addSublayer:layer];
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



- (void)savaImageToSanBox :(NSInteger)acID image :(UIImage *)image index :(NSInteger)index{
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:[NSString stringWithFormat:@"%li-%li.png",acID,index+1]];
        [UIImageJPEGRepresentation(image, 1) writeToFile:path atomically:YES];
}

- (void)getImageFromSanbox:(NSInteger)acID imageArray :(NSMutableArray *)imageArray{
    for (NSInteger i = 0; i<3 ; i++) {
        UIImage *image = [UIImage imageWithContentsOfFile:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:[NSString stringWithFormat:@"%li-%li.png",acID,i+1]]];
        [imageArray addObject:image];
    }
}

- (NSString *)getTime :(NSString *)timeStr{
    Time *time = [Time bringWithTime:timeStr];
    return time.timeStr;
}




@end
