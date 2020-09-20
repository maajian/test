//
//  PGActivityConsultModel.h
//  zhundao
//
//  Created by zhundao on 2017/8/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGActivityConsultModel : NSObject<NSCoding>
/*! 添加时间 */
@property(nonatomic,copy)NSString *AddTime;
/*! 回复 */
@property(nonatomic,copy)NSString *Answer;
/*! 头像 */
@property(nonatomic,copy)NSString *HeadImgurl;
/*! 昵称 */
@property(nonatomic,copy)NSString *NickName;
/*! 问题 */
@property(nonatomic,copy)NSString *Question;
/*! 咨询id */
@property(nonatomic,assign)NSInteger ID;
/*! 是否推荐 */
@property(nonatomic,assign)NSInteger IsRecommend;
/*! 是否回复 */
@property(nonatomic,assign)NSInteger IsReply;
/*! 活动名称 */
@property(nonatomic,copy)NSString *Title;
/*! 手机号 */
@property(nonatomic,copy)NSString *Phone;


@end
