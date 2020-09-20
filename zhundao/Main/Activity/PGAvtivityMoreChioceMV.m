//
//  PGAvtivityMoreChioceMV.m
//  zhundao
//
//  Created by zhundao on 2017/4/17.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGAvtivityMoreChioceMV.h"

@implementation PGAvtivityMoreChioceMV
- (CGFloat)heightForCellWithImagearr :(NSArray *) array
{
    NSInteger x =0;    //行
    for (int i=0; i<array.count+1; i++) {
        x = i/3;
    }
    return 10 +(x+1) *110;
}
@end
