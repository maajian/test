//
//  PGSignInOnePersonDataNetWork.h
//  zhundao
//
//  Created by zhundao on 2017/4/14.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^backpopBlock) (NSArray *backArray);
@interface PGSignInOnePersonDataNetWork : NSObject
- (void)getNewList :(NSInteger)listID BackBlock :(backpopBlock)backBlock ;
@end
