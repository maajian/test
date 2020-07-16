//
//  ZDDiscoverPriviteInviteViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/9/15.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDDiscoverPriviteInviteViewModel : NSObject

/*! 名称 */
- (NSDictionary *)writeNameFromPlist;

/*! 读取背景图 */
- (UIImage *)writeImage :(NSString *)name;

/*! 移除本地存储的邀请函 */
- (void)removePlistWithName:(NSString *)name;



/*! 获取当前选择的邀请函 */
- (NSInteger)getCurrentIndex;
/*! 保存选择的邀请函 */
- (void)savaCurrentIndex:(NSInteger)index;

@end
