//
//  PrintVcodeVM.h
//  zhundao
//
//  Created by zhundao on 2017/7/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "listModel.h"
@interface PrintVcodeVM : NSObject
- (NSMutableArray *)getID :(NSArray * )nowArray model:(listModel *)model;

- (NSArray *)getNameArray;
@end
