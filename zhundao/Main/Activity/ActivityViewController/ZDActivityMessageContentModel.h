//
//  ZDActivityMessageContentModel.h
//  zhundao
//
//  Created by zhundao on 2017/11/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZDMessageStatusType) {
    ZDMessageStatusTypeSuccess,
    ZDMessageStatusTypeFail,
    ZDMessageStatusTypeCheck
};

@interface ZDActivityMessageContentModel : NSObject

/*! 文案ID */
@property (nonatomic, assign) NSInteger ID;
/*! 内容 */
@property (nonatomic, copy) NSString *es_content;
// 失败文字
@property (nonatomic, copy) NSString *Reason;
// 审核结果
@property (nonatomic, assign) ZDMessageStatusType messageStatusType;

- (instancetype)initWithDic:(NSDictionary *)dic;

// 系统模版 or 自定义模版
@property (nonatomic, assign) BOOL isSystem;
// 高度
@property (nonatomic, assign) CGFloat cellHeight;


@end
