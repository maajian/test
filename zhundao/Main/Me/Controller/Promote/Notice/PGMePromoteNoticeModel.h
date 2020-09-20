//
//  PGMePromoteNoticeModel.h
//  zhundao
//
//  Created by maj on 2020/1/7.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGMePromoteNoticeModel : NSObject
@property (nonatomic, copy) NSString *Detail;
@property (nonatomic, copy) NSString *AddTime;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *Img;
@property (nonatomic, assign) NSInteger ID;
 
@end

NS_ASSUME_NONNULL_END
