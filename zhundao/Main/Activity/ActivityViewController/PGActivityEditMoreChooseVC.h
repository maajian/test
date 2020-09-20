//
//  PGActivityEditMoreChooseVC.h
//  zhundao
//
//  Created by zhundao on 2017/6/21.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGBaseVC.h"
typedef void(^strBlock) (NSString *backStr);
@interface PGActivityEditMoreChooseVC : PGBaseVC
@property(nonatomic,copy)NSArray *allDataArray ;

@property(nonatomic,copy)NSArray *nowDataArray ;

@property(nonatomic,assign)BOOL isMoreChoose;

@property(nonatomic,copy)strBlock strBlock;

@property(nonatomic,assign) BOOL isMust;
@end
