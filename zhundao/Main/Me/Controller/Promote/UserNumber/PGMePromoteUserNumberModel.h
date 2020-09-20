//
//  PGMePromoteUserNumberModel.h
//  zhundao
//
//  Created by maj on 2020/1/8.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGMePromoteUserNumberModel : NSObject
@property (nonatomic, copy) NSString *HeadImgurl;
@property (nonatomic, copy) NSString *TrueName;
@property (nonatomic, assign) NSInteger UserId;
@property (nonatomic, assign) NSInteger GradeId;
@property (nonatomic, copy) NSString *AddTime;
@property (nonatomic, copy) NSString *NickName;

@end

NS_ASSUME_NONNULL_END
