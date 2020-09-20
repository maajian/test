//
//  ZDActivityViewModel.h
//  zhundao
//
//  Created by maj on 2019/6/30.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ActivityCell.h"

typedef NS_ENUM(NSInteger, ZDActivityType) {
    ZDActivityTypeAll,
    ZDActivityTypeOn,
    ZDActivityTypeClose
};

NS_ASSUME_NONNULL_BEGIN

@interface ZDActivityViewModel : NSObject
// 初始化
- (instancetype)initWithType:(ZDActivityType)activityType;

- (void)getAllActivityListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Str)failure;
- (void)getOnActivityListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Str)failure;
- (void)getCloseActivityListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Str)failure;

// 检查是否可以发起活动
- (void)checkIsCanpost:(ZDBlock_ID)successBlock error:(ZDBlock_Error)errorBlock;
// 获取消息个数
- (void)getMeMessageListSuccess:(ZDBlock_Int)success failure:(ZDBlock_Error_Str)failure;

// 正常显示的数据源
@property (nonatomic, strong) NSMutableArray *allDataArray;
@property (nonatomic, strong) NSMutableArray *onDataArray;
@property (nonatomic, strong) NSMutableArray *closeDataArray;

// 搜索的数据源
@property (nonatomic, strong) NSMutableArray *allSearchArray;
@property (nonatomic, strong) NSMutableArray *onSearchArray;
@property (nonatomic, strong) NSMutableArray *closeSearchArray;

@property (nonatomic, strong) NSMutableArray *allTitleArray;
@property (nonatomic, strong) NSMutableArray *onTitleArray;
@property (nonatomic, strong) NSMutableArray *closeTitleArray;

@end

NS_ASSUME_NONNULL_END
