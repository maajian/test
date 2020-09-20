//
//  PGMeGroupViewController.h
//  zhundao
//
//  Created by zhundao on 2017/5/24.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGBaseVC.h"
typedef void(^deleteBlock) (BOOL isDelete);
@interface PGMeGroupViewController : PGBaseVC
@property(nonatomic,copy)deleteBlock deleteBlock;

@end
