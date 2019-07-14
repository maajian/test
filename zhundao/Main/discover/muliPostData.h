//
//  muliPostData.h
//  zhundao
//
//  Created by zhundao on 2017/6/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^updataBlock) (BOOL isSuccess);

@interface muliPostData : NSObject

@property(nonatomic,copy)updataBlock updataBlock;

- (void)postWithView :(UIView *)view isShow :(BOOL)isShow acckey:(NSString *)acckey;

@end
