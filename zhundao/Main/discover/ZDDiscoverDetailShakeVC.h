//
//  ZDDiscoverDetailShakeVC.h
//  zhundao
//
//  Created by zhundao on 2017/2/14.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"
typedef void(^popBolck) (NSDictionary *popdic);
typedef void(^jiebangBlock)(BOOL  issuccess);
@interface ZDDiscoverDetailShakeVC : ZDBaseVC
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,copy)popBolck block;
@property(nonatomic,strong)NSString *DeviceId;
@property(nonatomic,copy)jiebangBlock jiebangBlock;
@end
