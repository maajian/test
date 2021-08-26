//
//  ZDSignInModel.h
//  zhundao
//
//  Created by maj on 2019/7/28.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDSignInModel : NSObject<NSCoding,NSCopying>
@property(nonatomic,copy)NSString *Name;   //名字
@property(nonatomic,copy)NSString *ActivityName;   //名字
@property(nonatomic,assign)NSInteger CheckInType;  //签到类型  默认0 到场签到   1离场签退  2 集合签到
@property(nonatomic,copy)NSString *AddTime;//时间
@property(nonatomic,assign)NSInteger Status;   //进行中还是已结束
@property (nonatomic,assign)NSInteger NumShould;   //  报名人数
@property (nonatomic,assign)NSInteger NumFact;   //   实际签到人数
@property(nonatomic,assign)NSInteger SignObject;  // ("签到对象：默认0，仅限报名表用户  1 不限报名人员 ")]
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,assign)NSInteger ActivityID;

@end

NS_ASSUME_NONNULL_END
