//
//  NSObject+block.h
//  zhundao
//
//  Created by zhundao on 2017/10/24.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZDSuccessBlock)( id responseObject);

typedef void(^ZDErrorBlock)(NSError *error);

@interface NSObject (block)

@property(nonatomic,copy)ZDSuccessBlock  ZDSuccessBlock;

@property(nonatomic,copy)ZDErrorBlock ZDErrorBlock;

@end
