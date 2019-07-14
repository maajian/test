//
//  BigImageFlowLayout.m
//  zhundao
//
//  Created by zhundao on 2017/10/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BigImageFlowLayout.h"
/*! 间距为10 */
static const CGFloat itemSpace = 10;

static const CGFloat itemHeight = 70;

@implementation BigImageFlowLayout

- (instancetype)init{
    if (self = [super init]) {
        self.itemSize = CGSizeMake((kScreenWidth- 4*itemSpace - 1)/3, itemHeight);
        self.minimumInteritemSpacing = itemSpace;
        self.minimumLineSpacing = itemSpace/2;
        self.sectionInset =UIEdgeInsetsMake(0, itemSpace, 0, itemSpace);
        self.headerReferenceSize = CGSizeMake(kScreenWidth, 40);
    }
    return self;
}

@end
