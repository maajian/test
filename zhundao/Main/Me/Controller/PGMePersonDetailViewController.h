//
//  PGMePersonDetailViewController.h
//  zhundao
//
//  Created by zhundao on 2017/5/25.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^deleteBlock) (BOOL isDelete);
@interface PGMePersonDetailViewController : PGBaseVC
@property(copy,nonatomic)NSArray *dataArray;
@property(nonatomic,assign)NSInteger personID;
@property(nonatomic,copy) deleteBlock block;
@end
