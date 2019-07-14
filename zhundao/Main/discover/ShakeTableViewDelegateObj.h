//
//  ShakeTableViewDelegateObj.h
//  zhundao
//
//  Created by zhundao on 2017/2/14.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "detailModel.h"


@protocol detailModelDelegate <NSObject>

- (void)selectIndex :(NSIndexPath *)indexPath;

@end

@interface ShakeTableViewDelegateObj : NSObject<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)detailModel *model;

@property(nonatomic,copy)NSDictionary  *datadic;
@property(nonatomic,weak) id<detailModelDelegate>  detailModelDelegate;
+(instancetype)createTableViewDelegateWithDataList:(detailModel *)model
                                          withdic :(NSDictionary *)dic;
@end
