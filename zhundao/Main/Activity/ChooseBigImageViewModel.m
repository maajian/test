//
//  ChooseBigImageViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/10/24.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ChooseBigImageViewModel.h"

@implementation ChooseBigImageViewModel

/*!  获取高度数组 */

- (NSMutableArray *)heightForCell :(NSArray *) array{
    NSMutableArray *heightArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        NSArray *listArray = dic[@"List"];
        NSInteger height = ((listArray.count-1)/3+1)*75+54;
        [heightArray addObject:@(height)];
    }
    return heightArray;
}


@end
