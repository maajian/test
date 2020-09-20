//
//  ZDAvtivityOptions.h
//  zhundao
//
//  Created by zhundao on 2017/4/13.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^netBlock) (NSArray *optionsArray);
@interface ZDAvtivityOptions : NSObject
@property(nonatomic,copy)netBlock block;
- (void)networkwithBlock :(netBlock)netBlock;
@end
