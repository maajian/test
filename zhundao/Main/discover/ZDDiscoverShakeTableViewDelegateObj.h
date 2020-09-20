//
//  ZDDiscoverShakeTableViewDelegateObj.h
//  zhundao
//
//  Created by zhundao on 2017/2/14.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZDDiscoverDetailModel.h"


@protocol detailModelDelegate <NSObject>

- (void)selectIndex :(NSIndexPath *)indexPath;

@end

@interface ZDDiscoverShakeTableViewDelegateObj : NSObject<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)ZDDiscoverDetailModel *model;

@property(nonatomic,copy)NSDictionary  *datadic;
@property(nonatomic,weak) id<detailModelDelegate>  detailModelDelegate;
+(instancetype)createTableViewDelegateWithDataList:(ZDDiscoverDetailModel *)model
                                          withdic :(NSDictionary *)dic;
@end
