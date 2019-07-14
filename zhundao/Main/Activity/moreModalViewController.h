//
//  moreModalViewController.h
//  zhundao
//
//  Created by zhundao on 2017/2/16.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^backBlock) (NSInteger backNumber);

@interface moreModalViewController : BaseViewController

@property(nonatomic,copy)backBlock backBlock;

@property(nonatomic,strong)ActivityModel *moreModel;

@end
