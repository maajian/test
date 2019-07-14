//
//  ContactModel.h
//  zhundao
//
//  Created by zhundao on 2017/5/23.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
//{
//    AddTime = "2016-10-17T21:33:14.8";
//    Address = "<null>";
//    AdminUserID = 55;
//    Company = "\U676d\U5dde\U51c6\U5230\U4fe1\U606f\U79d1\U6280\U6709\U9650\U516c\U53f8";
//    ContactGroupID = 13;
//    Duty = CEO;
//    Email = "cheny@zhundao.net";
//    GroupName = "\U6211\U7684\U540c\U4e8b";
//    HeadImgurl = "http://wx.qlogo.cn/mmopen/rKBCaRcVshMuAxIkUFdsBdMDgNluNq4Rx5xaDGt2TJxGNic4SiagEtuWBBkI4P7gnIRlklt8aZKdiazwfnKHr4UaXds5MAgEuQz/0";
//    ID = 1244;
//    IDcard = "<null>";
//    IsDeleted = 0;
//    Mobile = 18905714138;
//    Remark = "<null>";
//    SerialNo = "<null>";
//    Sex = 1;
//    TrueName = "\U9648\U6d0b";
//    UserID = 55;
//},
@interface ContactModel : NSObject
@property(nonatomic,copy)NSString *HeadImgurl;  //照片
@property(nonatomic,copy)NSString *TrueName;    //姓名
@property(nonatomic,assign)NSInteger ContactGroupID;  //群组id
@property(nonatomic,assign)NSInteger ID;   //人员id
@property(nonatomic,copy)NSString *Address; //地址
@property(nonatomic,copy)NSString *GroupName; //地址
@property(nonatomic,copy)NSString *Company;    //公司
@property(nonatomic,copy) NSString *Mobile;
@property(nonatomic,assign)NSInteger Sex;   //身份证
@property(nonatomic,copy)NSString *Duty;    //职务
@property(nonatomic,copy)NSString *Email;    //邮箱
@property(nonatomic,copy)NSString *Remark;    //备注
@property(nonatomic,copy)NSString *SerialNo;    //编号
@property(nonatomic,copy)NSString *IDcard;   //身份证

//@property(nonatomic,copy)NSString *AddTime;  
//@property(nonatomic,assign)NSInteger AdminUserID;
//@property(nonatomic,assign)NSInteger IsDeleted;
//@property(nonatomic,assign)NSInteger UserID;
@end
