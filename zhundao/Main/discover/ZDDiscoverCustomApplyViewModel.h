//
//  ZDDiscoverCustomApplyViewModel.h
//  zhundao
//
//  Created by maj on 2018/12/1.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZDDiscoverCustomApplyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDDiscoverCustomApplyViewModel : NSObject
// 数据源
@property (nonatomic, strong) NSMutableArray<ZDDiscoverCustomApplyModel *> *dataArray;
/*! 搜索数据源 */
@property (nonatomic, strong) NSMutableArray<ZDDiscoverCustomApplyModel *> *titleArray;
/*! 所有名字 */
@property (nonatomic, strong) NSMutableArray<NSString *> *allTitleArray;

// 获取自定义报名项列表
- (void)getCustomApplyList:(kZDCommonSucc)success fail:(kZDCommonFail)fail;
// 隐藏显示报名项
- (void)hideOrShowList:(BOOL)hidden ID:(NSInteger)ID success:(kZDCommonSucc)success fail:(kZDCommonFail)fail;
// 删除报名项
- (void)deleteItemWithID:(NSInteger)ID success:(kZDCommonSucc)success fail:(kZDCommonFail)fail;

@end

NS_ASSUME_NONNULL_END
