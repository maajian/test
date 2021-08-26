//
//  ZDActivityOptionModel.h
//  zhundao
//
//  Created by maj on 2021/3/29.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//ID = 109;
//InputType = 0;
//IsCheck = 0;
//Required = 0;
//Title = "\U5907\U6ce8";

@interface ZDActivityOptionModel : NSObject<NSMutableCopying, NSCopying>
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) BOOL Required;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, assign) BOOL IsCheck; // 是否勾选

@end

NS_ASSUME_NONNULL_END
