//
//  PGActivityChooseBigImageViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/10/24.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGActivityChooseBigImageViewModel : NSObject

- (NSMutableArray *)heightForCell :(NSArray *) array;

/*! 高度 */
- (NSInteger)heightForRowAtIndexPath:(NSIndexPath *)indexPath
                              isPost:(BOOL)isPost
                         heightArray:(NSArray *)heightArray;

@end
