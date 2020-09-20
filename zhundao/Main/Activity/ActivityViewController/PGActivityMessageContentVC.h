//
//  PGActivityMessageContentVC.h
//  zhundao
//
//  Created by zhundao on 2017/11/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGBaseVC.h"
typedef void(^messageContentBlock) (NSString *contentStr);
@interface PGActivityMessageContentVC : PGBaseVC
/*! 签名的文字字数 */
@property(nonatomic,assign)NSInteger signCount;

@property(nonatomic,strong)NSArray *contentArray;
// esid
@property (nonatomic,assign) NSInteger es_id;

@end