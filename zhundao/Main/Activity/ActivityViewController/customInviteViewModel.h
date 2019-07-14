//
//  customInviteViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/10/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface customInviteViewModel : NSObject

/*! 获取邀请函固定项详情 */
- (NSArray *)getInviteFixWithIndex :(NSInteger)index;
/*!  获取邀请函自定义项详情 */
- (NSArray *)getInviteCustomWithIndex :(NSInteger)index;
/*! 获取邀请函背景图片 */
- (UIImage *)getImageWithIndex :(NSInteger)index;

@end
