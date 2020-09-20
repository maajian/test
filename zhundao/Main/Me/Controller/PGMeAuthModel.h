//
//  PGMeAuthModel.h
//  zhundao
//
//  Created by zhundao on 2017/9/26.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGMeAuthModel : NSObject
/*! 姓名 */
@property(nonatomic,strong)NSString *name;
/*! 身份证 */
@property(nonatomic,strong)NSString *idCard;
/*! 手机 */
@property(nonatomic,strong)NSString *mobile;
/*! 背面 */
@property(nonatomic,strong)NSString *idCardBack;
/*! 身份证正面 */
@property(nonatomic,strong)NSString *idCardFront;
 // 状态 
@property(nonatomic,assign)NSInteger status;
@end
