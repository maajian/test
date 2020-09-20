//
//  PGActivityFeeMV.h
//  zhundao
//
//  Created by zhundao on 2017/6/15.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^feeBlock) (NSInteger isChange);
@interface PGActivityFeeMV : NSObject
@property(nonatomic,copy)feeBlock feeBlock;
- (void)netWorkWithID:(NSInteger)feeID;
- (void)sortData:(NSMutableArray *)array;

@end
