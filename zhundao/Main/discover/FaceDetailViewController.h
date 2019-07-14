//
//  FaceDetailViewController.h
//  zhundao
//
//  Created by zhundao on 2017/7/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^faceBlock) (BOOL ischange);
@class FaceModel;
@interface FaceDetailViewController : BaseViewController
@property(nonatomic,strong)FaceModel *model;
@property(nonatomic,copy)faceBlock faceBlock;
@end
