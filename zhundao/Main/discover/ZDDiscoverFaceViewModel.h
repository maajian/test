//
//  ZDDiscoverFaceViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/7/21.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^listBlock) (NSArray *dataArray);
@interface ZDDiscoverFaceViewModel : NSObject
//获取设备列表
- (void)getListWithBlock :(listBlock)liBlock;







- (void)saveData:(NSArray *)array ;

- (NSArray *)getData;

@end
