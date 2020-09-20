//
//  ZDActivityListModel.h
//  zhundao
//
//  Created by zhundao on 2016/12/15.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDActivityListModel : NSObject
@property(nonatomic,strong)NSString *UserName;
@property(nonatomic,strong)NSString *AddTime;
@property(nonatomic,strong)NSString *Mobile;
@property(nonatomic,strong)NSString *NickName;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,assign)NSInteger Status;
@property(nonatomic,strong)NSString *VCode;
@property(nonatomic,strong)NSString *AdminRemark;
@property(nonatomic,strong)NSString *Company;
@property(nonatomic,strong)NSString *Depart;
@property(nonatomic,strong)NSString *Sex;
@property(nonatomic,strong)NSString *Duty;
@property(nonatomic,strong)NSString *IDcard;
@property(nonatomic,strong)NSString *Industry;
@property(nonatomic,strong)NSString *Email;
@property(nonatomic,strong)NSString *Address;
@property(nonatomic,copy)NSString *DepartName;

@end
