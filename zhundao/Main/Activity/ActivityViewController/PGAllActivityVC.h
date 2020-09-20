//
//  PGAllActivityVC.h
//  zhundao
//
//  Created by maj on 2019/6/30.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "PGBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGAllActivityVC : PGBaseVC
// 搜索的z字符串
@property (nonatomic, copy) NSString *searchText;
// 是否搜索中
@property (nonatomic, assign) BOOL active;

@end

NS_ASSUME_NONNULL_END
