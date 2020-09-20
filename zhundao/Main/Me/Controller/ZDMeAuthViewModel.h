//
//  ZDMeAuthViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/9/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^authBlock) (BOOL isSuccess);
@interface ZDMeAuthViewModel : NSObject

/*! 认证 */
- (void)postAuthentication :(NSDictionary *)dic authBlock :(authBlock)authBlock;

- (void)GetAuthorInfo;
@end
