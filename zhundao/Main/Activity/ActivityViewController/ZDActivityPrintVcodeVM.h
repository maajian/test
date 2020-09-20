//
//  ZDActivityPrintVcodeVM.h
//  zhundao
//
//  Created by zhundao on 2017/7/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZDActivityListModel.h"
@interface ZDActivityPrintVcodeVM : NSObject
- (NSMutableArray *)getID :(NSArray * )nowArray model:(ZDActivityListModel *)model;

- (NSArray *)getNameArray;
@end
