//
//  ZDDiscoverCustomModel.h
//  zhundao
//
//  Created by zhundao on 2017/1/16.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDDiscoverCustomModel : NSObject
@property(nonatomic,strong)NSString *Title;
@property(nonatomic,assign)NSInteger Required;
@property(nonatomic,assign)NSInteger InputType;
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,strong)NSString *Option;
/*! 自定义相是否隐藏 */
@property (nonatomic, assign) BOOL Hidden;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
