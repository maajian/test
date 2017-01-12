//
//  signinModel.h
//  zhundao
//
//  Created by zhundao on 2016/12/9.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
//{
//    ActivityID = 3017;      //
//    ActivityName = "\U6d4b\U8bd5\U4ed8\U8d39\U62a5\U540d";
//    AddTime = "2016-11-18T09:44:22.083";
//    CheckInType = 0;
//    CheckInWay = 0;
//    Config = "<null>";
//    ID = 1122;
//    IsDeleted = 0;
//    MyBeaconID = 2;
//    NumFact = 2;
//    NumShould = 3;
//    SignObject = 0;
//    Status = 1;
//    UserID = 4;
//}
@interface signinModel : NSObject
@property(nonatomic,copy)NSString *ActivityName;   //名字
@property(nonatomic,assign)NSInteger CheckInType;  //签到类型  默认0 到场签到   1离场签退  2 集合签到

@property(nonatomic,copy)NSString *AddTime;//时间
@property(nonatomic,assign)NSInteger Status;   //进行中还是已结束
@property (nonatomic,assign)NSInteger NumShould;   //  报名人数
@property (nonatomic,assign)NSInteger NumFact;   //   实际签到人数

@property(nonatomic,assign)NSInteger SignObject;  // ("签到对象：默认0，仅限报名表用户  1 不限报名人员 ")]
@property(nonatomic,assign)NSInteger ID;


@end
