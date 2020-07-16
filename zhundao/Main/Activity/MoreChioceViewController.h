//
//  MoreChioceViewController.h
//  zhundao
//
//  Created by zhundao on 2017/4/12.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"
typedef void(^BackBlock) (NSDictionary *dic,NSString *smallStr,BOOL isPost);
@interface MoreChioceViewController : ZDBaseVC

@property(nonatomic,strong)NSArray *optionsArray;

@property(nonatomic,copy)BackBlock block;

@property(nonatomic,strong)NSDictionary  *datadic;

@property(nonatomic,strong)NSString *imageStr;
/*! 小图是否为上传 */
@property(nonatomic,assign)BOOL isSmallPost;

@end
