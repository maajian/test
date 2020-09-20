//
//  PGAvtivitySignUpModel.h
//  zhundao
//
//  Created by xhkj on 2018/4/24.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGAvtivitySignUpModel : NSObject
/*! 天 */
@property (nonatomic, copy) NSString *date;
/*! 个数 */
@property (nonatomic, assign) NSInteger count;
/*! 项目名称 */
@property (nonatomic, copy) NSString *title;
/*! 项目收入 */
@property (nonatomic, assign) CGFloat amount;

/*! 初始化 */
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
