//
//  ActivityModel.h
//  zhundao
//
//  Created by zhundao on 2016/12/6.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
//ActivityFees =     (
//);
//ActivityGenre = 0;
//ActivityOptions = "<null>";
//AddTime = "2016-12-01T18:16:13.717";
//Address = "\U676d\U5dde";
//Alert = 0;
//Amount = 0;
//BackImgurl = "http://joinheadoss.img-cn-hangzhou.aliyuncs.com/qinglong/Static/zhundao/img/bg/1.jpg";
//Content = "<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\U8fbe\U5230\n &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>";
//ExtraUserInfo = 3;
//Fee = 0;
//HasJoinNum = 0;
//HideList = 0;
//ID = 3563;
//IsDeleted = 0;
//IsPublic = 1;
//Lat = 0;
//Lng = 0;
//PassCode = "<null>";
//SendSms = 0;
//ShareImgurl = "http://joinheadoss.img-cn-hangzhou.aliyuncs.com/qinglong/Static/zhundao/img/bg/1.jpg";
//Status = 0;
//TimeStart = "2016-12-08T18:15:00";
//TimeStop = "2016-12-07T18:15:00";
//TimeSure = "2016-12-01T18:16:19.057";
//Title = "\U6d4b\U8bd5\U6cd5";
//UserID = 4;
//UserInfo = "100,101";
//UserLimit = 0;
//UserType = "<null>";
@interface ActivityModel : NSObject

@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *Content;
@property(nonatomic,copy)NSString *Address;
@property(nonatomic,copy)NSString *ShareImgurl;
@property(nonatomic,copy)NSString *TimeStart;
@property(nonatomic,copy)NSString *TimeStop;

@property(nonatomic,assign)float Amount;
@property(nonatomic,assign)NSInteger Status;
@property(nonatomic,assign)NSInteger HasJoinNum;
@property(nonatomic,assign)NSInteger ID;

@end
