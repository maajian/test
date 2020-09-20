//
//  ZDDiscoverFaceDetailVC.h
//  zhundao
//
//  Created by zhundao on 2017/7/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"
typedef void(^faceBlock) (BOOL ischange);
@class ZDDiscoverFaceModel;
@interface ZDDiscoverFaceDetailVC : ZDBaseVC
@property(nonatomic,strong)ZDDiscoverFaceModel *model;
@property(nonatomic,copy)faceBlock faceBlock;
@end
