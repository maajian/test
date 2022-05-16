//
//  ZDActivityMoreChioceVC.h
//  zhundao
//
//  Created by maj on 2021/3/30.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "BaseViewController.h"

#import "ZDActivityOptionModel.h"
#import "ZDActivityMoreChioceModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZDChioceBlock) (NSString *imageUrl, NSMutableArray *userArray, NSMutableArray *extraArray, BOOL alert, ZDActivityShowListType showListType);

@interface ZDActivityMoreChioceVC : BaseViewController
// 初始化
- (instancetype)initWithImageUrl:(NSString *)imageUrl
                           alert:(BOOL)alert
                        showList:(NSInteger)showList
                  isEditActivity:(BOOL)isEditActivity
                     configModel:(ZDActivityConfigModel *)configModel
                     chioceBlock:(nonnull ZDChioceBlock)chioceBlock;

@property(nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<ZDActivityMoreChioceModel *> *dataSource;

// 用户option
@property (nonatomic, strong) NSMutableArray<ZDActivityOptionModel *> *userInfoOptionArray;
// 其他自定义option
@property (nonatomic, strong) NSMutableArray<ZDActivityOptionModel *> *extraInfoOptionArray;

@end

NS_ASSUME_NONNULL_END
