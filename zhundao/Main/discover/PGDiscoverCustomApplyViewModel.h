//
//  PGDiscoverCustomApplyViewModel.h
//  zhundao
//
//  Created by maj on 2018/12/1.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PGDiscoverCustomApplyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGDiscoverCustomApplyViewModel : NSObject
// 数据源
@property (nonatomic, strong) NSMutableArray<PGDiscoverCustomApplyModel *> *dataArray;
/*! 搜索数据源 */
@property (nonatomic, strong) NSMutableArray<PGDiscoverCustomApplyModel *> *titleArray;
/*! 所有名字 */
@property (nonatomic, strong) NSMutableArray<NSString *> *allTitleArray;

// 获取自定义报名项列表
- (void)getCustomApplyList:(kZDCommonSucc)success fail:(kZDCommonFail)fail;
// 隐藏显示报名项
- (void)hideOrShowList:(BOOL)hidden ID:(NSInteger)ID success:(kZDCommonSucc)success fail:(kZDCommonFail)fail;

@end

NS_ASSUME_NONNULL_END
