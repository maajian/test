//
//  GroupViewController.h
//  zhundao
//
//  Created by zhundao on 2017/5/24.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^deleteBlock) (BOOL isDelete);
@interface GroupViewController : BaseViewController
@property(nonatomic,copy)deleteBlock deleteBlock;

@end
