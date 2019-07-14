//
//  FaceModel.h
//  zhundao
//
//  Created by zhundao on 2017/7/21.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FaceModel : NSObject<NSCoding>

@property(nonatomic,copy)NSString *Name;

@property(nonatomic,copy)NSString *deviceKey;

@property(nonatomic,assign)NSInteger stock;

@property(nonatomic,strong)NSString *checkInName ;

@property(nonatomic,assign)NSInteger checkInId;
@end
