//
//  ZDActivityEditMoreChooseVC.h
//  zhundao
//
//  Created by zhundao on 2017/6/21.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"
typedef void(^strBlock) (NSString *backStr);
@interface ZDActivityEditMoreChooseVC : ZDBaseVC
@property(nonatomic,copy)NSArray *allDataArray ;

@property(nonatomic,copy)NSArray *nowDataArray ;

@property(nonatomic,assign)BOOL isMoreChoose;

@property(nonatomic,copy)strBlock strBlock;

@property(nonatomic,assign) BOOL isMust;
@end
