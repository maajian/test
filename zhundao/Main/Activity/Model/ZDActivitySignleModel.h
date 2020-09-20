//
//  ZDActivitySignleModel.h
//  zhundao
//
//  Created by zhundao on 2016/12/15.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDActivitySignleModel : NSObject
@property(nonatomic,strong)NSString *UserName; //姓名
@property(nonatomic,strong)NSString *Mobile;  //手机
@property(nonatomic,strong)NSString *Company;  //单位
@property(nonatomic,assign)NSInteger Sex;    //性别
@property(nonatomic,strong)NSString *Depart;//部门
@property (nonatomic, copy) NSString *DepartName; // 组织名称
@property(nonatomic,strong)NSString *Industry; //行业
@property(nonatomic,strong)NSString *Duty;  //职务
@property(nonatomic,strong)NSString *IDcard;  //身份证
@property(nonatomic,strong)NSString *Email;   //邮箱
@property(nonatomic,strong)NSString *Remark;   //备注
@property(nonatomic,assign)NSInteger Num;  //参与人数
@property(nonatomic,strong)NSString *Address; //地址

@end
