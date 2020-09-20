//
//  ZDMeNoticeModel.h
//  zhundao
//
//  Created by zhundao on 2017/8/15.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDMeNoticeModel : NSObject<NSCoding>
/*! 添加时间 */
@property(nonatomic,copy)NSString *AddTime;
/*! 详情内容 */
@property(nonatomic,copy)NSString *Detail;
/*! 类别名称 */
@property(nonatomic,copy)NSString *SortName;
/*! 文章名称 */
@property(nonatomic,copy)NSString *Title;
/*! 文章id */
@property(nonatomic,assign)NSInteger ID;
@end
