//
//  ZDDiscoverPrintView.h
//  zhundao
//
//  Created by zhundao on 2017/7/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sureBlock)(int begin ,int end);


@interface ZDDiscoverPrintView : UIView

@property(nonatomic,copy)sureBlock block;

- (instancetype)initWithFirstIndex :(NSInteger )index;
- (void)comeIn;
@end
