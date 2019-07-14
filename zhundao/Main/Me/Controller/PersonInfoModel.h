//
//  PersonInfoModel.h
//  zhundao
//
//  Created by zhundao on 2017/11/1.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInfoModel : NSObject
/*! 头像 */
@property(nonatomic,copy)NSString *headImgurl;
/*! 姓名 */
@property(nonatomic,copy)NSString *trueName;
/*! 昵称 */
@property(nonatomic,copy)NSString *nickName;
/*! 手机 */
@property(nonatomic,copy)NSString *phone;
/*! 邮箱 */
@property(nonatomic,copy)NSString *email;
/*! 性别 */
@property(nonatomic,assign) NSInteger Sex;
/*! 单位 */
@property(nonatomic,copy)NSString *company;
/*! 行业 */
@property(nonatomic,copy)NSString *industry;
/*! 职务 */
@property(nonatomic,copy)NSString *duty;







@end
