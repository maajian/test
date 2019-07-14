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
@property(nonatomic,copy)NSString *EndTime;
@property(nonatomic,copy)NSString *StartTime;
@property(nonatomic,assign)float Amount;
@property(nonatomic,assign)NSInteger Status;
@property(nonatomic,assign)NSInteger UserLimit;
@property(nonatomic,assign)NSInteger HasJoinNum;
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,assign)NSInteger ClickNo;
@property(nonatomic,strong)NSArray *ActivityFees;
@property(nonatomic,assign)NSInteger Alert;
@property(nonatomic,copy)NSString *BackImgurl;
@property(nonatomic,copy)NSString *ExtraUserInfo;
@property(nonatomic,copy)NSString *UserInfo;
@property(nonatomic,assign)NSInteger Fee;
@property(nonatomic,assign)NSInteger HideInfo;
//@property(nonatomic,assign)NSInteger iD;
@property(nonatomic,assign)NSInteger UserID;
@property(nonatomic,assign)double Lat;
@property(nonatomic,assign)double Lng;
@property (nonatomic, assign) NSInteger MinPeople;
@property (nonatomic, assign) NSInteger MaxPeople;
/*! 是否为团体报名 */
@property(nonatomic,assign)NSInteger ActivityGenre;
@end
