//
//  PGSignInViewModel.h
//  zhundao
//
//  Created by maj on 2019/7/28.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PGSignype) {
    PGSignypeAll,
    PGSignypeOn,
    PGSignypeClose
};

@interface PGSignInViewModel : NSObject

// 初始化
- (instancetype)initWithType:(PGSignype)signType;

- (void)getAllSignListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Void)failure;
- (void)getOnSignListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Void)failure;
- (void)getCloseSignListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Void)failure;

// 正常显示的数据源
@property (nonatomic, strong) NSMutableArray *allDataArray;
@property (nonatomic, strong) NSMutableArray *onDataArray;
@property (nonatomic, strong) NSMutableArray *closeDataArray;

// 搜索的数据源
@property (nonatomic, strong) NSMutableArray *allSearchArray;
@property (nonatomic, strong) NSMutableArray *onSearchArray;
@property (nonatomic, strong) NSMutableArray *closeSearchArray;

// 标题数组
@property (nonatomic, strong) NSMutableArray *allTitleArray;
@property (nonatomic, strong) NSMutableArray *onTitleArray;
@property (nonatomic, strong) NSMutableArray *closeTitleArray;

@end

NS_ASSUME_NONNULL_END
