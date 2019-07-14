//
//  OnePersonDataNetWork.h
//  zhundao
//
//  Created by zhundao on 2017/4/14.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^backBlock) (NSArray *backArray);
@interface OnePersonDataNetWork : NSObject
- (void)getNewList :(NSInteger)listID BackBlock :(backBlock)backBlock ;
@end
