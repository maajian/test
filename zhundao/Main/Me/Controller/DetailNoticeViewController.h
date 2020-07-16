//
//  DetailNoticeViewController.h
//  zhundao
//
//  Created by zhundao on 2017/8/15.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"

typedef void(^isLoadBlock)(BOOL isload);

@interface DetailNoticeViewController : ZDBaseVC
/*! 内容 */
@property(nonatomic,copy) NSString   *detail ;
/*! 题目 */
@property(nonatomic,copy) NSString   *detailTitle ;
/*! 文章ID */
@property(nonatomic, assign) NSInteger ID;
/*! AddTime时间 */
@property(nonatomic,copy)NSString *time;
/*! 返回是否需要刷新 */
@property(nonatomic,copy)isLoadBlock  isLoadBlock;

 // 是否推送过来
@property (nonatomic, assign) BOOL isNotificationPush;


@end
