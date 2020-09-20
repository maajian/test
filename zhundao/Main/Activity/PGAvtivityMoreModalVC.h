//
//  PGAvtivityMoreModalVC.h
//  zhundao
//
//  Created by zhundao on 2017/2/16.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGBaseVC.h"

typedef void(^backBlock) (NSInteger backNumber);

@interface PGAvtivityMoreModalVC : PGBaseVC

@property(nonatomic,copy)backBlock backBlock;

@property(nonatomic,strong)ActivityModel *moreModel;

@end
