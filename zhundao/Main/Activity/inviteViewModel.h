//
//  inviteViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/8/29.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface inviteViewModel : NSObject

/*! 画图 */
- (void)drawImage :(UIImageView *)imageview
           image1 :(UIImage *)image1
           image2 :(UIImage *)image2
           acName :(NSString *)acName
          timeStr :(NSString *)timeStr
          address :(NSString *)address
            index :(NSInteger)index;

/*! 获取时间 */
- (NSString *)getTime :(NSString *)timeStr;

/*! 保存图片 */
- (void)savaImageToSanBox :(NSInteger)acID image :(UIImage *)image index :(NSInteger)index;
/*! 获取图片 */
- (void)getImageFromSanbox:(NSInteger)acID imageArray :(NSMutableArray *)imageArray;
@end
