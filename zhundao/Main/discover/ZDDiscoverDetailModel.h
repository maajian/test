//
//  ZDDiscoverDetailModel.h
//  zhundao
//
//  Created by zhundao on 2017/2/14.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDDiscoverDetailModel : NSObject
@property(nonatomic,strong)NSString *IconUrl;
@property(nonatomic,strong)NSString *BeaconName;
@property(nonatomic,strong)NSString *BeaconID;
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,strong)NSString *NickName;
@property(nonatomic,strong)NSString *DeviceId;
@property (nonatomic, copy) NSString *Title;
@property(nonatomic,strong)NSString *BindTime;

@end
