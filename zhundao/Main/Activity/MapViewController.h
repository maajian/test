//
//  MapViewController.h
//  zhundao
//
//  Created by zhundao on 2017/4/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^selectBlock) (NSString *address);
typedef void(^latblock)(double latitude,double longitude);
@interface MapViewController : BaseViewController
@property(nonatomic,copy)selectBlock block;
@property(nonatomic,copy)latblock latblock;

/*! 经纬度 */
@property(nonatomic,assign)double latitude;
@property(nonatomic,assign)double longitude;

@end
