//
//  PGActivityPrintVcodeVM.h
//  zhundao
//
//  Created by zhundao on 2017/7/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PGActivityListModel.h"
@interface PGActivityPrintVcodeVM : NSObject
- (NSMutableArray *)getID :(NSArray * )nowArray model:(PGActivityListModel *)model;

- (NSArray *)getNameArray;
@end
