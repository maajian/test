//
//  LoadallsignModel.h
//  zhundao
//
//  Created by zhundao on 2016/12/20.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadallsignModel : NSObject
//{
//    CheckInWay = 3;
//    HeadImgurl = "http://wx.qlogo.cn/mmopen/rKBCaRcVshNvEHErXAl4jnI0xHLAYiaE4oZyoaiaC5GicowdfemIibOUUqqChhmXbkahb2Z2MB9ZMmKPJrQmeVz8hw/0";
//    Mobile = 18368179002;
//    SignTime = "2016-12-20T11:56:41.443";
//    Status = 1;
//    TrueName = "\U5f90\U5448\U9f99";
//    UserID = 4;
//},
@property (nonatomic,strong)NSString *Mobile;
@property (nonatomic,strong)NSString *SignTime;
@property(nonatomic,strong)NSString *TrueName;
@property(nonatomic,assign)NSInteger Status;
@property (nonatomic,assign )NSInteger UserID;
@property(nonatomic,copy)NSString *VCode;
@end
