//
//  PGDiscoverFaceDetailVC.h
//  zhundao
//
//  Created by zhundao on 2017/7/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGBaseVC.h"
typedef void(^faceBlock) (BOOL ischange);
@class PGDiscoverFaceModel;
@interface PGDiscoverFaceDetailVC : PGBaseVC
@property(nonatomic,strong)PGDiscoverFaceModel *model;
@property(nonatomic,copy)faceBlock faceBlock;
@end
