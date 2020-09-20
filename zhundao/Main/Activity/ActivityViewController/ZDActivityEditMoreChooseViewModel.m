//
//  ZDActivityEditMoreChooseViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/6/21.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDActivityEditMoreChooseViewModel.h"

@implementation ZDActivityEditMoreChooseViewModel

- (NSMutableArray *)getIndexArrayFromArray :(NSArray *)nowArray allArray :(NSArray *)allArray
{
    NSMutableArray *indexArray = [NSMutableArray array];
    for (int i = 0; i< allArray.count; i++) {
        [indexArray addObject:@"0"];
    }
    for (int i = 0; i < nowArray .count; i++) {
        for ( int j = 0; j <allArray.count; j++) {
            if ([nowArray[i] isEqualToString:allArray[j]]) {
                [indexArray replaceObjectAtIndex:j withObject:@"1"];
                break;
            }
        }
    }
    return indexArray;
}



@end
