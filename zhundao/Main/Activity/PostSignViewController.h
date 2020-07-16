//
//  PostSignViewController.h
//  zhundao
//
//  Created by zhundao on 2017/3/24.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"

typedef void(^bacBlock) (BOOL ischange);
typedef void(^deleteBlock)(BOOL isDelete);
typedef void(^postBlock) (BOOL isSuccess);
@interface PostSignViewController : ZDBaseVC
@property(nonatomic,strong)NSString *activityName;
@property(nonatomic,assign)NSInteger acID;
@property(nonatomic,strong)NSArray *dataArray1;  //内容数组
@property(nonatomic,assign)NSInteger selectIndex; //选中的index
@property(nonatomic,assign)NSInteger signID;
@end
