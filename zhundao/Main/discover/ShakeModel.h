//
//  ShakeModel.h
//  zhundao
//
//  Created by zhundao on 2017/2/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShakeModel : NSObject
@property(nonatomic,strong)NSString *BeaconID;
@property(nonatomic,assign)NSInteger ID;


@property(nonatomic,strong)NSString *BeaconName;
@property(nonatomic,strong)NSString *Title;
@property(nonatomic,strong)NSString *IconUrl;
@property(nonatomic,strong)NSString *DeviceId;


@property(nonatomic,strong)NSString *AddTime;
@property(nonatomic,strong)NSString *Description;
@property(nonatomic,strong)NSString *NickName;
@end
